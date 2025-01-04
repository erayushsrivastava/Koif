import 'package:flutter/material.dart';

class ServiceRateList extends StatefulWidget {
  @override
  _ServiceRateListState createState() => _ServiceRateListState();
}

class _ServiceRateListState extends State<ServiceRateList> {
  final TextEditingController _serviceNameController = TextEditingController();
  final TextEditingController _serviceRateController = TextEditingController();

  // List to store services and rates
  List<Map<String, String>> services = [];

  // Function to add a service to the list
  void _addService() {
    if (_serviceNameController.text.isNotEmpty &&
        _serviceRateController.text.isNotEmpty) {
      setState(() {
        services.add({
          'name': _serviceNameController.text,
          'rate': _serviceRateController.text,
        });
        _serviceNameController.clear();
        _serviceRateController.clear();
      });
    }
  }

  // Function to remove a service from the list
  void _removeService(int index) {
    setState(() {
      services.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Services and Rate List'),
        backgroundColor: Color(0xFF0B2545), // App theme color
        elevation: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'Add Services and Rates',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0B2545),
              ),
            ),
            SizedBox(height: 10),

            // Service Name Input
            TextField(
              controller: _serviceNameController,
              decoration: InputDecoration(
                hintText: 'Service Name (e.g., Hair Cut)',
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFF0B2545), width: 2),
                ),
              ),
            ),
            SizedBox(height: 10),

            // Service Rate Input
            TextField(
              controller: _serviceRateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Service Rate (e.g., 500)',
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFF0B2545), width: 2),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Add Service Button
            Center(
              child: ElevatedButton(
                onPressed: _addService,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0B2545),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Add Service',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 30),

            // Displaying List of Services
            Text(
              'Services and Rates',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0B2545),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: services.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      title: Text(
                        services[index]['name'] ?? '',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Rate: \$${services[index]['rate']}',
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _removeService(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
