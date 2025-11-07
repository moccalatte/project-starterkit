# Bot Security Guide

**Protect your bots from malicious users and platform abuse.**

## Bot vs Web App Security Differences

### Bot-Specific Risks
- **Platform dependency**: Your bot lives on someone else's platform
- **No traditional authentication**: Users identified by platform ID
- **Always-on exposure**: Bots can't hide behind login screens  
- **Command injection**: Malicious bot commands can break your logic
- **Spam amplification**: Bots can be tricked into spamming users
- **Token compromise**: Single bot token = total compromise

### Why Web App Security Doesn't Apply
❌ **No WAF needed**: Bots connect to platform APIs, not direct web traffic
❌ **No HTTPS config**: Platform handles encryption
❌ **No frontend security**: Commands are the "frontend"
❌ **Different rate limiting**: Per-user, not per-IP

---

## Platform-Specific Security

### Telegram Bot Security

#### Webhook Verification (CRITICAL)
```python
import hashlib
import hmac

def verify_telegram_webhook(request_data, secret_token):
    """Verify request actually comes from Telegram"""
    received_hash = request.headers.get('X-Telegram-Bot-Api-Secret-Token')
    expected_hash = secret_token
    return hmac.compare_digest(received_hash, expected_hash)

# Use this for EVERY webhook request
if not verify_telegram_webhook(request.data, SECRET_TOKEN):
    return "Unauthorized", 401
```

#### Command Authorization
```python
ADMIN_USER_IDS = [123456789, 987654321]  # Your admin Telegram IDs

def admin_only(func):
    def wrapper(update, context):
        user_id = update.effective_user.id
        if user_id not in ADMIN_USER_IDS:
            update.message.reply_text("❌ Admin only command")
            return
        return func(update, context)
    return wrapper

@admin_only
def admin_command(update, context):
    # This command only works for admins
    pass
```

#### Rate Limiting for Bots
```python
from collections import defaultdict
import time

user_last_command = defaultdict(float)
RATE_LIMIT_SECONDS = 1  # 1 command per second per user

def rate_limit_user(user_id):
    now = time.time()
    if now - user_last_command[user_id] < RATE_LIMIT_SECONDS:
        return False  # Rate limited
    user_last_command[user_id] = now
    return True  # Allowed

def handle_command(update, context):
    user_id = update.effective_user.id
    if not rate_limit_user(user_id):
        update.message.reply_text("⏰ Please wait before sending another command")
        return
    # Process command
```

### WhatsApp Bot Security (Multiple Libraries)

#### Official WhatsApp Business API
```javascript
const crypto = require('crypto');

function verifyWhatsAppWebhook(payload, signature, secret) {
    const expectedSignature = crypto
        .createHmac('sha256', secret)
        .update(payload)
        .digest('hex');
    
    return crypto.timingSafeEqual(
        Buffer.from(signature),
        Buffer.from(expectedSignature)
    );
}
```

#### go-whatsapp-web-multidevice Security
```go
package main

import (
    "crypto/rand"
    "encoding/hex"
    "time"
    whatsapp "github.com/aldinokemal/go-whatsapp-web-multidevice/src/whatsapp"
)

// Rate limiting for Go WhatsApp
var userLastMessage = make(map[string]time.Time)
const rateLimitDuration = 2 * time.Second

func rateLimitUser(phone string) bool {
    now := time.Now()
    if lastMsg, exists := userLastMessage[phone]; exists {
        if now.Sub(lastMsg) < rateLimitDuration {
            return false // Rate limited
        }
    }
    userLastMessage[phone] = now
    return true // Allowed
}

func handleIncomingMessage(message whatsapp.Message) {
    // Rate limiting
    if !rateLimitUser(message.Phone) {
        whatsapp.SendMessage(message.Phone, "⏰ Please wait before sending another message")
        return
    }
    
    // Input sanitization
    cleanMessage := sanitizeInput(message.Body)
    
    // Process message
    processCommand(message.Phone, cleanMessage)
}

func sanitizeInput(input string) string {
    // Remove potential malicious content
    // Add your sanitization logic here
    return strings.TrimSpace(input)
}
```

