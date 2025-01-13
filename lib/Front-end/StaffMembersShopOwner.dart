// lib/StaffMembersShopOwner.dart
import 'package:flutter/material.dart';

class StaffMembersShopOwner extends StatefulWidget {
  @override
  _StaffMembersShopOwnerState createState() => _StaffMembersShopOwnerState();
}

class _StaffMembersShopOwnerState extends State<StaffMembersShopOwner> {
  final List<Map<String, String>> staffMembers = []; // Store staff details
  final TextEditingController nameController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  // Function to add new staff member
  void _addStaffMember() {
    setState(() {
      staffMembers.add({
        'name': nameController.text,
        'role': roleController.text,
        'contact': contactController.text,
      });
      nameController.clear();
      roleController.clear();
      contactController.clear();
    });
  }

  // Function to show the Add/Edit staff member dialog
  void _showStaffDialog({int? index}) {
    if (index != null) {
      nameController.text = staffMembers[index]['name']!;
      roleController.text = staffMembers[index]['role']!;
      contactController.text = staffMembers[index]['contact']!;
    } else {
      nameController.clear();
      roleController.clear();
      contactController.clear();
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(index == null ? 'Add Staff Member' : 'Edit Staff Member'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: roleController,
                decoration: InputDecoration(labelText: 'Role'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: contactController,
                decoration: InputDecoration(labelText: 'Contact Info'),
                keyboardType: TextInputType.phone,
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
                  if (index == null) {
                    _addStaffMember();
                  } else {
                    staffMembers[index] = {
                      'name': nameController.text,
                      'role': roleController.text,
                      'contact': contactController.text,
                    };
                  }
                });
                Navigator.pop(context);
              },
              child: Text(index == null ? 'Add' : 'Save'),
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
        title: Text('Staff Members', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: staffMembers.length,
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
                        staffMembers[index]['name']!,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Role: ${staffMembers[index]['role']}',
                            style: TextStyle(color: Colors.white70, fontSize: 14),
                          ),
                          Text(
                            'Contact: ${staffMembers[index]['contact']}',
                            style: TextStyle(color: Colors.white70, fontSize: 14),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.white),
                            onPressed: () => _showStaffDialog(index: index),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.white),
                            onPressed: () {
                              setState(() {
                                staffMembers.removeAt(index);
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
              onPressed: () => _showStaffDialog(),
              icon: Icon(Icons.add),
              label: Text('Add Staff Member'),
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
