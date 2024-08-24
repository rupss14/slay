import 'package:flutter/material.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  final List<Widget> _onboardingPages = [
    OnboardingPage(
      image: 'assets/images/on_boarding_images/onboarding_image11.png',
      title: 'Fashion Query Answering',
      description: 'Provides accurate answers to various fashion-related questions.',
    ),
    OnboardingPage(
      image: 'assets/images/on_boarding_images/onboarding_image2.png',
      title: 'Outfit Suggestion',
      description: 'Recommends complete outfits tailored to specific occasions or user preferences.',
    ),
    OnboardingPage(
      image: 'assets/images/onboarding3.png',
      title: 'Accessory Styling',
      description: 'Suggests matching accessories to complement an outfit.',
    ),
    OnboardingPage(
      image: 'assets/images/onboarding3.png',
      title: 'Skin Tone Analysis',
      description: 'Analyzes skin tone to offer personalized fashion advice and color recommendations.',
    ),
    OnboardingPage(
      image: 'assets/images/onboarding2.png',
      title: 'One-Click-Shop',
      description: 'Enables seamless purchasing of recommended items directly from the chatbot',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background with radial gradient
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                //color: Colors.black,
                image: DecorationImage(
                  image: AssetImage("assets/images/on_boarding_images/gradient.png"),
                  fit: BoxFit.cover,

                )),
            // decoration: BoxDecoration(
            //   gradient: RadialGradient(
            //     center: Alignment.topLeft,
            //     radius: 0.6, // Adjusts the size of the gradient
            //     colors: [
            //       Colors.grey,
            //       Colors.black,
            //     ],
            //     stops: [0.2, 1.0], // Smooth transition from grey to black over 20% of the radius
            //   ),
            // ),
          ),
          // Page View for Onboarding Pages
          PageView.builder(
            controller: _pageController,
            itemCount: _onboardingPages.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return _onboardingPages[index];
            },
          ),
          // Top Row with Heading and Close Icon
          Positioned(
            top: 30, // Adjusted to move contents slightly higher
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Heading and Step Counter
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'slay',
                      style: TextStyle(
                        fontFamily: 'OnBoardingFont2',
                        color: Color(0xFFf7e98e), // Light color for the heading
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Step ${currentIndex + 1} / ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: '${_onboardingPages.length}',
                            style: TextStyle(
                              color: Colors.grey[700], // Off color for the total number
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Close Icon
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white, size: 24),
                  onPressed: () {
                    // Navigate to the home page or handle close action
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(), // Your home page
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          // Bottom Previous Icon Button on the Left
          Positioned(
            bottom: 70, // Adjusted to move contents higher
            left: 20,
            child: Visibility(
              visible: currentIndex > 0, // Hide if on the first page
              child: IconButton(
                icon: ImageIcon(
                  AssetImage("assets/images/icons/arrow_back_icon.png"),
                  size: 50,
                ),
                onPressed: () {
                  if (currentIndex > 0) {
                    // Navigate to the previous page
                    _pageController.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
              ),
            ),
          ),
          // Bottom Circular Next Button in the Middle
          Positioned(
            bottom: 70, // Adjusted to move contents higher
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: 80,
                height: 80,
                child: FloatingActionButton(
                  backgroundColor: Color(0xFFf7e98e), // Background color of the button

                  onPressed: () {
                    if (currentIndex == _onboardingPages.length - 1) {
                      // Navigate to the home page if on the last page
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(), // Your home page
                        ),
                      );
                    } else {
                      // Go to the next page
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Icon(
                    currentIndex == _onboardingPages.length - 1
                        ? Icons.check // Change to a checkmark on the last page
                        : Icons.arrow_forward, // Forward arrow icon
                    color: Colors.black, // Set icon color to black
                    size: 35, // Adjust icon size
                  ),
                  shape: CircleBorder(), // Ensure the button is circular
                  elevation: 5, // Optional: adds a shadow
                  splashColor: Color(0xFFeee8aa), // Optional: splash color on press
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const OnboardingPage({
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 200,
            width: 200,// Reduced height for the image
            //fit: BoxFit.cover, // Ensure the image covers the area without distortion
          ),
          SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'OnBoardingFont1',
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white, // White text color
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20), // Increased space between title and description
          Text(
            description,
            style: TextStyle(
              fontFamily: 'OnBoardingFont2',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white70, // Slightly lighter white for the description
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40), // Space below the description for the button
        ],
      ),
    );
  }
}