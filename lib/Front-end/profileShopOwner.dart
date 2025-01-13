// lib/profileShopOwner.dart
import 'package:flutter/material.dart';
import 'shopOwnerNavBar.dart';
import 'jobPostShopOwner.dart';
import 'StaffMembersShopOwner.dart';

class ProfileShopOwner extends StatefulWidget {
  @override
  _ProfileShopOwnerState createState() => _ProfileShopOwnerState();
}

class _ProfileShopOwnerState extends State<ProfileShopOwner> {
  final TextEditingController shopNameController = TextEditingController(text: 'KOIF Salon');
  final TextEditingController addressController = TextEditingController(text: '123 Main St, City, Country');
  final TextEditingController hoursController = TextEditingController(text: '10:00 AM - 8:00 PM');
  final TextEditingController phoneController = TextEditingController(text: '+1234567890');
  final TextEditingController emailController = TextEditingController(text: 'owner@koif.com');
  bool isProfilePictureSet = false;
  String selectedLanguage = "English";
  final List<bool> isHovered = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8DA9C4),
      appBar: AppBar(
        backgroundColor: Color(0xFF8DA9C4),
        elevation: 0,
        title: Text('Profile', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
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
                          ? AssetImage('assets/images/avatar_chair.png')
                          : null,
                      child: isProfilePictureSet
                          ? null
                          : Icon(Icons.person, size: 60, color: Colors.grey[600]),
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
                  'Hi, ${shopNameController.text}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 30),
                _buildProfileButton(
                  icon: Icons.language,
                  label: 'Language',
                  index: 0,
                  onPressed: _showLanguageSelectionDialog,
                ),
                _buildProfileButton(
                  icon: Icons.edit,
                  label: 'Edit Business Details',
                  index: 1,
                  onPressed: () => _showEditBusinessDetailsDialog(context),
                ),
                _buildProfileButton(
                  icon: Icons.post_add,
                  label: 'Job Post',
                  index: 2,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => JobPostShopOwner()),
                    );
                  },
                ),
                _buildProfileButton(
                  icon: Icons.people,
                  label: 'Staff Members',
                  index: 3,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StaffMembersShopOwner()),
                    );
                  },
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
      ),
      bottomNavigationBar: ShopOwnerNavBar(selectedIndex: 2),
    );
  }

  Widget _buildProfileButton({
    required IconData icon,
    required String label,
    required int index,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                  Navigator.pop(context);
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
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showEditBusinessDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Shop Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildEditableField(label: 'Shop Name', controller: shopNameController),
              _buildEditableField(label: 'Address', controller: addressController),
              _buildEditableField(label: 'Working Hours', controller: hoursController),
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
