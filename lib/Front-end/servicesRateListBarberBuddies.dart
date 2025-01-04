// lib/ServicesRateListBarberBuddies.dart
import 'package:flutter/material.dart';

class ServicesRateListBarberBuddies extends StatefulWidget {
  @override
  _ServicesRateListBarberBuddiesState createState() => _ServicesRateListBarberBuddiesState();
}

class _ServicesRateListBarberBuddiesState extends State<ServicesRateListBarberBuddies> {
  final List<Map<String, String>> services = []; // List to store services and prices
  final TextEditingController serviceController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  void _addService() {
    setState(() {
      services.add({
        'service': serviceController.text,
        'price': priceController.text,
      });
      serviceController.clear();
      priceController.clear();
    });
  }

  void _editService(int index) {
    // Pre-fill the controllers with the current service and price values
    serviceController.text = services[index]['service']!;
    priceController.text = services[index]['price']!;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Service'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: serviceController,
                decoration: InputDecoration(labelText: 'Service Name'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  services[index] = {
                    'service': serviceController.text,
                    'price': priceController.text,
                  };
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showAddServiceDialog() {
    serviceController.clear();
    priceController.clear();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Service'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: serviceController,
                decoration: InputDecoration(labelText: 'Service Name'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _addService();
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8DA9C4),
        title: Text('Services & Rates', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xFF8DA9C4), // Screen background color
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: services.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Color(0xFF231942), // Service background color
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: Offset(3, 4),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      title: Text(
                        services[index]['service']!,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                      subtitle: Text(
                        '\$${services[index]['price']}',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      trailing: Wrap(
                        spacing: 12,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.white),
                            onPressed: () => _editService(index),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                services.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton.icon(
              onPressed: _showAddServiceDialog,
              icon: Icon(Icons.add),
              label: Text(
                'Add New Service',
                style: TextStyle(color: Colors.white), // Button text color set to white
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0B2545),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                shadowColor: Colors.black,
                elevation: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
