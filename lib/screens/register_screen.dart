import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For picking images
import 'dart:io';
import '';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  XFile? _imageFile; // Variable to hold the picked image

  // Method to pick an image from gallery
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 40.0), // Padding around the edges
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage("assets/images/imdfdsgrdg1.jpg"), // Background image
            fit: BoxFit.cover,
            opacity: 0.3,
          ),
        ),
        child: Center(
          child: SingleChildScrollView( // Allows for scrolling if content overflows
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Profile Picture
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50, // Reduced size to fit better
                    backgroundColor: Colors.white.withOpacity(0.8),
                    backgroundImage: _imageFile != null
                        ? FileImage(File(_imageFile!.path))
                        : null,
                    child: _imageFile == null
                        ? Icon(Icons.add_a_photo, size: 40, color: Colors.black)
                        : null,
                  ),
                ),
                SizedBox(height: 30), // Adjusted vertical spacing

                // First Name TextField
                _buildTextField("First Name"),
                SizedBox(height: 20),

                // Last Name TextField
                _buildTextField("Last Name"),
                SizedBox(height: 20),

                // Phone Number TextField
                _buildTextField("Phone Number", keyboardType: TextInputType.phone),
                SizedBox(height: 20),

                // Delivery Address TextField
                _buildTextField("Delivery Address"),
                SizedBox(height: 20),

                // Password TextField
                _buildTextField("Password", isPassword: true),
                SizedBox(height: 20),

                // Confirm Password TextField
                _buildTextField("Confirm Password", isPassword: true),
                SizedBox(height: 40),

                // Register Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15), // Reduced padding
                    backgroundColor: Color(0xFFeee8aa), // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // Handle registration action
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),

                SizedBox(height: 30), // Adjusted spacing

                // "Already have an account?" Text with clickable "Login here"
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 8), // Space between text and clickable link
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context); // Navigate back to login page
                      },
                      child: Text(
                        'Login here',
                        style: TextStyle(
                          color: Colors.blue, // Color for the clickable text
                          fontSize: 16,
                          decoration: TextDecoration.underline, // Underline for clickable text
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build a TextField widget
  Widget _buildTextField(String labelText, {bool isPassword = false, TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      obscureText: isPassword,
      obscuringCharacter: '•',
      keyboardType: keyboardType,
      style: TextStyle(
        fontSize: 18, // Reduced font size for better fit
        color: Colors.white,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          fontFamily: 'TextFieldFont',
          color: Colors.white,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        filled: true,
        fillColor: Colors.black.withOpacity(0.6),
      ),
    );
  }
}
