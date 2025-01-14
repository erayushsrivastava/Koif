// const express = require('express');
// const router = express.Router();
const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);

// const AWS = require('aws-sdk');
// const docClient = new AWS.DynamoDB.DocumentClient({
//     region: process.env.AWS_REGION, // Replace with your AWS region
// });

// // Create Router

// // Define Table Name
// const TABLE_NAME = "Payments"; // Replace with your DynamoDB table name

// // Route to Create Payment and Add to DynamoDB


// router.post('/create-payment', async (req, res) => {
//     try {
//         console.log('Received payment request:', req.body);
//         const { amount, currency,customerId} = req.body;

//         // Create Stripe Payment Session
//         const session = await stripe.checkout.sessions.create({
//             payment_method_types: ['card'],
//             line_items: [{  
//                 price_data: {
//                     currency: currency,
//                     product_data: {
//                         name: 'Payment',
//                     },
//                     unit_amount: amount,
//                 },
//                 quantity: 1,
//             }],
//             mode: 'payment',
//             success_url: 'http://192.168.31.245:5000/api/success',
//             cancel_url: 'http://192.168.31.245:5000/api/cancel',
//         });

//         console.log('Created session:', session);

//         // Add Payment Data to DynamoDB
//         const params = {
//             TableName: TABLE_NAME,
//             Item: {
//                 paymentId: session.id,
//                 amount: amount,
//                 currency: currency,
//                 paymentStatus: 'Pending',
//                 createdAt: new Date().toISOString(),
//                 paymentMethod: 'Stripe',
//                 customerId: customerId
//             },
//         };
//         console.log('Adding payment data to DynamoDB:', params.Item);

//         await docClient.put(params).promise();
//         console.log('Payment data added to DynamoDB:', params.Item);

//         // Send the Payment Session URL to the client
//         res.json({ url: session.url });
//     } catch (error) {
//         console.error('Payment error:', error);
//         res.status(500).json({ error: error.message });
//     }
// });

// // Route to Update Payment Status
// router.get('/update-payment-status', async (req, res) => {
//     try {
//         console.log('Received request to update payment status');
//         const sessionId = req.query.sessionId;
//         if (!sessionId) {
//             return res.status(400).json({ error: 'Session ID is required' });
//         }
//         console.log('Payment Session ID:', sessionId);
//         // Retrieve the Checkout Session
//         const session = await stripe.checkout.sessions.retrieve(sessionId);

//         if (!session) {
//             return res.status(404).json({ error: 'Checkout Session not found' });
//         }

//         const paymentIntentId = session.payment_intent;

//         if (!paymentIntentId) {
//             return res.status(400).json({ error: 'Payment Intent is null or missing' });
//         }

//         // Retrieve the Payment Intent
//         const paymentIntent = await stripe.paymentIntents.retrieve(paymentIntentId);

//         console.log('Payment Status:', paymentIntent.status);

//         // Update Payment Status in DynamoDB
//         const updateParams = {
//             TableName: TABLE_NAME,
//             Key: { paymentId: sessionId },
//             UpdateExpression: 'set paymentStatus = :status, updatedAt = :updatedAt',
//             ExpressionAttributeValues: {
//                 ':status': paymentIntent.status,
//                 ':updatedAt': new Date().toISOString(),
//             },
//             ReturnValues: 'UPDATED_NEW',
//         };

//         await docClient.update(updateParams).promise();
//         console.log('Payment status updated in DynamoDB:', updateParams.Key);

//         res.status(200).json({ status: paymentIntent.status });
//     } catch (error) {
//         console.error('Error fetching payment status:', error.message);
//         res.status(500).json({ error: error.message });
//     }
// });


// module.exports = router;





// routes/custmorpayment.js

const express = require('express');
const router = express.Router();
const AWS = require('aws-sdk');
const docClient = new AWS.DynamoDB.DocumentClient({ region: process.env.AWS_REGION });

