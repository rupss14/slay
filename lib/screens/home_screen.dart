import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:slay/screens/chatbot_page.dart';
import 'package:slay/screens/my_bag_screen.dart';
import 'package:slay/screens/search_page.dart';
import 'package:slay/screens/swipe_to_style.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(), // Replace with your actual home screen widget
    ClothSwipePage(), // Replace with your actual search screen widget
    ChatPage(), // Replace with your actual chat screen widget
    SearchBar(), // Replace with your actual profile screen widget
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: [
              Image.asset(
                // "assets/images/logo_image/slay_transparent_background_logo.png",
                 "assets/images/slay_black.png",
                width: 80,
                height: 80,
              ),
              //SizedBox(width: 5),
              Text(
                'slay',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  // fontFamily: 'Winterlady',
                  fontFamily: 'OnBoardingFont2',
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0), // Align the icons with the title
            child: IconButton(
              icon: Icon(Icons.favorite_border_sharp), // Wishlist Icon
              onPressed: () {
                // Add wishlist functionality here
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0), // Align the icons with the title
            child: IconButton(
              icon: Icon(Icons.shopping_cart_sharp), // Add to Cart Icon
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => MyBagScreen()),
                // );
              },
            ),
          ),
        ],
      ),



      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBar(),
              SizedBox(height: 16),
              SpotlightSection(),
              SizedBox(height: 16),
              CollectionsSection(),
              SizedBox(height: 16),
              FeaturedItemsSection(),
              SizedBox(height: 16),
              ShopAgainSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8.0), // Adjust the bottom padding here
        child: CurvedNavigationBar(
          height: 50, // Adjust the height of the navigation bar
          backgroundColor: Colors.black,
          items: <Widget>[
            Icon(Icons.home, size: 30),
            ImageIcon(AssetImage("assets/images/icons/swipe_to_style_icon.png"),size: 30,),
            ImageIcon(AssetImage("assets/images/home_screen_images/chatbot.png"),size: 30,),
            ImageIcon(AssetImage("assets/images/home_screen_images/indie_icon.png"),size: 45,),
          ],
          onTap: (index) {
            switch (index) {
              case 0:

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
                break;
              case 1:

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClothSwipePage()),
                );
                break;
              case 2:

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatPage()),
                );
                break;
              case 3:

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => SearchBar()),
                // );
                // break;
            }
          },
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40, // Reduced height
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Newest arrivals',
          hintStyle: TextStyle(color:Colors.black,fontSize: 14,fontFamily: 'OnBoardingFont2',fontWeight: FontWeight.w600), // Smaller hint text
          prefixIcon: Icon(Icons.search_sharp, size: 20), // Smaller icon
          filled: true,
          fillColor: Colors.white, // White background
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12), // Adjust padding
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey[300]!, width: 1), // Light grey border
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey[400]!, width: 1), // Slightly darker when focused
          ),
        ),
          onSubmitted: (value) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchResultsPage(searchQuery: value),
              ),
            );
          } ,
      ),
    );
  }
}
class SpotlightSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,  // Adjusted height
      decoration: BoxDecoration(
        color: Color(0xFFE5C366),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFfafad2),  // Subtle outer shadow
            blurRadius: 10,
            spreadRadius:3,
          ),
        ],
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0),
                  child: Column(
                    children: [
                      Container(
                        width: 160,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          //borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'SPOTLIGHT',
                            style: TextStyle(
                              fontSize: 22,  // Slightly larger text
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Trendy clothing in the spotlight',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: 'OnBoardingFont2',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  child: Image.asset(
                    'assets/images/home_screen_images/spotlight_image.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
          // Inner shadow effect
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: RadialGradient(
                colors: [
                  Colors.black.withOpacity(0.2), // Inner shadow color
                  Colors.transparent,
                ],
                center: Alignment.center,
                radius: 1.2,  // Adjust the radius to change the spread of the shadow
                stops: [0.0, 1.0],
              ),
            ),
          ),
        ],
      ),
    );
  }
}




class FeaturedItemsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Featured items', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextButton(onPressed: () {}, child: Text('View all',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold))),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: FeaturedItemCard(
                title: 'Dresses',
                price: 'Rs 1999',
                imageUrl: 'assets/images/home_screen_images/dress_image.jpg', // Different image
                sale: true,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: FeaturedItemCard(
                title: 'Accessories',
                price: 'Rs 699',
                imageUrl: 'assets/images/home_screen_images/accessory_image.jpg', // Different image
                discount: true,
              ),
            ),
          ],
        ),

      ],
    );
  }
}

