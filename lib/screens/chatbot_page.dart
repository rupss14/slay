import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      "date": DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 2))), // Date added
      "time": "08:02"
    },
    {
      "text": "Do you wanna join with me?",
      "isUser": false,
      "date": DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 2))), // Date added
      "time": "08:03"
    },
    {
      "text": "It looks awesome!",
      "isUser": true,
      "date": DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 1))), // Date added
      "time": "08:21"
    },
    {
      "text": "But can I bring my girlfriend? They want to go to the mall.",
      "isUser": true,
      "date": DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 1))), // Date added
      "time": "08:22"
    },
    {
      "text": "Of course, just him",
      "isUser": false,
      "date": DateFormat('yyyy-MM-dd').format(DateTime.now()), // Date added
      "time": "08:34"
    },
    {
      "text": "Thanks Rehan",
      "isUser": true,
      "date": DateFormat('yyyy-MM-dd').format(DateTime.now()), // Date added
      "time": "08:36"
    },
    {
      "text": "Ur Welcome!",
      "isUser": false,
      "date": DateFormat('yyyy-MM-dd').format(DateTime.now()), // Date added
      "time": "08:38"
    },
  ];

  void _sendMessage() {
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        _messages.add({
          "text": _controller.text,
          "isUser": true,
          "date": DateFormat('yyyy-MM-dd').format(DateTime.now()), // Date added
          "time": TimeOfDay.now().format(context)
        });
        _controller.clear();
      });
    }
  }

  // Helper function to format dates
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
                    color: Colors.white.withOpacity(0.7), // Glow color
                    spreadRadius: 8,
                    blurRadius: 5,
                    offset: Offset(0, 0), // Adjust the offset for different effects
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Expanded chat list
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 20, bottom: 70), // Adjust bottom padding to fit the smaller input box
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
                                  _formatDate(date), // Display formatted date
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
                                child: Row(
                                  mainAxisAlignment: isUserMessage
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                                  children: [
                                    if (!isUserMessage) // Image for received messages
                                      Container(
                                        width: 30, // Reduced width
                                        height: 30, // Reduced height
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: AssetImage('assets/images/chatbot_images/robot_image1.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    SizedBox(width: 8), // Spacing between image and message
                                    Expanded(
                                      child: Container(
                                        constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: isUserMessage
                                              ? Color(0xFFf8f8ff) // Light color for user messages
                                              : Color(0xFFeee8aa), // Light color for received messages
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
                              );
                            }).toList(),
                          ],
                        );
                      },
                    ),
                  ),

                  // Input Area at the Bottom
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15), // Reduced vertical padding
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
                            radius: 20, // Reduced radius for a smaller button
                            backgroundColor:  Color(0xFFE0B0FF),
                            child: IconButton(
                              icon: Icon(Icons.mic, color:Color(0xFF7851A9)),
                              onPressed:(){

                              }
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              decoration: InputDecoration(
                                hintText: 'Message...',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Reduced vertical padding
                                hintStyle: TextStyle(color: Colors.grey[600]),
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 20, // Reduced radius for a smaller button
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
            height: 100, // Adjust height to fit your header
            child: Container(
              color: Color(0xFF000000),
              padding: EdgeInsets.only(top: 30, left: 16, right: 16),
              child: Row(
                children: [
                  Container(
                    width: 40, // Width of the circle
                    height: 40, // Height of the circle
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF292929), // Light background color for the circle
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios_rounded, color: Color(0xFFf9f9f9)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(width: 16), // Adjusted space to shift content right
                  Container(
                    width: 60, // Adjust the width
                    height: 60, // Adjust the height
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        image: AssetImage('assets/images/chatbot_images/robot_image1.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 16), // Space between image and name
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'AI ChatBot',
                          style: TextStyle(color: Color(0xFFf9f9f9), fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Active now',
                          style: TextStyle(color: Color(0xFFf9f9f9), fontSize: 14),
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
