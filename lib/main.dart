import 'package:flutter/material.dart';
import 'package:slay/screens/chatbot_page.dart';
import 'package:slay/screens/onboarding_screen.dart';
import 'package:slay/screens/splash_screen.dart';

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
      home: ChatPage(),
    );
  }
}
