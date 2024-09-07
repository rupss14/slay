import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:slay/screens/home_screen.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with SingleTickerProviderStateMixin {
  XFile? _imageFile;
  late AnimationController _animationController;
  late Animation<double> _animation;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFile = image;
      });
      _showSkinToneDialog();
    }
  }

  void _showSkinToneDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width * 0.8,
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ANALYZING YOUR SKIN',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: FileImage(File(_imageFile!.path)),
                          ),
                          AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: 1 + (_animation.value * 0.1),
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.blue.withOpacity(0.5),
                                      width: 2,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Text(
                        'Please wait while we analyze your skin...',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _showAnalysisResults();
                        },
                        child: Text('Show Results'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:  Color(0xFFE5C366),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  String getSkinColorCode() {
    // Dummy implementation. Replace with actual logic to get skin color code.
    return '#F1C6B7'; // Example color code
  }

  void _showAnalysisResults() {
    // Mocked JSON data for demonstration purposes
    final Map<String, dynamic> analysisData = {
      'Colour Palette': ['#DAA520', '#8B4513', '#FF4500', '#556B2F', '#BDB76B'],
      'Explanation': "The user's skin tone has warm, golden undertones typical of an Autumn color type. The rich, deep quality of the complexion suits earthy and warm colors.",
      'Season': 'Autumn',
      'Styles': 'Opt for rich textures like leather, suede, and wool in earth tones. Clothing styles should be classic with clean lines to enhance natural warmth.',
    };

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Color(0xFFeee8aa),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'YOUR SKIN ANALYSIS RESULTS',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                _buildFeatureRow('TEXTURE', 4),
                _buildFeatureRow('DARK CIRCLES', 2),
                _buildFeatureRow('LINES & WRINKLES', 3),
                _buildFeatureRow('DARK SPOTS', 1),
                SizedBox(height: 20),

                // Display the color palette
                Text(
                  'Recommended Colour Palette:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: analysisData['Colour Palette'].map<Widget>((color) {
                    return Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Color(int.parse(color.replaceFirst('#', '0xFF'))),
                        shape: BoxShape.circle,
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),

                // Display explanation
                Text(
                  'Explanation:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  analysisData['Explanation'],
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 20),

                // Display season
                Text(
                  'Season: ${analysisData['Season']}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20),

                // Display style suggestions
                Text(
                  'Style Suggestions:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  analysisData['Styles'],
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 20),

                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('OK'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  Widget _buildFeatureRow(String feature, int level) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            feature,
            style: TextStyle(fontSize: 16),
          ),
          Row(
            children: List.generate(
              5,
                  (index) => Icon(
                index < level ? Icons.circle : Icons.circle_outlined,
                size: 16,
                color: index < level ? Colors.black : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendUserData() async {
    final url = 'http://10.0.2.2:5001/post-endpoint'; // Ensure the URL and port are correct.

    // Prepare the image data
    String? base64Image;
    if (_imageFile != null) {
      final imageBytes = await _imageFile!.readAsBytes();
      base64Image = base64Encode(imageBytes);
    }

    // Prepare user data
    final userData = {
      'name': _fullNameController.text,
      'phone_number': _phoneNumberController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
      'image': base64Image,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration successful!')),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: ${response.reasonPhrase}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
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
          // Container(
          //   width: double.infinity,
          //   height: double.infinity,
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //       colors: [
          //         Colors.black.withOpacity(0.3), // Dark at the top
          //         Colors.black.withOpacity(0.3), // Lighter at the bottom
          //       ],
          //       begin: Alignment.topCenter,
          //       end: Alignment.bottomCenter,
          //     ),
          //   ),
          // ),
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
                      onTap: _pickImage, // Call the method here
                      child: CircleAvatar(
                        radius: 40, // Profile picture size
                        backgroundColor: Colors.white.withOpacity(0.8),
                        backgroundImage: AssetImage('assets/images/registration_images/profile_image.jpg'),
                        child: null,
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

                      // Full Name TextField
                      _buildTextField("Full Name", controller: _fullNameController),
                      SizedBox(height: 20),

                      // Phone Number TextField
                      _buildTextField("Phone Number", keyboardType: TextInputType.phone, controller: _phoneNumberController),
                      SizedBox(height: 20),

                      // Email Address TextField
                      _buildTextField("Email Address", controller: _emailController),
                      SizedBox(height: 20),

                      // Password TextField
                      _buildTextField("Password", isPassword: true, controller: _passwordController),
                      SizedBox(height: 20),

                      // Confirm Password TextField
                      _buildTextField("Confirm Password", isPassword: true), //controller: _confirmPasswordController),
                      SizedBox(height: 40),

                      // Register Button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0), // Horizontal padding
                        child: SizedBox(
                          width: double.infinity, // Full width
                          child: TextButton(
                            onPressed: _sendUserData,
                            // onPressed: (){
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(builder: (context) => HomePage()),
                            //   );
                            // },
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
  Widget _buildTextField(String labelText, {bool isPassword = false, TextInputType keyboardType = TextInputType.text, TextEditingController? controller}) {
    return Container(
      margin: const EdgeInsets.only(left: 16.0, right: 8.0),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 1),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
