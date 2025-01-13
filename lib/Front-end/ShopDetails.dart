import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import for image picking functionality
import 'dart:io'; // Import for handling files

class ShopDetails extends StatefulWidget {
  @override
  _ShopDetailsState createState() => _ShopDetailsState();
}

class _ShopDetailsState extends State<ShopDetails> {
  // Controllers for form inputs
  TextEditingController shopNameController = TextEditingController();
  TextEditingController shopAddressController = TextEditingController();

  // List to hold selected images
  List<XFile>? _selectedImages = [];

  // Function to pick images from gallery
  Future<void> _pickImages() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? selectedImages = await _picker.pickMultiImage();

    if (selectedImages != null) {
      setState(() {
        _selectedImages!.addAll(selectedImages);
      });
    }
  }

  // Function to remove an image
  void _removeImage(int index) {
    setState(() {
      _selectedImages!.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop Details'),
        backgroundColor: Color(0xFF0B2545), // Darker theme color
        elevation: 10,
        shadowColor: Colors.black.withOpacity(0.5),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name of Shop
              _buildSectionHeader('Name of Shop'),
              SizedBox(height: 10),
              _buildTextField('Enter the name of your shop', shopNameController),
              SizedBox(height: 20),

              // Shop Photos Section
              _buildSectionHeader('Photos of Shop'),
              SizedBox(height: 10),
              _buildPhotoUploadSection(), // Builds the image upload section
              SizedBox(height: 20),

              // Address of Shop
              _buildSectionHeader('Address of Shop'),
              SizedBox(height: 10),
              _buildTextField('Enter the address of your shop', shopAddressController),
              SizedBox(height: 30),

              // Save Button
              Center(
                child: _buildSaveButton(), // Save details button
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to build section headers
  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF0B2545),
      ),
    );
  }

  // Widget to build text field with a consistent style
  Widget _buildTextField(String hintText, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Color(0xFF0B2545),
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Color(0xFF0B2545),
            width: 2,
          ),
        ),
      ),
    );
  }

  // Widget to build the photo upload section
  Widget _buildPhotoUploadSection() {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: _pickImages, // Pick images from gallery
          icon: Icon(Icons.photo_library, color: Colors.white),
          label: Text('Upload Photos', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF0B2545),
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 5,
            shadowColor: Colors.black.withOpacity(0.3),
          ),
        ),
        SizedBox(height: 10),

        // Display selected images
        _selectedImages != null && _selectedImages!.isNotEmpty
            ? GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _selectedImages!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          File(_selectedImages![index].path),
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          icon: Icon(Icons.cancel, color: Colors.red),
                          onPressed: () => _removeImage(index), // Remove image
                        ),
                      ),
                    ],
                  );
                },
              )
            : Text(
                'No photos uploaded yet.',
                style: TextStyle(color: Colors.grey[600]),
              ),
      ],
    );
  }

  // Widget to build the Save button
  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: _saveShopDetails, // Handle save operation
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF0B2545), // Dark blue button color
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 10,
        shadowColor: Colors.black.withOpacity(0.5),
      ),
      child: Text(
        'Save Details',
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }

  // Placeholder function to handle saving shop details
  void _saveShopDetails() {
    String shopName = shopNameController.text;
    String shopAddress = shopAddressController.text;

    if (shopName.isEmpty || shopAddress.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all the details.')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Shop details saved successfully.')),
    );
  }
}