#### WAHA (WhatsApp HTTP API) Security
```javascript
const axios = require('axios');

class SecureWAHA {
    constructor(apiUrl, apiKey) {
        this.apiUrl = apiUrl;
        this.apiKey = apiKey;
        this.rateLimiter = new Map();
    }
    
    rateLimitUser(chatId, maxMessages = 5, windowMs = 60000) {
        const now = Date.now();
        const userLimits = this.rateLimiter.get(chatId) || [];
        
        // Remove old entries
        const recentMessages = userLimits.filter(time => now - time < windowMs);
        
        if (recentMessages.length >= maxMessages) {
            return false; // Rate limited
        }
        
        recentMessages.push(now);
        this.rateLimiter.set(chatId, recentMessages);
        return true; // Allowed
    }
    
    async sendSecureMessage(chatId, text) {
        if (!this.rateLimitUser(chatId)) {
            return { error: 'Rate limited' };
        }
        
        try {
            const response = await axios.post(`${this.apiUrl}/api/sendText`, {
                chatId: chatId,
                text: text,
            }, {
                headers: { 
                    'X-Api-Key': this.apiKey,
                    'Content-Type': 'application/json'
                },
                timeout: 10000 // 10 second timeout
            });
            
            return response.data;
        } catch (error) {
            console.error(`WAHA API error: ${error.message}`);
            throw error;
        }
    }
}
```

### Multi-Platform Social Media Bots

#### Twitter/X Bot Security
```javascript
const { TwitterApi } = require('twitter-api-v2');

class SecureTwitterBot {
    constructor() {
        this.client = new TwitterApi({
            appKey: process.env.TWITTER_API_KEY,
            appSecret: process.env.TWITTER_API_SECRET,
            accessToken: process.env.TWITTER_ACCESS_TOKEN,
            accessSecret: process.env.TWITTER_ACCESS_SECRET,
        });
        
        this.rateLimiter = new Map();
    }
    
    async handleMention(tweet) {
        const userId = tweet.author_id;
        
        // Rate limiting per user
        if (!this.rateLimitUser(userId, 3, 900000)) { // 3 per 15 min
            return; // Silently ignore rate limited users
        }
        
        // Validate tweet content
        if (!this.validateTweetContent(tweet.text)) {
            return; // Ignore suspicious content
        }
        
        // Process mention
        await this.processMention(tweet);
    }
    
    validateTweetContent(text) {
        // Check for spam indicators
        const spamIndicators = [
            text.length > 280, // Too long
            (text.match(/http/g) || []).length > 3, // Too many links
            /\b(spam|scam|bitcoin|crypto)\b/i.test(text), // Spam keywords
        ];
        
        return spamIndicators.filter(Boolean).length < 2;
    }
}
```

#### Reddit Bot Security  
```python
import praw
import time
from collections import defaultdict

class SecureRedditBot:
    def __init__(self):
        self.reddit = praw.Reddit(
            client_id=os.getenv('REDDIT_CLIENT_ID'),
            client_secret=os.getenv('REDDIT_CLIENT_SECRET'),
            user_agent=os.getenv('REDDIT_USER_AGENT'),
            username=os.getenv('REDDIT_USERNAME'),
            password=os.getenv('REDDIT_PASSWORD')
        )
        self.user_rates = defaultdict(list)
    
    def rate_limit_user(self, username, max_interactions=5, window_seconds=3600):
        now = time.time()
        user_history = self.user_rates[username]
        
        # Remove old interactions
        user_history[:] = [t for t in user_history if now - t < window_seconds]
        
        if len(user_history) >= max_interactions:
            return False
        
        user_history.append(now)
        return True
    
    def handle_comment_reply(self, comment):
        username = comment.author.name if comment.author else 'deleted'
        
        # Rate limiting
        if not self.rate_limit_user(username):
            return
        
        # Validate comment
        if not self.validate_comment(comment.body):
            return
            
        # Process comment
        self.process_comment(comment)
    
    def validate_comment(self, text):
        # Basic spam detection
        if len(text) > 1000 or text.count('http') > 3:
            return False
        return True
```

