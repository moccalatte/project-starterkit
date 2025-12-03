# 07. Security & Operations
**Version:** v3  
**Last Updated:** 03 December 2025

---

## Purpose
Define security controls, operational procedures, and deployment strategies for the bot.

---

## Security Controls

### Authentication

**Telegram User Verification:**
```javascript
function verifyTelegramUser(update) {
  // Telegram automatically authenticates users
  // Verify the update is from Telegram API
  const userId = update.message?.from?.id;
  const isBot = update.message?.from?.is_bot;
  
  if (!userId || isBot) {
    throw new Error('Invalid user');
  }
  
  return userId;
}
```

**Webhook Security:**
```javascript
// Set secret token when configuring webhook
const SECRET_TOKEN = process.env.WEBHOOK_SECRET;

app.post('/webhook', (req, res) => {
  const token = req.headers['x-telegram-bot-api-secret-token'];
  
  if (token !== SECRET_TOKEN) {
    return res.sendStatus(403);
  }
  
  // Process update
  bot.handleUpdate(req.body);
  res.sendStatus(200);
});
```

---

### Authorization

**User Data Access:**
- Users can only access their own expenses
- Implement row-level security in queries
- Never expose other users' data

```javascript
async function getExpenses(requestingUserId, targetUserId) {
  // Verify user can access this data
  if (requestingUserId !== targetUserId) {
    throw new Error('Unauthorized access');
  }
  
  return await db.getExpenses(targetUserId);
}
```

**Admin Commands:**
```javascript
const ADMIN_IDS = process.env.ADMIN_TELEGRAM_IDS.split(',').map(Number);

function isAdmin(userId) {
  return ADMIN_IDS.includes(userId);
}

bot.command('broadcast', async (ctx) => {
  if (!isAdmin(ctx.from.id)) {
    return ctx.reply('❌ Unauthorized');
  }
  
  // Admin action
});
```

---

### Input Validation

**Sanitize User Input:**
```javascript
function sanitizeInput(text) {
  // Remove HTML tags
  let clean = text.replace(/<[^>]*>/g, '');
  
  // Escape special characters
  clean = clean.replace(/[&<>"']/g, (char) => {
    const escapeMap = {
      '&': '&amp;',
      '<': '&lt;',
      '>': '&gt;',
      '"': '&quot;',
      "'": '&#39;'
    };
    return escapeMap[char];
  });
  
  // Limit length
  return clean.substring(0, 1000);
}
```

**Validate Amounts:**
```javascript
function validateAmount(input) {
  const amount = parseFloat(input);
  
  if (isNaN(amount)) {
    throw new Error('Invalid amount');
  }
  
  if (amount <= 0) {
    throw new Error('Amount must be positive');
  }
  
  if (amount > 1000000) {
    throw new Error('Amount too large');
  }
  
  return parseFloat(amount.toFixed(2));
}
```

---

### Rate Limiting

**Per-User Rate Limits:**
```javascript
const rateLimit = require('express-rate-limit');

// Redis-based rate limiting
async function checkRateLimit(userId) {
  const redis = getRedisClient();
  const key = `ratelimit:${userId}:messages`;
  
  const count = await redis.incr(key);
  
  if (count === 1) {
    await redis.expire(key, 60); // 1 minute window
  }
  
  if (count > 30) {
    throw new Error('Rate limit exceeded');
  }
  
  return true;
}

// Middleware
bot.use(async (ctx, next) => {
  try {
    await checkRateLimit(ctx.from.id);
    return next();
  } catch (error) {
    return ctx.reply('⏰ Slow down! Please wait a moment.');
  }
});
```

---

### Data Protection

**Encryption at Rest:**
- Database encryption enabled (PostgreSQL)
- Use encrypted disk volumes
- Encrypt backups before upload

**Encryption in Transit:**
- All API calls use HTTPS/TLS
- Valid SSL certificate required
- Minimum TLS 1.2

**Sensitive Data Handling:**
```javascript
// Never log sensitive data
logger.info('Expense added', {
  userId: expense.userId,
  amount: expense.amount,
  // DO NOT log: notes, personal info
});

// Redact in error logs
function redactError(error) {
  const safe = { ...error };
  delete safe.personalData;
  delete safe.token;
  return safe;
}
```

---

### Secrets Management

