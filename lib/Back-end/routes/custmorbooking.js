import express from 'express';
import AWS from 'aws-sdk';

const router = express.Router();
const dynamoDB = new AWS.DynamoDB.DocumentClient();

// DynamoDB Table Name
const TABLE_NAME = 'Bookings';

// POST: Create a Booking
router.post('/create-booking', async (req, res) => {
    try {
        // Extract input parameters from the request body
        const { serviceId, customerId, providerId, bookingDate, location } = req.body;

        // Generate a unique booking ID
        const bookingId = `booking-${Date.now()}`;

        // Define initial status and payment status
        const status = 'pending';
        const paymentStatus = 'unpaid';

        // Construct the booking data object
        const bookingData = {
            TableName: TABLE_NAME,
            Item: {
                bookingId,             // Unique Booking ID
                serviceId,             // Service associated with the booking
                customerId,            // Customer ID
                providerId,            // Service Provider ID
                bookingDate,           // Date and time of the booking
                status,                // Initial booking status
                paymentStatus,         // Initial payment status
                location: location || {}, // Optional location object
                createdAt: new Date().toISOString(), // Timestamp
            },
        };

        console.log('Creating booking with data:', bookingData.Item);

        // Save the booking in DynamoDB
        await dynamoDB.put(bookingData).promise();

        console.log('Booking created successfully:', bookingId);

        // Return a success response
        res.status(201).json({
            message: 'Booking created successfully!',
            bookingId: bookingId,
            status: status,
        });
    } catch (error) {
        console.error('Error creating booking:', error);

        // Handle errors and return an error response
        res.status(500).json({
            message: 'Error creating booking',
            error: error.message,
        });
    }
});

export default router;