class FeaturedItemCard extends StatelessWidget {
  final String title;
  final String price;
  final bool sale;
  final bool discount;
  final String imageUrl;

  FeaturedItemCard({
    required this.title,
    required this.price,
    required this.imageUrl,
    this.sale = false,
    this.discount = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFfafad2),
      elevation: 2, // Reduced elevation for the card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Soft rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0), // Add padding inside the card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0), // Padding around the image
              decoration: BoxDecoration(
                color: Colors.grey[200], // Soft background color
                borderRadius: BorderRadius.circular(16), // Rounded corners for the image container
              ),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.contain, // Adjust the image fitting
                height: 140, // Set a fixed height for the image
              ),
            ),
            SizedBox(height: 12), // Spacing between image and text
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              price,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {},
              child: Text('Explore', style: TextStyle(fontSize: 14,color: Colors.black)), // Smaller text for the button
              style: ElevatedButton.styleFrom(
                 backgroundColor: Color(0xFFE5C366),// Background color of the button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Soft rounded button
                ),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Reduced padding for smaller button
              ),
            ),
          ],
        ),
      ),
    );
  }
}





class CollectionsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Collections', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextButton(onPressed: () {}, child: Text('View all',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
          ],
        ),
        SizedBox(height: 8),
        Container(
          height: 100, // Increased height to accommodate the CollectionItem
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              CollectionItem(imageUrl: 'assets/images/icons/new_icon.png', label: 'New'),
              SizedBox(width: 16),
              CollectionItem(imageUrl: 'assets/images/icons/limited_icon.png', label: 'Limited'),
              SizedBox(width: 16),
              CollectionItem(imageUrl: 'assets/images/icons/shirt_icon2.png', label: 'Clothing'),
              SizedBox(width: 16),
              CollectionItem(imageUrl:'assets/images/icons/accessory_icon.png' , label: 'Jwellery'),
              SizedBox(width: 16),
              CollectionItem(imageUrl: 'assets/images/icons/shoes_icon.png', label: 'Shoes'),
              SizedBox(width: 16),
              CollectionItem(icon: Icons.watch, label: 'Watches'),
              SizedBox(width: 16),
              CollectionItem(icon: Icons.shopping_bag, label: 'Bags'),
              SizedBox(width: 16),
              CollectionItem(imageUrl: 'assets/images/icons/hats_icon.png', label: 'Hats'),
              SizedBox(width: 16),
              CollectionItem(imageUrl: 'assets/images/icons/eyewear_icon.png', label: 'Eye Wear'),
            ],
          ),
        ),
      ],
    );
  }
}



class CollectionItem extends StatelessWidget {
  final IconData? icon;
  final String? imageUrl;
  final String? label;

  CollectionItem({this.icon, this.imageUrl, this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: () {
            // Handle button press
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFfafad2),
            shape: CircleBorder(),
            padding: EdgeInsets.all(8),
            minimumSize: Size(60, 60),
            elevation: 2,
          ),
          child: imageUrl != null
              ? Image.asset(imageUrl!, width: 30, height: 30) // Use image if provided
              : Icon(icon, color: Color(0xFFE5C366), size: 30), // Use icon otherwise
        ),
        SizedBox(height: 4), // Space between icon and text
        if (label != null)
          Text(
            label!,
            style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600, color: Colors.black,fontFamily: 'OnBoardingFont2'),
            textAlign: TextAlign.center, // Center the label text
          ),
      ],
    );
  }
}




class ShopAgainSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Shop again', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextButton(onPressed: () {}, child: Text('View all', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: ShopAgainCard(
              title: 'Luxury Dresses',
              price: 'Rs 2999',
              imageUrl: 'assets/images/home_screen_images/luxury_dress.jpg', // Different image URL
            )),
            SizedBox(width: 16),
            Expanded(child: ShopAgainCard(
              title: 'Street Style',
              price: 'Rs 899',
              imageUrl: 'assets/images/home_screen_images/street_style.jpg', // Different image URL
            )),
          ],
        ),
      ],
    );
  }
}


class ShopAgainCard extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl; // Add imageUrl parameter

  ShopAgainCard({
    required this.title,
    required this.price,
    required this.imageUrl, // Require imageUrl
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFfafad2),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset(
                imageUrl, // Use the imageUrl parameter
                fit: BoxFit.contain,
                height: 140,
              ),
            ),
            SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              price,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {},
              child: Text('Shop now', style: TextStyle(color: Colors.black, fontSize: 14)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFE5C366),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

