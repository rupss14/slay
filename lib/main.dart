import 'package:flutter/material.dart';
import 'package:slay/screens/chatbot_page.dart';
import 'package:slay/screens/home_screen.dart';
import 'package:slay/screens/login_screen.dart';
import 'package:slay/screens/my_bag_screen.dart';
import 'package:slay/screens/register_screen.dart';
import 'package:slay/screens/onboarding_screen.dart';
import 'package:slay/screens/shipment_page.dart';
import 'package:slay/screens/splash_screen.dart';
import 'package:slay/screens/swipe_to_style.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Slay",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor:Color(0xFF4a790),
      ),
      home:HomePage(),
    );
  }
}
