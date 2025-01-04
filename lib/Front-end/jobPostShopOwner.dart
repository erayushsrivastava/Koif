// lib/jobPostShopOwner.dart
import 'package:flutter/material.dart';

class JobPostShopOwner extends StatefulWidget {
  @override
  _JobPostShopOwnerState createState() => _JobPostShopOwnerState();
}

class _JobPostShopOwnerState extends State<JobPostShopOwner> {
  final TextEditingController serviceController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final List<Map<String, String>> jobPosts = []; // Store posted jobs

  void _addJobPost() {
    setState(() {
      jobPosts.add({
        'service': serviceController.text,
        'rate': rateController.text,
      });
      serviceController.clear();
      rateController.clear();
    });
  }

  void _editJobPost(int index) {
    // Populate controllers with existing values for editing
    serviceController.text = jobPosts[index]['service']!;
    rateController.text = jobPosts[index]['rate']!;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Job Vacancy'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: serviceController,
                decoration: InputDecoration(labelText: 'Service Required'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: rateController,
                decoration: InputDecoration(labelText: 'Rate/Salary Offered'),
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
                  jobPosts[index] = {
                    'service': serviceController.text,
                    'rate': rateController.text,
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

  void _showAddJobDialog() {
    serviceController.clear();
    rateController.clear();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Job Vacancy'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: serviceController,
                decoration: InputDecoration(labelText: 'Service Required'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: rateController,
                decoration: InputDecoration(labelText: 'Rate/Salary Offered'),
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
                _addJobPost();
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
        title: Text('Job Postings', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: jobPosts.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Color(0xFF231942),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 8,
                          offset: Offset(3, 4),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      title: Text(
                        jobPosts[index]['service']!,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                      subtitle: Text(
                        'Salary: \$${jobPosts[index]['rate']}',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.white), // Edit icon
                            onPressed: () {
                              _editJobPost(index); // Call edit function
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.white),
                            onPressed: () {
                              setState(() {
                                jobPosts.removeAt(index);
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
              onPressed: _showAddJobDialog,
              icon: Icon(Icons.add),
              label: Text(
                'Add Job Vacancy',
                style: TextStyle(color: Colors.white),
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
