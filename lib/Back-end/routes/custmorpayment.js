const express = require('express');
const router = express.Router();
const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);

const AWS = require('aws-sdk');
const docClient = new AWS.DynamoDB.DocumentClient({
    region: process.env.AWS_REGION, // Replace with your AWS region
});

// Create Router

// Define Table Name
const TABLE_NAME = "Payments"; // Replace with your DynamoDB table name

// Route to Create Payment and Add to DynamoDB


router.post('/create-payment', async (req, res) => {
    try {
        console.log('Received payment request:', req.body);
        const { amount, currency,customerId} = req.body;

        // Create Stripe Payment Session
        const session = await stripe.checkout.sessions.create({
            payment_method_types: ['card'],
            line_items: [{  
                price_data: {
                    currency: currency,
                    product_data: {
                        name: 'Payment',
                    },
                    unit_amount: amount,
                },
                quantity: 1,
            }],
            mode: 'payment',
            success_url: 'http://192.168.31.245:5000/api/success',
            cancel_url: 'http://192.168.31.245:5000/api/cancel',
        });

        console.log('Created session:', session);

        // Add Payment Data to DynamoDB
        const params = {
            TableName: TABLE_NAME,
            Item: {
                paymentId: session.id,
                amount: amount,
                currency: currency,
                paymentStatus: 'Pending',
                createdAt: new Date().toISOString(),
                paymentMethod: 'Stripe',
                customerId: customerId
            },
        };
        console.log('Adding payment data to DynamoDB:', params.Item);

        await docClient.put(params).promise();
        console.log('Payment data added to DynamoDB:', params.Item);

        // Send the Payment Session URL to the client
        res.json({ url: session.url });
    } catch (error) {
        console.error('Payment error:', error);
        res.status(500).json({ error: error.message });
    }
});

// Route to Update Payment Status
router.get('/update-payment-status', async (req, res) => {
    try {
        console.log('Received request to update payment status');
        const sessionId = req.query.sessionId;
        if (!sessionId) {
            return res.status(400).json({ error: 'Session ID is required' });
        }
        console.log('Payment Session ID:', sessionId);
        // Retrieve the Checkout Session
        const session = await stripe.checkout.sessions.retrieve(sessionId);

        if (!session) {
            return res.status(404).json({ error: 'Checkout Session not found' });
        }

        const paymentIntentId = session.payment_intent;

        if (!paymentIntentId) {
            return res.status(400).json({ error: 'Payment Intent is null or missing' });
        }

        // Retrieve the Payment Intent
        const paymentIntent = await stripe.paymentIntents.retrieve(paymentIntentId);

        console.log('Payment Status:', paymentIntent.status);

        // Update Payment Status in DynamoDB
        const updateParams = {
            TableName: TABLE_NAME,
            Key: { paymentId: sessionId },
            UpdateExpression: 'set paymentStatus = :status, updatedAt = :updatedAt',
            ExpressionAttributeValues: {
                ':status': paymentIntent.status,
                ':updatedAt': new Date().toISOString(),
            },
            ReturnValues: 'UPDATED_NEW',
        };

        await docClient.update(updateParams).promise();
        console.log('Payment status updated in DynamoDB:', updateParams.Key);

        res.status(200).json({ status: paymentIntent.status });
    } catch (error) {
        console.error('Error fetching payment status:', error.message);
        res.status(500).json({ error: error.message });
    }
});


module.exports = router;