#### Discord Multi-Server Security
```javascript
const { Client, GatewayIntentBits } = require('discord.js');

class SecureDiscordBot {
    constructor() {
        this.client = new Client({
            intents: [
                GatewayIntentBits.Guilds,
                GatewayIntentBits.GuildMessages,
                GatewayIntentBits.MessageContent
            ]
        });
        
        this.serverRateLimits = new Map();
        this.userGlobalRateLimit = new Map();
    }
    
    rateLimitPerServer(guildId, userId, maxPerServer = 10, windowMs = 60000) {
        const serverKey = `${guildId}:${userId}`;
        const now = Date.now();
        
        const serverLimits = this.serverRateLimits.get(serverKey) || [];
        const recentCommands = serverLimits.filter(time => now - time < windowMs);
        
        if (recentCommands.length >= maxPerServer) {
            return false;
        }
        
        recentCommands.push(now);
        this.serverRateLimits.set(serverKey, recentCommands);
        return true;
    }
    
    globalRateLimit(userId, maxGlobal = 30, windowMs = 60000) {
        const now = Date.now();
        const globalLimits = this.userGlobalRateLimit.get(userId) || [];
        const recentCommands = globalLimits.filter(time => now - time < windowMs);
        
        if (recentCommands.length >= maxGlobal) {
            return false;
        }
        
        recentCommands.push(now);
        this.userGlobalRateLimit.set(userId, recentCommands);
        return true;
    }
    
    async handleCommand(interaction) {
        const userId = interaction.user.id;
        const guildId = interaction.guild?.id;
        
        // Global rate limiting
        if (!this.globalRateLimit(userId)) {
            await interaction.reply({
                content: '⏰ You\'re sending commands too quickly. Please slow down.',
                ephemeral: true
            });
            return;
        }
        
        // Per-server rate limiting
        if (guildId && !this.rateLimitPerServer(guildId, userId)) {
            await interaction.reply({
                content: '⏰ Too many commands in this server. Please wait.',
                ephemeral: true
            });
            return;
        }
        
        // Process command
        await this.processCommand(interaction);
    }
}
```

#### Webhook Verification
```javascript
const crypto = require('crypto');

function verifyWhatsAppWebhook(payload, signature, secret) {
    const expectedSignature = crypto
        .createHmac('sha256', secret)
        .update(payload)
        .digest('hex');
    
    return crypto.timingSafeEqual(
        Buffer.from(signature),
        Buffer.from(expectedSignature)
    );
}

// Verify every webhook
app.post('/webhook', (req, res) => {
    const signature = req.headers['x-hub-signature-256'];
    if (!verifyWhatsAppWebhook(req.body, signature, WEBHOOK_SECRET)) {
        return res.status(401).send('Unauthorized');
    }
    // Process webhook
});
```

#### Message Validation
```javascript
function validateWhatsAppMessage(message) {
    // Prevent malicious message content
    if (!message.from || !message.text) {
        return false;
    }
    
    // Check message length (prevent spam)
    if (message.text.body.length > 1000) {
        return false;
    }
    
    // Sanitize message content
    message.text.body = message.text.body.replace(/<script>/gi, '');
    
    return true;
}
```

### Discord Bot Security

#### Token Protection
```javascript
// NEVER do this
const token = "your-bot-token-here";

// ALWAYS do this
const token = process.env.DISCORD_BOT_TOKEN;

// Validate token exists
if (!token) {
    console.error("DISCORD_BOT_TOKEN environment variable not set!");
    process.exit(1);
}
```

#### Permission Validation
```javascript
function hasPermission(member, requiredPermission) {
    return member.permissions.has(requiredPermission);
}

// Check permissions before executing commands
client.on('messageCreate', message => {
    if (message.content.startsWith('!admin')) {
        if (!hasPermission(message.member, 'ADMINISTRATOR')) {
            message.reply('❌ You need admin permissions for this command');
            return;
        }
        // Execute admin command
    }
});
```

---

## Universal Bot Security Practices

### Environment Variables (MANDATORY)
```bash
# .env file (NEVER commit to git)
TELEGRAM_BOT_TOKEN=your_telegram_token
WHATSAPP_ACCESS_TOKEN=your_whatsapp_token  
DISCORD_BOT_TOKEN=your_discord_token
DATABASE_URL=your_database_connection
WEBHOOK_SECRET=your_webhook_secret
ADMIN_USER_IDS=123456,789012,345678
```

### Input Sanitization
```python
import re

def sanitize_user_input(text):
    """Clean user input to prevent injection attacks"""
    # Remove potential SQL injection characters
    text = re.sub(r'[;\'"\\]', '', text)
    
    # Limit length
    text = text[:500]
    
    # Remove potential command injection
    text = re.sub(r'[`$()]', '', text)
    
    return text.strip()

# Use for ALL user inputs
user_message = sanitize_user_input(update.message.text)
```

### Database Security for Bots
```python
import sqlite3

# NEVER do this (SQL injection vulnerable)
cursor.execute(f"SELECT * FROM users WHERE telegram_id = {user_id}")

# ALWAYS do this (parameterized queries)
cursor.execute("SELECT * FROM users WHERE telegram_id = ?", (user_id,))

# Hash sensitive data
import hashlib

def hash_user_data(data):
    return hashlib.sha256(data.encode()).hexdigest()

