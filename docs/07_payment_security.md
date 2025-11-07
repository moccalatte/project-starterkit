# Payment Gateway Security

**Handle money without losing money (or going to jail).**

## Critical Payment Risks (Will Destroy Your Business)

### 1. **Payment Fraud**
**Risk**: Stolen credit cards, chargebacks, fake transactions
**Impact**: Financial loss, payment processor bans, legal liability
**Detection**: Velocity checks, geographic anomalies, device fingerprinting

### 2. **Chargeback Abuse**
**Risk**: Users get service then dispute charges
**Impact**: Lost revenue + chargeback fees ($15-50 per incident)
**Prevention**: Strong verification, clear ToS, fraud scoring

### 3. **Subscription Abuse**
**Risk**: Free trial exploitation, account sharing, payment method cycling
**Impact**: Revenue loss, inflated user metrics, payment processor issues
**Prevention**: Device tracking, payment method limits, usage monitoring

### 4. **PCI Compliance Violation**
**Risk**: Storing card data incorrectly, security breaches
**Impact**: Massive fines ($5K-500K), payment processor termination
**Prevention**: NEVER store card data, use payment processors properly

---

## Platform-Specific Payment Implementation

### Telegram Bot Payments

#### Using Indonesian Payment Gateway (Midtrans Example)
```python
# Midtrans integration for Indonesian users
import requests
import base64
import hashlib
import hmac

def create_midtrans_payment(order_id, amount, customer_details):
    # Midtrans Snap API
    url = "https://app.sandbox.midtrans.com/snap/v1/transactions"  # Use production URL for live
    
    payload = {
        "transaction_details": {
            "order_id": order_id,
            "gross_amount": amount
        },
        "customer_details": customer_details,
        "credit_card": {
            "secure": True
        }
    }
    
    # Basic auth with server key
    server_key = os.getenv('MIDTRANS_SERVER_KEY')
    auth_string = base64.b64encode(f"{server_key}:".encode()).decode()
    
    headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': f'Basic {auth_string}'
    }
    
    response = requests.post(url, json=payload, headers=headers)
    return response.json()

# Webhook verification for Midtrans
def verify_midtrans_webhook(notification):
    server_key = os.getenv('MIDTRANS_SERVER_KEY')
    order_id = notification['order_id']
    status_code = notification['status_code']
    gross_amount = notification['gross_amount']
    
    # Create signature hash
    signature_key = hashlib.sha512(f"{order_id}{status_code}{gross_amount}{server_key}".encode()).hexdigest()
    
    return signature_key == notification['signature_key']
```

# Handle successful payments
def handle_successful_payment(update, context):
    payment = update.message.successful_payment

    # CRITICAL: Verify payment on your backend
    if verify_payment(payment):
        # Grant access to user
        grant_subscription(update.effective_user.id)

        # Log transaction for audit
        log_payment_success(
            user_id=update.effective_user.id,
            amount=payment.total_amount,
            currency=payment.currency,
            telegram_payment_charge_id=payment.telegram_payment_charge_id
        )
    else:
        # Payment verification failed - investigate
        alert_admin(f"Payment verification failed: {payment}")
```

#### Payment Verification (MANDATORY)
```python
def verify_payment(payment_data):
    """Verify payment actually happened and amount is correct"""
    try:
        # Check with your payment processor
        processor_response = payment_processor.verify_charge(
            charge_id=payment_data.provider_payment_charge_id
        )

        # Verify amount matches
        expected_amount = get_subscription_price()
        if processor_response.amount != expected_amount:
            return False

        # Verify currency
        if processor_response.currency != 'USD':
            return False

        return processor_response.status == 'succeeded'
    except Exception as e:
        log_error(f"Payment verification error: {e}")
        return False