// Define Table Names
const ORDER_TABLE_NAME = "Orders"; // Replace with your DynamoDB Orders table name
const PAYMENT_TABLE_NAME = "Payments"; // Replace with your DynamoDB Payments table name

// Route to Create Payment and Add to DynamoDB
router.post('/create-payment', async (req, res) => {
    try {
        console.log('Received payment request:', req.body);
        const { amount, currency, customerId, serviceProviderId, serviceDetails } = req.body;

        // Create Stripe Payment Session
        const session = await stripe.checkout.sessions.create({
            payment_method_types: ['card'],
            line_items: [{
                price_data: {
                    currency: currency,
                    product_data: {
                        name: serviceDetails.name,
                    },
                    unit_amount: amount,
                },
                quantity: 1,
            }],
            mode: 'payment',
            success_url: 'http://192.168.31.245:5000/api/success',
            cancel_url: 'http://192.168.31.245:5000/api/cancel',
        });

        // Save Order to DynamoDB
        const order = {
            customerId,
            serviceProviderId,
            serviceDetails,
            orderStatus: 'Pending',
            paymentStatus: 'Paid',
            createdAt: new Date().toISOString(),
            orderId: session.id // Using session ID as a temporary order ID
        };

        await docClient.put({
            TableName: ORDER_TABLE_NAME,
            Item: order,
        }).promise();

        // Save Payment to DynamoDB
        const payment = {
            orderId: session.id,
            amountPaid: amount,
            platformFeeDeducted: calculatePlatformFee(amount),
            payoutAmount: amount - calculatePlatformFee(amount),
            paymentStatus: 'Pending',
            transactionDetails: session,
            createdAt: new Date().toISOString(),
        };

        await docClient.put({
            TableName: PAYMENT_TABLE_NAME,
            Item: payment,
        }).promise();

        res.status(200).json({ sessionId: session.id });
    } catch (error) {
        console.error('Payment error:', error);
        res.status(500).json({ error: 'Payment processing failed' });
    }
});

// Route to Complete Service
router.post('/complete-service/:orderId', async (req, res) => {
    const { orderId } = req.params;

    // Retrieve order from DynamoDB
    const orderData = await docClient.get({
        TableName: ORDER_TABLE_NAME,
        Key: { orderId }
    }).promise();

    const order = orderData.Item;

    if (order && order.orderStatus === 'Pending') {
        order.orderStatus = 'Completed';

        // Update order status in DynamoDB
        await docClient.update({
            TableName: ORDER_TABLE_NAME,
            Key: { orderId },
            UpdateExpression: 'set orderStatus = :s',
            ExpressionAttributeValues: {
                ':s': 'Completed',
            },
        }).promise();

        // Trigger Payment Release
        const paymentData = await docClient.get({
            TableName: PAYMENT_TABLE_NAME,
            Key: { orderId }
        }).promise();

        const payment = paymentData.Item;
        if (payment) {
            const payoutAmount = payment.amountPaid - payment.platformFeeDeducted;

            // Implement fund transfer logic here (e.g., call to payment gateway)
            await transferFunds(order.serviceProviderId, payoutAmount); // Implement this function

            // Update payment status
            payment.paymentStatus = 'Released';
            await docClient.update({
                TableName: PAYMENT_TABLE_NAME,
                Key: { orderId },
                UpdateExpression: 'set paymentStatus = :s',
                ExpressionAttributeValues: {
                    ':s': 'Released',
                },
            }).promise();

            res.status(200).json({ message: 'Service completed and payment released' });
        } else {
            res.status(404).json({ message: 'Payment not found' });
        }
    } else {
        res.status(400).json({ message: 'Order not found or already completed' });
    }
});

// Helper function to calculate platform fee
function calculatePlatformFee(amount) {
    const feePercentage = 0.1; // 10% fee, for example
    return amount * feePercentage;
}

// Helper function to transfer funds (mock implementation)
async function transferFunds(serviceProviderId, amount) {
    // Implement the logic to transfer funds to the service provider
    console.log(`Transferring ${amount} to service provider ${serviceProviderId}`);
}

module.exports = router;