**Environment Variables:**
```bash
# .env file (NEVER commit this)
BOT_TOKEN=1234567890:ABCdefGHIjklMNOpqrsTUVwxyz
DATABASE_URL=postgresql://user:pass@host:5432/db
REDIS_URL=redis://:password@host:6379
WEBHOOK_SECRET=random_secret_string_here
ADMIN_TELEGRAM_IDS=123456789,987654321
```

**Best Practices:**
- Use `.env` files for local development
- Use secrets manager for production (AWS Secrets Manager, HashiCorp Vault)
- Rotate tokens every 90 days
- Never hardcode secrets in code
- Add `.env` to `.gitignore`

---

## Operational Procedures

### Deployment

**Production Deployment Checklist:**
- [ ] All tests passing
- [ ] Environment variables configured
- [ ] Database migrations applied
- [ ] SSL certificate valid
- [ ] Webhook URL set correctly
- [ ] Health check endpoint responding
- [ ] Monitoring alerts configured
- [ ] Backup verification successful
- [ ] Rollback plan documented

**Deployment Methods:**

**Option 1: Docker**
```dockerfile
FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm ci --only=production

COPY . .

EXPOSE 8443

CMD ["node", "src/index.js"]
```

```bash
# Build and run
docker build -t bot:latest .
docker run -d \
  --name bot \
  --env-file .env \
  --restart unless-stopped \
  -p 8443:8443 \
  bot:latest
```

**Option 2: Railway / Render**
```bash
# Deploy to Railway
railway up

# Or use Render
# Connect GitHub repo and deploy
```

---

### Health Checks

**HTTP Health Endpoint:**
```javascript
app.get('/health', async (req, res) => {
  try {
    // Check database
    await db.query('SELECT 1');
    
    // Check Redis
    await redis.ping();
    
    res.json({
      status: 'healthy',
      timestamp: new Date().toISOString(),
      uptime: process.uptime()
    });
  } catch (error) {
    res.status(503).json({
      status: 'unhealthy',
      error: error.message
    });
  }
});
```

**Process Monitoring:**
```javascript
// Graceful shutdown
process.on('SIGTERM', async () => {
  console.log('SIGTERM received, shutting down gracefully');
  
  await bot.stop();
  await db.close();
  await redis.quit();
  
  process.exit(0);
});

// Restart on uncaught errors
process.on('uncaughtException', (error) => {
  logger.error('Uncaught exception:', error);
  process.exit(1); // Let process manager restart
});
```

---

### Monitoring

**Key Metrics:**
```javascript
const metrics = {
  messagesProcessed: 0,
  errorsCount: 0,
  activeUsers: new Set(),
  responseTimeSum: 0,
  responseTimeCount: 0
};

// Track message processing
bot.use(async (ctx, next) => {
  const start = Date.now();
  metrics.messagesProcessed++;
  metrics.activeUsers.add(ctx.from.id);
  
  try {
    await next();
  } catch (error) {
    metrics.errorsCount++;
    throw error;
  } finally {
    const duration = Date.now() - start;
    metrics.responseTimeSum += duration;
    metrics.responseTimeCount++;
  }
});

// Expose metrics endpoint
app.get('/metrics', (req, res) => {
  res.json({
    messages_processed: metrics.messagesProcessed,
    errors_count: metrics.errorsCount,
    active_users: metrics.activeUsers.size,
    avg_response_time: metrics.responseTimeSum / metrics.responseTimeCount
  });
});
```

**Logging:**
```javascript
const winston = require('winston');

const logger = winston.createLogger({
  level: 'info',
  format: winston.format.json(),
  transports: [
    new winston.transports.File({ filename: 'error.log', level: 'error' }),
    new winston.transports.File({ filename: 'combined.log' })
  ]
});

// Log all commands
bot.use((ctx, next) => {
  logger.info('Command received', {
    userId: ctx.from.id,
    command: ctx.message?.text?.split(' ')[0],
    timestamp: new Date().toISOString()
  });
  return next();
});
```

**Alerting:**
```javascript
// Alert on high error rate
setInterval(() => {
  const errorRate = metrics.errorsCount / metrics.messagesProcessed;
  
  if (errorRate > 0.1) { // 10% error rate
    sendAlert('High error rate detected', {
      errorRate,
      totalErrors: metrics.errorsCount,
      totalMessages: metrics.messagesProcessed
    });
  }
}, 60000); // Check every minute
```

---

### Backup & Recovery

