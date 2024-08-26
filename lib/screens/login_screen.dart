import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:slay/constants/colors.dart';
import 'package:slay/screens/register_screen.dart';

class LoginScreen extends StatelessWidget {
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
                image: AssetImage('assets/images/login_page_images/background_image2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Darkening Gradient
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.4), // Dark at the top
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
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 150, left: 16.0, right: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left
                    mainAxisSize: MainAxisSize.min, // Minimize column size to fit content
                    children: [
                      // Header Text
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0), // Add left margin
                        child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Log into\n',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontFamily: 'LogInFontBold',
                                ),
                              ),
                              TextSpan(
                                text: 'your account',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontFamily: 'LogInFontBold',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      // Phone Number/Email Input
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0), // Add left margin
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 1), // Adjust vertical padding here
                            labelText: 'Phone Number/Email',
                            labelStyle: TextStyle(color: Color(0xFFd9d9d9), fontFamily: 'LogInFont'),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Password Input
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0), // Add left margin
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 1), // Adjust vertical padding here
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Color(0xFFd9d9d9), fontFamily: 'LogInFont'),
                            suffixText: 'Forget?',
                            suffixStyle: TextStyle(color: Color(0xFFd9d9d9), fontFamily: 'LogInFont'),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      // Log In Button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0), // Horizontal padding
                        child: SizedBox(
                          width: double.infinity, // Full width
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              backgroundColor: Color(0xFFE5C366),
                              foregroundColor: Color(0xFFeee8aa),
                              padding: EdgeInsets.symmetric(vertical: 12), // Button padding
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero, // Sharp edges
                              ),
                            ),
                            child: Text('Log In', style: TextStyle(fontFamily: 'LogInFont', color: Colors.black)),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // "or Sign In with" Text
                      Center(
                        child: Text(
                          "or Sign In with",
                          style: TextStyle(color: Color(0xFFd9d9d9), fontFamily: 'LogInFont'),
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
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              // Sign Up Link
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(color: Color(0xFFd9d9d9), fontFamily: 'LogInFont'),
                      children: [
                        TextSpan(
                          text: 'Sign up.',
                          style: TextStyle(color: Color(0xFFd9d9d9), fontFamily: 'LogInFont',fontWeight: FontWeight.w900,),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>RegisterPage(),
                              ));

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
}
