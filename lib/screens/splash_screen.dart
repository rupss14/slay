import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:slay/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 5), // Adjusted to 3 seconds
          () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage("assets/images/splash_screen_images/splash_screen_image.jpg"),
            fit: BoxFit.cover,
            opacity: 0.3,
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Slay',
                          textStyle: TextStyle(
                            fontFamily: 'Winterlady',
                            fontSize: 40,
                            color: Color(0xFFf0e68c),
                          ),
                          speed: Duration(milliseconds: 1000),
                        ),
                      ],
                      totalRepeatCount: 1,
                      pause: Duration(milliseconds: 700),
                      displayFullTextOnTap: true,
                      stopPauseOnTap: true,
                    ),
                    SizedBox(height: 30), // Space between texts
                    Text(
                      '"SLAY EVERYDAY EVERY DEAL"',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFFf0e68c),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
