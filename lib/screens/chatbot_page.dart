import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      "text": "Hi, I'm heading to the mall this afternoon",
      "isUser": false,
      "date": DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 2))),
      "time": "08:02"
    },
    {
      "text": "Do you wanna join with me?",
      "isUser": false,
      "date": DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 2))),
      "time": "08:03"
    },
    {
      "text": "It looks awesome!",
      "isUser": true,
      "date": DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 1))),
      "time": "08:21"
    },
    {
      "text": "But can I bring my girlfriend? They want to go to the mall.",
      "isUser": true,
      "date": DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 1))),
      "time": "08:22"
    },
    {
      "text": "Of course, just him",
      "isUser": false,
      "date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
      "time": "08:34",
      "images": [
        'assets/images/my_bag_images/coffee_table.jpg',
        'assets/images/my_bag_images/chair_image.jpg',
        'assets/images/my_bag_images/shelf.jpg',
        'assets/images/my_bag_images/shelf.jpg',
        'assets/images/my_bag_images/shelf.jpg',
        'assets/images/my_bag_images/shelf.jpg'
      ]
    },
    {
      "text": "Thanks Rehan",
      "isUser": true,
      "date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
      "time": "08:36"
    },
    {
      "text": "Ur Welcome!",
      "isUser": false,
      "date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
      "time": "08:38"
    },
  ];

  late PageController _pageController; // PageController for PageView
  late Timer _timer; // Timer for automatic sliding

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoSlide();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        _pageController.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _sendMessage() {
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        _messages.add({
          "text": _controller.text,
          "isUser": true,
          "date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
          "time": TimeOfDay.now().format(context)
        });
        _controller.clear();
      });
    }
  }

  String _formatDate(String date) {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final yesterday = DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 1)));

    if (date == today) {
      return "Today";
    } else if (date == yesterday) {
      return "Yesterday";
    } else {
      return DateFormat('MMM d, yyyy').format(DateTime.parse(date));
    }
  }

  void _showImageDialog(String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Image.asset(imagePath, fit: BoxFit.cover),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<Map<String, dynamic>>> groupedMessages = {};
    for (var message in _messages) {
      String date = message['date'];
      if (!groupedMessages.containsKey(date)) {
        groupedMessages[date] = [];
      }
      groupedMessages[date]!.add(message);
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // White rounded body with glowing effect
          Positioned(
            top: 120, // Increase this value to make the white part lower
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.7),
                    spreadRadius: 8,
                    blurRadius: 5,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Expanded chat list
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 20, bottom: 70),
                      itemCount: groupedMessages.keys.length,
                      itemBuilder: (context, index) {
                        String date = groupedMessages.keys.elementAt(index);
                        List<Map<String, dynamic>> messages = groupedMessages[date]!;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                              child: Center(
                                child: Text(
                                  _formatDate(date),
                                  style: TextStyle(
                                    color: Color(0xFFD6CADD),
                                    fontFamily: 'OnboardingFont2',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            ...messages.map((message) {
                              bool isUserMessage = message['isUser'];
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: isUserMessage
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: isUserMessage
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.start,
                                      children: [
                                        if (!isUserMessage) // Image for received messages
                                          Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: AssetImage('assets/images/chatbot_images/robot_image.png'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: Container(
                                            constraints: BoxConstraints(
                                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                                            ),
                                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                            decoration: BoxDecoration(
                                              color: isUserMessage
                                                  ? Color(0xFFf8f8ff)
                                                  : Color(0xFFeee8aa),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(30),
                                                topRight: Radius.circular(30),
                                                bottomLeft: isUserMessage
                                                    ? Radius.circular(30)
                                                    : Radius.circular(30),
                                                bottomRight: isUserMessage
                                                    ? Radius.circular(30)
                                                    : Radius.circular(30),
                                              ),
                                            ),
                                            child: Column(
                                              crossAxisAlignment: isUserMessage
                                                  ? CrossAxisAlignment.end
                                                  : CrossAxisAlignment.start,
                                              children: [
                                                if (message.containsKey('images')) // Check for image keys
                                                  Container(
                                                    height: 150, // Adjust the height of the image slider
                                                    child: PageView.builder(
                                                      controller: _pageController,
                                                      scrollDirection: Axis.horizontal,
                                                      itemCount: message['images'].length,
                                                      itemBuilder: (context, imageIndex) {
                                                        return Padding(
                                                          padding: EdgeInsets.only(right: 8),
                                                          child: GestureDetector(
                                                            onTap: () => _showImageDialog(message['images'][imageIndex]),
                                                            child: Image.asset(
                                                              message['images'][imageIndex],
                                                              width: MediaQuery.of(context).size.width, // Full width
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                if (!message.containsKey('images'))
                                                  Text(
                                                    message['text'],
                                                    style: TextStyle(color: Colors.black87),
                                                  ),
                                                SizedBox(height: 5),
                                                Align(
                                                  alignment: isUserMessage
                                                      ? Alignment.bottomRight
                                                      : Alignment.bottomLeft,
                                                  child: Text(
                                                    message['time'],
                                                    style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
                        );
                      },
                    ),
                  ),

                  // Input Area at the Bottom
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Color(0xFFf8f8ff),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 5,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Color(0xFFE0B0FF),
                            child: IconButton(
                              icon: Icon(Icons.mic, color: Color(0xFF7851A9)),
                              onPressed: () {},
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              decoration: InputDecoration(
                                hintText: 'Message...',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                hintStyle: TextStyle(color: Colors.grey[600]),
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Color(0xFFF0FFFF),
                            child: IconButton(
                              icon: Icon(Icons.send_rounded, color: Color(0xFF89CFF0)),
                              onPressed: _sendMessage,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Header (black bar with user info)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 100,
            child: Container(
              color: Color(0xFF000000),
              padding: EdgeInsets.only(top: 30, left: 16, right: 16),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF292929),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios_rounded, color: Color(0xFFf9f9f9)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        image: AssetImage('assets/images/chatbot_images/robot_image.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'AI ChatBot',
                          style: TextStyle(color: Color(0xFFf9f9f9), fontFamily:'OnBoardingFont2',fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Version 1.1.1',
                          style: TextStyle(color: Colors.greenAccent, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.more_vert, color: Color(0xFFf9f9f9)),
                    onPressed: () {
                      // Options button functionality here
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}