# Store hashed phone numbers, not raw
hashed_phone = hash_user_data(user_phone)
```

### Error Handling for Bots
```python
import logging

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def safe_bot_handler(func):
    """Wrapper to handle bot errors safely"""
    def wrapper(update, context):
        try:
            return func(update, context)
        except Exception as e:
            # Log error for debugging
            logger.error(f"Bot error: {e}", exc_info=True)
            
            # Send safe error message to user
            if update and update.message:
                update.message.reply_text(
                    "❌ Sorry, something went wrong. Please try again later."
                )
        return wrapper

@safe_bot_handler
def my_command(update, context):
    # Your command logic here
    pass
```

---

## Anti-Abuse for Bots

### Command Flooding Prevention
```python
from collections import defaultdict
import time

user_command_count = defaultdict(list)
MAX_COMMANDS_PER_MINUTE = 10

def check_command_flood(user_id):
    now = time.time()
    # Remove old commands (older than 1 minute)
    user_command_count[user_id] = [
        cmd_time for cmd_time in user_command_count[user_id] 
        if now - cmd_time < 60
    ]
    
    # Check if user exceeded limit
    if len(user_command_count[user_id]) >= MAX_COMMANDS_PER_MINUTE:
        return False  # Block user
    
    # Add current command
    user_command_count[user_id].append(now)
    return True  # Allow command
```

### Spam Detection
```python
def detect_spam_message(message):
    spam_indicators = [
        len(message) > 1000,  # Too long
        message.count('http') > 5,  # Too many links
        message.isupper() and len(message) > 50,  # ALL CAPS
        any(word in message.lower() for word in ['spam', 'scam', 'bitcoin']),
    ]
    
    return sum(spam_indicators) >= 2  # 2+ indicators = spam

# Use in message handler
if detect_spam_message(user_message):
    # Log spam attempt
    logger.warning(f"Spam detected from user {user_id}: {user_message[:100]}")
    # Don't respond to spam
    return
```

### Bot Blacklist Management
```python
BLACKLISTED_USERS = set()

def blacklist_user(user_id, reason):
    BLACKLISTED_USERS.add(user_id)
    logger.warning(f"User {user_id} blacklisted: {reason}")

def is_blacklisted(user_id):
    return user_id in BLACKLISTED_USERS

# Check in every command
if is_blacklisted(update.effective_user.id):
    return  # Silently ignore blacklisted users
```

---

## Deployment Security for Bots

### Simple Bot Hosting
```bash
# Use Railway/Render for bot hosting
# These platforms handle HTTPS/security automatically

# Bot deployment checklist:
# ✅ Environment variables configured
# ✅ Database connection secured
# ✅ Webhook URL uses HTTPS
# ✅ Bot token never in code
# ✅ Error logging enabled
# ✅ Auto-restart on crash enabled
```

### Health Monitoring
```python
import requests
import time

def health_check():
    """Send health status to monitoring service"""
    try:
        # Check if bot is responsive
        bot.get_me()
        
        # Check database connection
        database.execute("SELECT 1")
        
        return True
    except Exception as e:
        logger.error(f"Health check failed: {e}")
        return False

# Run health check every 5 minutes
def start_health_monitor():
    while True:
        if not health_check():
            # Alert admin via Telegram
            bot.send_message(
                chat_id=ADMIN_CHAT_ID,
                text="🚨 Bot health check failed!"
            )
        time.sleep(300)  # 5 minutes
```

---

## Bot-Specific Compliance

### Data Protection for Bots
- **User consent**: Ask before storing user data
- **Data minimization**: Only store necessary data
- **Right to deletion**: Allow users to delete their data
- **Data portability**: Allow users to export their data

```python
def handle_delete_data(update, context):
    """Allow user to delete their data (GDPR compliance)"""
    user_id = update.effective_user.id
    
    # Delete user data from database
    cursor.execute("DELETE FROM users WHERE telegram_id = ?", (user_id,))
    database.commit()
    
    update.message.reply_text(
        "✅ Your data has been deleted from our system."
    )
```

### Audit Logging for Bots
```python
def log_bot_action(user_id, action, details):
    """Log bot actions for audit purposes"""
    log_entry = {
        'timestamp': time.time(),
        'user_id': user_id,
        'action': action,
        'details': details
    }
    
    # Store in database or log file
    logger.info(f"AUDIT: {log_entry}")
```

---

**Remember**: Bots are easier to build but harder to secure than web apps. Focus on input validation, rate limiting, and platform-specific authentication.