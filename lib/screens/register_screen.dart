import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For picking images
import 'dart:io';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:slay/screens/home_screen.dart'; // For social icons

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
      body: Stack(
        children: [
          // Background Image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/login_page_images/background_image1.jpg'), // Use same background image
                fit: BoxFit.cover,
              ),
            ),
          ),

          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.9), // Dark at the top
                  Colors.black.withOpacity(0.3), // Lighter at the bottom
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Foreground Content
          Column(
            children: [
              // Fixed Header with "Create Your Account" text and Profile Picture
              Container(
                padding: const EdgeInsets.only(top: 70.0, left: 16.0, right: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // "Create Your Account" Text with left margin
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Create",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontFamily: 'LogInFont', // Use the same font
                              fontWeight: FontWeight.bold, // Make it bold
                            ),
                          ),
                          Text(
                            "your account",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontFamily: 'LogInFont', // Use the same font
                              fontWeight: FontWeight.bold, // Make it bold
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Profile Picture with alignment
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 40, // Profile picture size
                        backgroundColor: Colors.white.withOpacity(0.8),
                        backgroundImage: _imageFile != null
                            ? FileImage(File(_imageFile!.path))
                            : null,
                        child: _imageFile == null
                            ? Icon(FontAwesome.camera_alt, size: 40, color: Colors.black)
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5), // Space to avoid overlap

              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30), // Spacing

                      // First Name TextField
                      _buildTextField("Full Name"),
                      SizedBox(height: 20),

                      // Phone Number TextField
                      _buildTextField("Phone Number", keyboardType: TextInputType.phone),
                      SizedBox(height: 20),

                      // Email Address TextField
                      _buildTextField("Email Address"),
                      SizedBox(height: 20),

                      // Password TextField
                      _buildTextField("Password", isPassword: true),
                      SizedBox(height: 20),

                      // Confirm Password TextField
                      _buildTextField("Confirm Password", isPassword: true),
                      SizedBox(height: 40),

                      // Register Button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0), // Horizontal padding
                        child: SizedBox(
                          width: double.infinity, // Full width
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => HomePage()),
                              );
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Color(0xFFE5C366),
                              foregroundColor: Color(0xFFeee8aa),
                              padding: EdgeInsets.symmetric(vertical: 12), // Button padding
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero, // Sharp edges
                              ),
                            ),
                            child: Text('Register', style: TextStyle(fontFamily: 'LogInFont', color: Colors.black)),
                          ),
                        ),
                      ),
                      SizedBox(height: 30), // Spacing

                      // "Or sign up with" Text
                      Center(
                        child: Text(
                          "or Sign up with",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'LogInFont',
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      // Social Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Facebook Button
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0), // Add spacing between buttons
                            child: SizedBox(
                              width: 150,
                              child: TextButton.icon(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.transparent, // Transparent background
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  side: BorderSide(color: Color(0xFFE5C366), width: 2), // White outline
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero, // Sharp edges
                                  ),
                                ),
                                icon: Icon(FontAwesome.facebook, color: Colors.white, size: 20), // Smaller size
                                label: Text('Facebook', style: TextStyle(fontFamily: 'LogInFont')),
                              ),
                            ),
                          ),
                          // Google Button
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0), // Add spacing between buttons
                            child: SizedBox(
                              width: 150,
                              child: TextButton.icon(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.transparent, // Transparent background
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  side: BorderSide(color: Color(0xFFE5C366), width: 2), // White outline
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero, // Sharp edges
                                  ),
                                ),
                                icon: Icon(FontAwesome.google, color: Colors.white, size: 20), // Smaller size
                                label: Text('Google', style: TextStyle(fontFamily: 'LogInFont')),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20), // Spacing
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(color: Color(0xFFd9d9d9), fontFamily: 'LogInFont'),
                      children: [
                        TextSpan(
                          text: 'Login here',
                          style: TextStyle(color: Color(0xFFd9d9d9), fontFamily: 'LogInFont', fontWeight: FontWeight.w900),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pop(context);
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper method to build a TextField widget
  Widget _buildTextField(String labelText, {bool isPassword = false, TextInputType keyboardType = TextInputType.text}) {
    return Container(
      margin: const EdgeInsets.only(left: 16.0, right: 8.0), // Add right margin here
      child: TextField(
        obscureText: isPassword,
        keyboardType: keyboardType,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 1), // Adjust vertical padding here
          labelText: labelText,
          labelStyle: TextStyle(color: Color(0xFFd9d9d9), fontFamily: 'LogInFont'),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