```

### WhatsApp Bot Payments

#### Using External Payment Links
```javascript
// WhatsApp doesn't have native payments - use external processors
async function sendPaymentLink(phone, subscriptionType) {
    // Create Xendit payment link
    const paymentLink = await x.Invoice.createInvoice({
        externalId: `whatsapp-${phone}-${Date.now()}`,
        amount: getSubscriptionPrice(subscriptionType),
        description: `Subscription ${subscriptionType}`,
        customerDetails: {
            mobileNumber: phone
        },
        successRedirectUrl: `${BASE_URL}/payment/success?phone=${phone}`,
        failureRedirectUrl: `${BASE_URL}/payment/cancel`,
        paymentMethods: ['DANA', 'OVO', 'GOPAY', 'BANK_TRANSFER', 'CREDIT_CARD']
    });
    
    await sendWhatsAppMessage(phone, 
        `💳 Bayar langganan: ${paymentLink.invoice_url}\n\n` +
        `✅ DANA, OVO, GoPay, Transfer Bank\n` +
        `⏰ Link berlaku 24 jam`
    );
}

// Handle payment completion webhook
app.post('/payment/webhook', (req, res) => {
    const signature = req.headers['stripe-signature'];

    try {
        const event = stripe.webhooks.constructEvent(
            req.body, signature, STRIPE_WEBHOOK_SECRET
        );

        if (event.type === 'checkout.session.completed') {
            const session = event.data.object;
            const phone = session.metadata.phone;

            // Grant subscription
            grantSubscription(phone, session.subscription);

            // Notify user via WhatsApp
            sendWhatsAppMessage(phone,
                '🎉 Payment successful! Your subscription is now active.'
            );
        }
    } catch (err) {
        console.log(`Webhook signature verification failed.`);
        return res.status(400).send(`Webhook Error: ${err.message}`);
    }

    res.json({received: true});
});
```

### Discord Bot Payments

#### Using Slash Commands + External Payments
```javascript
// Discord slash command for subscription
const { SlashCommandBuilder } = require('discord.js');

module.exports = {
    data: new SlashCommandBuilder()
        .setName('subscribe')
        .setDescription('Subscribe to premium features'),
    async execute(interaction) {
        const userId = interaction.user.id;

        // Create payment session
        const session = await stripe.checkout.sessions.create({
            payment_method_types: ['card'],
            line_items: [{
                price: PREMIUM_PRICE_ID,
                quantity: 1,
            }],
            mode: 'subscription',
            success_url: `${BASE_URL}/success?session_id={CHECKOUT_SESSION_ID}`,
            cancel_url: `${BASE_URL}/cancel`,
            metadata: {
                discord_user_id: userId,
                discord_guild_id: interaction.guildId
            }
        });

        await interaction.reply({
            content: `💳 Complete your subscription: ${session.url}`,
            ephemeral: true
        });
    },
};
```

---

## Multi-Platform Payment Architecture

### Unified Payment Handler
```javascript
class PaymentManager {
    constructor() {
        this.stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);
        this.platforms = {
            telegram: new TelegramPayments(),
            whatsapp: new WhatsAppPayments(),
            discord: new DiscordPayments(),
            web: new WebPayments()
        };
    }

    async createSubscription(platform, userId, planType) {
        try {
            // Validate user and plan
            if (!this.validateSubscriptionRequest(userId, planType)) {
                throw new Error('Invalid subscription request');
            }

            // Create payment session based on platform
            const paymentSession = await this.platforms[platform]
                .createPaymentSession(userId, planType);

            // Log payment attempt
            await this.logPaymentAttempt(platform, userId, planType);

            return paymentSession;
        } catch (error) {
            await this.logPaymentError(platform, userId, error);
            throw error;
        }
    }

    async handlePaymentSuccess(platform, paymentData) {
        // Verify payment with processor
        const verified = await this.verifyPayment(paymentData);
        if (!verified) {
            await this.alertAdmin('Payment verification failed', paymentData);
            return;
        }

        // Grant subscription
        await this.grantSubscription(
            platform,
            paymentData.userId,
            paymentData.planType
        );

        // Send confirmation
        await this.platforms[platform]
            .sendPaymentConfirmation(paymentData.userId);

        // Log success
        await this.logPaymentSuccess(platform, paymentData);
    }
}
```

### Fraud Detection for Subscriptions
```javascript
class SubscriptionFraudDetector {
    async checkPaymentRisk(userId, paymentData) {
        const riskFactors = [];

        // Check velocity (multiple payments in short time)
        const recentPayments = await this.getRecentPayments(userId, '1hour');
        if (recentPayments.length > 3) {
            riskFactors.push('high_velocity');
        }

        // Check geographic anomaly
        const userLocation = await this.getUserLocation(userId);
        const paymentLocation = paymentData.billing_address?.country;
        if (userLocation && paymentLocation && userLocation !== paymentLocation) {
            riskFactors.push('geo_mismatch');
        }

        // Check for known fraudulent payment methods
        const cardFingerprint = paymentData.payment_method?.card?.fingerprint;
        if (await this.isBlacklistedCard(cardFingerprint)) {
            riskFactors.push('blacklisted_card');
        }

        // Check subscription patterns
        const activeSubscriptions = await this.getActiveSubscriptions(userId);
        if (activeSubscriptions.length > 5) {
            riskFactors.push('multiple_subscriptions');
        }

        return {
            riskScore: riskFactors.length,
            riskFactors: riskFactors,
            action: this.determineAction(riskFactors.length)
        };
    }