**Automated Backups:**
```bash
#!/bin/bash
# backup.sh

DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="/backups"

# Backup database
pg_dump $DATABASE_URL | gzip > "$BACKUP_DIR/db_$DATE.sql.gz"

# Upload to S3
aws s3 cp "$BACKUP_DIR/db_$DATE.sql.gz" s3://my-bot-backups/

# Keep only last 7 days locally
find $BACKUP_DIR -name "db_*.sql.gz" -mtime +7 -delete

echo "Backup completed: db_$DATE.sql.gz"
```

**Restore Procedure:**
```bash
#!/bin/bash
# restore.sh

BACKUP_FILE=$1

# Download from S3
aws s3 cp "s3://my-bot-backups/$BACKUP_FILE" .

# Restore database
gunzip -c $BACKUP_FILE | psql $DATABASE_URL

echo "Restore completed from: $BACKUP_FILE"
```

**Disaster Recovery:**
1. Stop the bot service
2. Restore database from latest backup
3. Verify data integrity
4. Clear Redis cache
5. Restart bot service
6. Monitor for errors

---

### Maintenance Windows

**Planned Maintenance:**
```javascript
// Maintenance mode
const MAINTENANCE_MODE = process.env.MAINTENANCE_MODE === 'true';

bot.use((ctx, next) => {
  if (MAINTENANCE_MODE) {
    return ctx.reply(
      '🔧 Bot is under maintenance.\n' +
      'We\'ll be back shortly. Thanks for your patience!'
    );
  }
  return next();
});
```

**Notification:**
- Announce maintenance 24 hours in advance
- Use `/broadcast` to notify all users
- Update bot description/about text
- Post on status page

---

## Incident Response

### Error Categories

**P1 - Critical:**
- Bot completely offline
- Database corruption
- Data breach
- **Response:** Immediate (< 15 min)

**P2 - High:**
- Partial service disruption
- High error rate (>10%)
- Slow response times
- **Response:** Within 1 hour

**P3 - Medium:**
- Single feature broken
- Minor bugs
- **Response:** Within 24 hours

**P4 - Low:**
- Cosmetic issues
- Enhancement requests
- **Response:** As prioritized

---

### Incident Workflow

1. **Detect** - Monitoring alerts or user reports
2. **Assess** - Determine severity and impact
3. **Respond** - Take immediate action to mitigate
4. **Communicate** - Notify affected users
5. **Resolve** - Fix root cause
6. **Document** - Post-mortem analysis

---

### Rollback Plan

**Quick Rollback:**
```bash
# Docker rollback
docker stop bot
docker rm bot
docker run -d --name bot bot:previous-version

# Or use Railway/Render dashboard
# Redeploy previous version
```

**Database Rollback:**
```bash
# Rollback migration
npm run migrate:down

# Or restore from backup
./restore.sh db_20250115_120000.sql.gz
```

---

## Compliance

### Data Privacy (GDPR)

**User Rights:**
- Right to access data (`/export`)
- Right to deletion (`/delete_account`)
- Right to rectification (edit expenses)
- Right to data portability (export formats)

**Implementation:**
```javascript
bot.command('delete_account', async (ctx) => {
  await ctx.reply(
    '⚠️ This will permanently delete:\n' +
    '• All your expenses\n' +
    '• Your profile\n' +
    '• All settings\n\n' +
    'This cannot be undone.\n\n' +
    'Type CONFIRM to proceed.'
  );
  
  // Set state and wait for confirmation
});

// Handle confirmation
async function deleteUserAccount(userId) {
  await db.query('DELETE FROM expenses WHERE user_id = $1', [userId]);
  await db.query('DELETE FROM users WHERE id = $1', [userId]);
  await redis.del(`user:${userId}:*`);
  
  logger.info('User account deleted', { userId });
}
```

---

## Performance Optimization

### Caching Strategy

```javascript
// Cache frequently accessed data
async function getCategories(userId) {
  const cacheKey = `categories:${userId}`;
  let categories = await redis.get(cacheKey);
  
  if (!categories) {
    categories = await db.getCategories(userId);
    await redis.set(cacheKey, JSON.stringify(categories), 'EX', 3600);
  } else {
    categories = JSON.parse(categories);
  }
  
  return categories;
}
```

### Database Connection Pooling

```javascript
const { Pool } = require('pg');

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  max: 20, // Max connections
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 2000
});
```

---

## Cross-References
- See [04-bot_architecture.md](04-bot_architecture.md) for system design
- See [06-data_state.md](06-data_state.md) for backup strategies
- See [02-dev_protocol.md](02-dev_protocol.md) for deployment workflow

---

> **Note for AI builders:** Security is not optional. Implement these controls from day one, not as an afterthought.
