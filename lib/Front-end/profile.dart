import 'package:flutter/material.dart';
import 'globalNavigatorBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController(text: '+33 98******04');
  final TextEditingController emailController = TextEditingController(text: 'm****@gmail.com');
  bool isProfilePictureSet = false;
  String selectedLanguage = 'English';
  String userName = "User"; // Default name

  final List<bool> isHovered = [false, false, false, false];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Load user data from SharedPreferences
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedName = prefs.getString('userName');
    setState(() {
      userName = storedName ?? "User"; // Use default if no name is stored
      nameController.text = userName; // Set the loaded name in the nameController
    });
  }

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
                'Hi, $userName',
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
                onPressed: _showLanguageSelectionDialog,
              ),
              _buildProfileButton(
                icon: Icons.edit,
                label: 'Edit Profile',
                index: 1,
                onPressed: () => _showEditProfileDialog(context),
              ),
              _buildProfileButton(
                icon: Icons.payment,
                label: 'Payment Methods',
                index: 2,
                onPressed: () {},
              ),
              _buildProfileButton(
                icon: Icons.logout,
                label: 'Logout',
                index: 3,
                onPressed: () {
                  print('Logout button pressed');
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GlobalNavigationBar(selectedIndex: 2), // Profile tab
    );
  }

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
              _buildEditableField(label: 'Email', controller: emailController),
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
                // Save the name to SharedPreferences
                _saveUserName();
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
  }) {
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

  // Save the updated name to SharedPreferences
  Future<void> _saveUserName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', nameController.text);
  }
}