    determineAction(riskScore) {
        if (riskScore >= 3) return 'block';
        if (riskScore >= 2) return 'manual_review';
        return 'approve';
    }
}
```

---

## Essential Payment Security Rules

### 1. NEVER Store Card Data
```javascript
// ❌ NEVER DO THIS - PCI violation
const userCard = {
    number: '4111111111111111',
    exp_month: 12,
    exp_year: 2025,
    cvc: '123'
};

// ✅ ALWAYS DO THIS - Use payment processor tokens
const paymentMethod = await stripe.paymentMethods.create({
    type: 'card',
    card: {
        token: 'tok_visa'  // Token from Stripe.js
    }
});
```

### 2. Webhook Verification (CRITICAL)
```javascript
// ❌ NEVER trust webhook data without verification
app.post('/webhook', (req, res) => {
    const payment = req.body;
    grantSubscription(payment.user_id);  // DANGEROUS!
});

// ✅ ALWAYS verify webhook signatures
app.post('/webhook', express.raw({type: 'application/json'}), (req, res) => {
    const sig = req.headers['stripe-signature'];
    let event;

    try {
        event = stripe.webhooks.constructEvent(req.body, sig, WEBHOOK_SECRET);
    } catch (err) {
        console.log(`Webhook signature verification failed.`);
        return res.status(400).send(`Webhook Error: ${err.message}`);
    }

    // Now safe to process
    handlePaymentEvent(event);
    res.json({received: true});
});
```

### 3. Amount Verification
```javascript
function verifyPaymentAmount(receivedAmount, expectedAmount) {
    // Account for currency conversion and fees
    const tolerance = 0.05; // 5% tolerance
    const difference = Math.abs(receivedAmount - expectedAmount) / expectedAmount;

    if (difference > tolerance) {
        alertAdmin(`Payment amount mismatch: expected ${expectedAmount}, got ${receivedAmount}`);
        return false;
    }

    return true;
}
```

### 4. Subscription State Management
```javascript
class SubscriptionManager {
    async grantSubscription(platform, userId, planType) {
        const transaction = await db.beginTransaction();

        try {
            // Check if user already has active subscription
            const existing = await this.getActiveSubscription(userId);
            if (existing) {
                // Handle upgrade/downgrade logic
                await this.handleSubscriptionChange(existing, planType);
            } else {
                // Create new subscription
                await this.createSubscription(userId, planType);
            }

            // Update user permissions across all platforms
            await this.updateUserPermissions(userId, planType);

            await transaction.commit();
        } catch (error) {
            await transaction.rollback();
            throw error;
        }
    }
}
```

---

## Compliance & Legal Protection

### Terms of Service (MANDATORY)
```javascript
const SUBSCRIPTION_TOS = {
    refund_policy: "7-day refund policy for unused subscriptions",
    auto_renewal: "Subscriptions auto-renew unless cancelled 24 hours before renewal",
    service_availability: "Service provided 'as-is' with 99% uptime target",
    data_usage: "Subscription data stored for billing and service delivery only",
    cancellation: "Users can cancel anytime through bot commands or support"
};

