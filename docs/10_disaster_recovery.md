# Disaster Recovery Guide

**When your VPS gets suspended at 3am and your business is dying.**

## 🚨 VPS Suspension Reality

### Why VPS Get Suspended (Common Causes)
- **Resource abuse**: Bot consuming too much CPU/memory
- **Traffic spikes**: Sudden viral traffic looks like DDoS
- **Payment failures**: Credit card expired, billing issues
- **False positives**: Automated abuse detection errors
- **ToS violations**: Running prohibited services unknowingly
- **Security compromises**: Your server got hacked and is sending spam

### The Business Impact
- **Revenue stops immediately** (no access to your app)
- **Users can't access service** (reputation damage)
- **Data might be inaccessible** (if backups aren't external)
- **Recovery time**: 24-72 hours minimum (provider response time)

---

## 🛡️ Prevention Strategy

### Multi-Provider Setup (Essential)
```bash
# Primary: DigitalOcean droplet
# Backup: Contabo VPS (different provider)
# Emergency: Railway/Render (managed service)

# Never put all eggs in one basket
```

### Resource Monitoring
```bash
# Add to your app startup script
#!/bin/bash

# CPU usage alert
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | awk -F'%' '{print $1}')
if (( $(echo "$CPU_USAGE > 80" | bc -l) )); then
    curl -X POST "https://api.telegram.org/bot$ALERT_BOT_TOKEN/sendMessage" \
        -d "chat_id=$ADMIN_CHAT_ID" \
        -d "text=🚨 High CPU usage: ${CPU_USAGE}%"
fi

# Memory usage alert
MEMORY_USAGE=$(free | grep Mem | awk '{printf("%.2f", $3/$2 * 100.0)}')
if (( $(echo "$MEMORY_USAGE > 80" | bc -l) )); then
    curl -X POST "https://api.telegram.org/bot$ALERT_BOT_TOKEN/sendMessage" \
        -d "chat_id=$ADMIN_CHAT_ID" \
        -d "text=🚨 High memory usage: ${MEMORY_USAGE}%"
fi

# Disk space alert
DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')
if [ $DISK_USAGE -gt 80 ]; then
    curl -X POST "https://api.telegram.org/bot$ALERT_BOT_TOKEN/sendMessage" \
        -d "chat_id=$ADMIN_CHAT_ID" \
        -d "text=🚨 High disk usage: ${DISK_USAGE}%"
fi
```

### Traffic Rate Limiting
```javascript
// Prevent traffic spikes that trigger suspension
const rateLimit = require('express-rate-limit');

// Global rate limiting
const globalLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 1000, // Limit to 1000 requests per IP per 15 minutes
  message: 'Too many requests, please try again later.',
  standardHeaders: true,
  legacyHeaders: false,
});

// Strict rate limiting for resource-intensive endpoints
const strictLimiter = rateLimit({
  windowMs: 60 * 1000, // 1 minute
  max: 10, // Only 10 requests per minute for heavy operations
  message: 'Rate limit exceeded for this operation.',
});

app.use('/api/', globalLimiter);
app.use('/api/heavy-operation', strictLimiter);
```

---

## 💾 Backup Strategy (CRITICAL)

### Automated Daily Backups
```bash
#!/bin/bash
# backup.sh - Run this daily via cron

# Database backup
pg_dump $DATABASE_URL > /tmp/db_backup_$(date +%Y%m%d).sql

# Application files backup
tar -czf /tmp/app_backup_$(date +%Y%m%d).tar.gz /app

# Upload to external storage (Dropbox/Google Drive/S3)
# Using rclone (install first: curl https://rclone.org/install.sh | sudo bash)
rclone copy /tmp/db_backup_$(date +%Y%m%d).sql dropbox:backups/
rclone copy /tmp/app_backup_$(date +%Y%m%d).tar.gz dropbox:backups/

# Clean up local backups (keep only 3 days)
find /tmp -name "*backup*" -mtime +3 -delete

# Send backup confirmation
curl -X POST "https://api.telegram.org/bot$ALERT_BOT_TOKEN/sendMessage" \
    -d "chat_id=$ADMIN_CHAT_ID" \
    -d "text=✅ Daily backup completed: $(date)"
```

### Environment Variables Backup
```bash
# backup-env.sh - Save your .env files externally
#!/bin/bash

# Encrypt and backup environment variables
gpg --symmetric --cipher-algo AES256 .env
rclone copy .env.gpg dropbox:backups/env/

# Backup deployment scripts
tar -czf deployment_scripts.tar.gz setup.sh deploy.sh backup.sh
rclone copy deployment_scripts.tar.gz dropbox:backups/scripts/
```

### External Configuration Storage
```javascript
// Store critical config in external services
const config = {
  // Primary database (can be on different provider)
  database: process.env.DATABASE_URL || "postgresql://user@external-db.com:5432/db",
  
  // Backup database (different provider)
  backupDatabase: process.env.BACKUP_DATABASE_URL,
  
  // External Redis (upstash.com has free tier)
  redis: process.env.REDIS_URL || "redis://user:pass@external-redis.com:6379",
  
  // File storage (not on same VPS)
  fileStorage: process.env.CLOUDINARY_URL || process.env.S3_BUCKET,
};
```

---

## 🚨 When Suspension Happens

### Immediate Response (First 5 Minutes)
1. **Stay calm** - panicking makes mistakes
2. **Check provider status** - is it you or them?
3. **Activate backup server** - switch DNS if possible
4. **Notify users** - social media, status page, email
5. **Contact provider support** - open urgent ticket

### Emergency Activation Script
```bash
#!/bin/bash
# emergency-activate.sh - Run on backup server

# 1. Download latest backup
rclone copy dropbox:backups/ /tmp/restore/

# 2. Extract latest database backup
LATEST_DB=$(ls -t /tmp/restore/db_backup_*.sql | head -1)
psql $BACKUP_DATABASE_URL < $LATEST_DB

# 3. Extract latest application backup
LATEST_APP=$(ls -t /tmp/restore/app_backup_*.tar.gz | head -1)
tar -xzf $LATEST_APP -C /

# 4. Restore environment variables
gpg --decrypt /tmp/restore/env/.env.gpg > .env

# 5. Start application
./setup.sh

# 6. Update DNS (if using Cloudflare API)
curl -X PUT "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$RECORD_ID" \
     -H "Authorization: Bearer $CLOUDFLARE_TOKEN" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"yourdomain.com","content":"NEW_BACKUP_SERVER_IP"}'

# 7. Send recovery notification
curl -X POST "https://api.telegram.org/bot$ALERT_BOT_TOKEN/sendMessage" \
    -d "chat_id=$ADMIN_CHAT_ID" \
    -d "text=🚀 Emergency server activated! Service restored."
```

---

## 🔄 Multi-Provider Strategy

### Provider Diversification
```yaml
# Infrastructure spread across providers
Primary:
  VPS: DigitalOcean ($5/month)
  Domain: Cloudflare (FREE)
  Database: Supabase (FREE tier)

Backup:
  VPS: Contabo (€4.99/month) 
  Database: Railway PostgreSQL ($5/month)
  File Storage: Cloudinary (FREE tier)

Emergency:
  Hosting: Railway/Render (managed service)
  Database: PlanetScale (FREE tier)
  Monitoring: UptimeRobot (FREE)
```

### DNS Failover Setup
```bash
# Using Cloudflare for quick DNS switching
# Primary server healthy: point to DigitalOcean IP
# Primary down: point to Contabo backup IP

# Automated health check with DNS update
#!/bin/bash
# health-check-dns.sh

PRIMARY_IP="YOUR_DIGITALOCEAN_IP"
BACKUP_IP="YOUR_CONTABO_IP"
DOMAIN="yourdomain.com"

# Check if primary server is responding
if curl -f --max-time 10 http://$PRIMARY_IP/health; then
    echo "Primary server healthy"
else
    echo "Primary server down - switching to backup"
    
    # Update DNS to point to backup server
    curl -X PUT "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$RECORD_ID" \
         -H "Authorization: Bearer $CLOUDFLARE_TOKEN" \
         -H "Content-Type: application/json" \
         --data "{\"type\":\"A\",\"name\":\"$DOMAIN\",\"content\":\"$BACKUP_IP\"}"
    
    # Alert admin
    curl -X POST "https://api.telegram.org/bot$ALERT_BOT_TOKEN/sendMessage" \
        -d "chat_id=$ADMIN_CHAT_ID" \
        -d "text=🚨 DNS switched to backup server due to primary failure"
fi
```

---

## 📞 Provider Communication Strategy

### Suspension Appeal Template
```
Subject: Urgent: Account Suspension Appeal - Business Impact

Dear [Provider] Support,

My account [ACCOUNT_ID] was suspended on [DATE] with reason: [REASON]

Business Impact:
- Revenue-generating application serving [X] users
- [X] daily active users affected
- Estimated revenue loss: $[X] per day

Mitigation Actions Taken:
- [Specific action 1]
- [Specific action 2] 
- [Specific action 3]

Evidence of Legitimate Use:
- Application purpose: [DESCRIPTION]
- Traffic patterns: [NORMAL USAGE PATTERNS]
- Resource usage: [ACTUAL USAGE vs LIMITS]

Request:
- Immediate review of suspension
- Temporary access to retrieve critical data
- Guidance on compliance requirements

Contact: [PHONE] [EMAIL]
Business Registration: [IF APPLICABLE]

I am available for immediate discussion to resolve this matter.

Thank you for urgent attention.
```

### Escalation Contacts
```bash
# Keep emergency contact list updated
DIGITALOCEAN_SUPPORT="+1-XXX-XXX-XXXX"
CONTABO_SUPPORT="+49-XXX-XXX-XXXX"
OVHCLOUD_SUPPORT="+33-XXX-XXX-XXXX"

# Social media escalation (often faster)
TWITTER_HANDLES="@DigitalOcean @Contabo_com @OVHcloud"
```

---

## 🔍 Monitoring & Early Warning

### Suspension Risk Indicators
```bash
# Monitor for suspension risk factors
#!/bin/bash
# suspension-risk-monitor.sh

# Check for high outbound traffic (spam indicator)
OUTBOUND_TRAFFIC=$(vnstat -d | grep today | awk '{print $9}')
if (( $(echo "$OUTBOUND_TRAFFIC > 10" | bc -l) )); then
    echo "⚠️ High outbound traffic detected: ${OUTBOUND_TRAFFIC}GB"
fi

# Check for unusual process activity
SUSPICIOUS_PROCESSES=$(ps aux | grep -E "(bitcoin|mining|ddos|spam)" | grep -v grep)
if [ ! -z "$SUSPICIOUS_PROCESSES" ]; then
    echo "🚨 Suspicious processes detected"
    echo "$SUSPICIOUS_PROCESSES"
fi

# Check login attempts
FAILED_LOGINS=$(grep "Failed password" /var/log/auth.log | wc -l)
if [ $FAILED_LOGINS -gt 100 ]; then
    echo "🚨 High number of failed login attempts: $FAILED_LOGINS"
fi
```

### Automated Compliance Checks
```javascript
// App-level compliance monitoring
const complianceMonitor = {
  checkResourceUsage: () => {
    const usage = process.resourceUsage();
    if (usage.userCPUTime > 1000000) { // microseconds
      console.warn('⚠️ High CPU usage detected');
      // Implement CPU throttling or alert
    }
  },
  
  checkTrafficPatterns: (req, res, next) => {
    // Monitor for DDoS-like patterns
    const ip = req.ip;
    const requestCount = getRequestCount(ip);
    
    if (requestCount > 1000) { // per minute
      console.warn(`⚠️ High request rate from ${ip}: ${requestCount}/min`);
      // Implement rate limiting or blocking
    }
    next();
  },
  
  checkOutputTraffic: () => {
    // Monitor outbound requests (prevent spam accusations)
    const outboundRequests = getOutboundRequestCount();
    if (outboundRequests > 10000) { // per hour
      console.warn('⚠️ High outbound request volume');
      // Implement throttling
    }
  }
};
```

---

## 💡 Pro Tips for VPS Survival

### 1. **Resource Management**
- Use PM2 with memory limits
- Implement request queuing for heavy operations
- Monitor and limit file uploads
- Regular log rotation and cleanup

### 2. **Traffic Management**
- Use Cloudflare for DDoS protection (FREE)
- Implement progressive rate limiting
- Cache static content aggressively
- Use CDN for file delivery

### 3. **Security Hardening**
- Regular security updates
- Fail2ban for intrusion prevention
- Strong SSH key authentication
- Regular malware scanning

### 4. **Provider Relations**
- Verify account with phone/business documents
- Pay annually (shows commitment)
- Keep support tickets professional
- Follow ToS strictly

---

## 🚨 Emergency Contacts Checklist

Keep this info accessible from phone:
- [ ] Primary VPS provider support (phone + email)
- [ ] Backup VPS provider credentials
- [ ] Domain registrar access
- [ ] Cloudflare account access
- [ ] Database backup location
- [ ] Emergency notification bot token
- [ ] Business bank account for emergency payments

---

**Remember**: VPS suspension is not "if" but "when" for active solo developers. Having a recovery plan is the difference between 1 hour downtime and business death.