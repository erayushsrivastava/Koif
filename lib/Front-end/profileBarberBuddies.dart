// lib/ProfileBarberBuddies.dart
import 'package:flutter/material.dart';
import 'barberBuddiesNavBar.dart';
import 'servicesRateListBarberBuddies.dart';

class ProfileBarberBuddies extends StatefulWidget {
  @override
  _ProfileBarberBuddiesState createState() => _ProfileBarberBuddiesState();
}

class _ProfileBarberBuddiesState extends State<ProfileBarberBuddies> {
  final TextEditingController nameController = TextEditingController(text: 'John Doe');
  final TextEditingController phoneController = TextEditingController(text: '+1234567890');
  final TextEditingController addressController = TextEditingController(text: '123 Main St, City, Country');
  bool isProfilePictureSet = false;
  String selectedLanguage = "English"; // Default language

  final List<bool> isHovered = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8DA9C4),
      appBar: AppBar(
        backgroundColor: Color(0xFF8DA9C4),
        elevation: 0,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: isProfilePictureSet
                        ? AssetImage('assets/images/avatar_placeholder.png')
                        : null,
                    child: isProfilePictureSet
                        ? null
                        : Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.grey[600],
                          ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isProfilePictureSet = true;
                        });
                      },
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.camera_alt, color: Colors.white, size: 18),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Hi, ${nameController.text}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 40),
              _buildProfileButton(
                icon: Icons.language,
                label: 'Language',
                index: 0,
                onPressed: () {
                  _showLanguageSelectionDialog();
                },
              ),
              _buildProfileButton(
                icon: Icons.edit,
                label: 'Edit Profile',
                index: 1,
                onPressed: () {
                  _showEditProfileDialog(context);
                },
              ),
              _buildProfileButton(
                icon: Icons.work,
                label: 'Services',
                index: 2,
                onPressed: () {
                   Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ServicesRateListBarberBuddies(),
      ),
    );
                },
              ),
              _buildProfileButton(
                icon: Icons.payment,
                label: 'Payment Methods',
                index: 3,
                onPressed: () {},
              ),
              _buildProfileButton(
                icon: Icons.logout,
                label: 'Logout',
                index: 4,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BarberBuddiesNavBar(
        selectedIndex: 2,
        acceptedJobs: const [],
      ),
    );
  }

  // Profile button with hover effect
  Widget _buildProfileButton({
    required IconData icon,
    required String label,
    required int index,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered[index] = true),
        onExit: (_) => setState(() => isHovered[index] = false),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          width: double.infinity,
          height: 65,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isHovered[index] ? Color(0xFF0B2545).withOpacity(0.8) : Color(0xFF0B2545),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: Offset(0, 6),
                blurRadius: 12,
              ),
            ],
          ),
          child: ElevatedButton.icon(
            onPressed: onPressed,
            icon: Icon(icon, color: Colors.white),
            label: Text(label, style: TextStyle(color: Colors.white, fontSize: 18)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Language selection dialog
  void _showLanguageSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile(
                title: Text('English'),
                value: 'English',
                groupValue: selectedLanguage,
                onChanged: (value) {
                  setState(() {
                    selectedLanguage = value.toString();
                  });
                  Navigator.pop(context); // Close dialog after selection
                },
              ),
              RadioListTile(
                title: Text('French'),
                value: 'French',
                groupValue: selectedLanguage,
                onChanged: (value) {
                  setState(() {
                    selectedLanguage = value.toString();
                  });
                  Navigator.pop(context); // Close dialog after selection
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildEditableField(label: 'Name', controller: nameController),
              _buildEditableField(label: 'Phone', controller: phoneController),
              _buildEditableField(label: 'Address', controller: addressController),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {});
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEditableField({required String label, required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