// Show ToS before payment
function showTermsOfService(platform, userId) {
    const message =
        "📋 Terms of Service:\n" +
        `• ${SUBSCRIPTION_TOS.refund_policy}\n` +
        `• ${SUBSCRIPTION_TOS.auto_renewal}\n` +
        `• ${SUBSCRIPTION_TOS.service_availability}\n\n` +
        "By proceeding, you agree to these terms.";

    return sendMessage(platform, userId, message);
}
```

### GDPR Compliance for Payments
```javascript
// Allow users to request payment data
async function handleDataRequest(userId) {
    const paymentData = await db.query(`
        SELECT
            created_at,
            amount,
            currency,
            status,
            subscription_type
        FROM payments
        WHERE user_id = ?
        AND created_at > NOW() - INTERVAL 2 YEAR
    `, [userId]);

    // Remove sensitive data, keep only what's legally required
    const sanitizedData = paymentData.map(payment => ({
        date: payment.created_at,
        amount: payment.amount,
        currency: payment.currency,
        status: payment.status,
        type: payment.subscription_type
    }));

    return sanitizedData;
}
```

---

## Platform-Specific Bot Libraries Integration

### Go WhatsApp (go-whatsapp-web-multidevice)
```go
package main

import (
    "github.com/aldinokemal/go-whatsapp-web-multidevice/src/whatsapp"
)

func handleSubscriptionRequest(message whatsapp.Message) {
    // Create payment link
    paymentLink := createStripePaymentLink(SubscriptionRequest{
        Phone: message.Phone,
        Plan:  "premium",
    })

    // Send payment link via WhatsApp
    whatsapp.SendMessage(message.Phone,
        "💳 Subscribe to Premium:\n" + paymentLink +
        "\n\n⚡ Instant activation after payment")
}

func handlePaymentWebhook(w http.ResponseWriter, r *http.Request) {
    // Verify Stripe webhook
    payload, err := ioutil.ReadAll(r.Body)
    if err != nil {
        http.Error(w, err.Error(), http.StatusBadRequest)
        return
    }

    event, err := webhook.ConstructEvent(payload,
        r.Header.Get("Stripe-Signature"), webhookSecret)
    if err != nil {
        http.Error(w, err.Error(), http.StatusBadRequest)
        return
    }

    if event.Type == "checkout.session.completed" {
        session := event.Data.Object.(map[string]interface{})
        phone := session["metadata"].(map[string]interface{})["phone"].(string)

        // Grant subscription
        grantSubscription(phone)

        // Notify user
        whatsapp.SendMessage(phone, "🎉 Premium activated! Enjoy your new features.")
    }
}
```

### WAHA (WhatsApp HTTP API)
```javascript
const axios = require('axios');

class WAHAPayments {
    constructor(apiUrl, apiKey) {
        this.apiUrl = apiUrl;
        this.apiKey = apiKey;
    }

    async sendPaymentRequest(chatId, planType) {
        const paymentLink = await this.createPaymentLink(chatId, planType);

        await axios.post(`${this.apiUrl}/api/sendText`, {
            chatId: chatId,
            text: `💳 Subscribe to ${planType}:\n${paymentLink}\n\n` +
                  `✅ Secure payment via Stripe\n` +
                  `⚡ Instant activation`,
        }, {
            headers: { 'X-Api-Key': this.apiKey }
        });
    }

    async createPaymentLink(chatId, planType) {
        const session = await stripe.checkout.sessions.create({
            payment_method_types: ['card'],
            line_items: [{
                price: this.getPriceId(planType),
                quantity: 1,
            }],
            mode: 'subscription',
            success_url: `${process.env.BASE_URL}/success`,
            cancel_url: `${process.env.BASE_URL}/cancel`,
            metadata: {
                platform: 'whatsapp',
                chat_id: chatId,
                plan_type: planType
            }
        });

        return session.url;
    }
}
```

---

**Remember**: Payment processing is the #1 way to kill your business if done wrong. Use established processors (Xendit, Stripe, PayPal, etc), never store card data, always verify webhooks, and monitor for fraud patterns.
