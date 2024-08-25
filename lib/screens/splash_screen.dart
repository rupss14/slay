import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:slay/screens/home_screen.dart';
import 'package:slay/screens/login_screen.dart';
import 'package:slay/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 4),
    ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginScreen(),
    )));
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
              image: AssetImage("assets/images/image11.jpg"),
              fit: BoxFit.cover,
              opacity: 0.3,
            )),
        child: Stack(
          children: [
            // Positioned.fill(
            //   child: Align(
            //     alignment: Alignment.center,
            //     child: Image.asset(
            //       'images/imgg.png',
            //       width: 300, // Adjust the size of the logo
            //       height: 300,
            //     ),
            //   ),
            //  ),

            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Slay', // Text to be animated
                      textStyle: TextStyle(
                        fontFamily: 'Winterlady', // Using Winterlady font
                        fontSize: 40,
                        color: Color(0xFFf0e68c),
                      ),
                      speed: Duration(milliseconds: 1000), // Speed of the typing effect
                    ),
                  ],
                  totalRepeatCount: 1, // Only animate once
                  pause: Duration(milliseconds: 700), // Pause before finishing
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
