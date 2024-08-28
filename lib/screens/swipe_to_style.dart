import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:slay/screens/my_bag_screen.dart';
import 'package:slay/screens/product_page.dart';

class ClothSwipePage extends StatefulWidget {
  @override
  _ClothSwipePageState createState() => _ClothSwipePageState();
}

class _ClothSwipePageState extends State<ClothSwipePage> {
  final CardSwiperController controller = CardSwiperController();

  // State for icon colors
  Color closeIconColor = Colors.black;
  Color favoriteIconColor = Colors.black;
  Color favoriteBackgroundColor = Color(0xFFdcdcdc);
  Color cartIconColor = Colors.black;
  Color cartBackgroundColor = Color(0xFFdcdcdc);

  // List of items with images, titles, descriptions, and prices
  List<Map<String, dynamic>> items = [
    {
      'image': 'assets/images/swipe_to_style_images/c1.png',
      'title': 'Stylish Summer Dress',
      'description': 'A light and airy summer dress, perfect for warm days.',
      'price': 59.99,
    },
    {
      'image': 'assets/images/swipe_to_style_images/c2.png',
      'title': 'Comfortable Summer Outfit',
      'description': 'Designed for ultimate comfort during your summer outings.',
      'price': 49.99,
    },
    {
      'image': 'assets/images/swipe_to_style_images/c3.png',
      'title': 'Elegant Evening Wear',
      'description': 'A perfect choice for a night out or formal event.',
      'price': 89.99,
    },
    {
      'image': 'assets/images/swipe_to_style_images/c4.png',
      'title': 'Casual Chic',
      'description': 'A blend of casual and chic for a relaxed day.',
      'price': 44.99,
    },
    {
      'image': 'assets/images/swipe_to_style_images/c5.png',
      'title': 'Unique Occasion Dress',
      'description': 'Stand out at any special event with this unique design.',
      'price': 79.99,
    },
    {
      'image': 'assets/images/swipe_to_style_images/c6.png',
      'title': 'Trendy Summer Look',
      'description': 'A trendy outfit to keep you cool and stylish this summer.',
      'price': 54.99,
    },
    {
      'image': 'assets/images/swipe_to_style_images/c7.png',
      'title': 'Comfort Meets Style',
      'description': 'Combining comfort and style in this must-have summer dress.',
      'price': 64.99,
    },
    {
      'image': 'assets/images/swipe_to_style_images/c8.png',
      'title': 'Event Ready',
      'description': 'An elegant and versatile outfit, ready for any event.',
      'price': 74.99,
    },
    {
      'image': 'assets/images/swipe_to_style_images/c9.png',
      'title': 'Classic with a Twist',
      'description': 'A modern take on a classic design, perfect for any occasion.',
      'price': 69.99,
    },
    {
      'image': 'assets/images/swipe_to_style_images/c10.png',
      'title': 'Elegant and Comfortable',
      'description': 'An elegant outfit that prioritizes comfort without compromise.',
      'price': 79.99,
    },
  ];

  // List to manage cart items
  List<Product> cartItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'SWIPE & STYLE',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
            fontSize: 24,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Center(
                    child: CardSwiper(
                      controller: controller,
                      cardsCount: items.length,
                      onSwipe: _onSwipe,
                      numberOfCardsDisplayed: 2,
                      scale: 0.9,
                      allowedSwipeDirection: AllowedSwipeDirection.only(
                        right: true,
                        left: true,
                        up: true,
                        down: false,
                      ),
                      cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDescriptionPage(
                                  price: items[index]['price'],
                                  imagePath: items[index]['image'],
                                  title: items[index]['title'],
                                  description: items[index]['description'],
                                ),
                              ),
                            );
                          },
                          child: ClothCard(
                            imagePath: items[index]['image'],
                            title: items[index]['title'],
                            description: items[index]['description'],
                            price: items[index]['price'],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundColor: closeIconColor == Colors.red ? Colors.black : Color(0xFFdcdcdc),
                    radius: 30,
                    child: Icon(Icons.close_rounded, color: closeIconColor, size: 40),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: CircleAvatar(
                      backgroundColor: cartIconColor == Colors.red ? Colors.black : cartBackgroundColor,
                      radius: 20,
                      child: Icon(Icons.add_shopping_cart_rounded, color: cartIconColor, size: 20),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: favoriteIconColor == Colors.red ? Colors.black : favoriteBackgroundColor,
                    radius: 30,
                    child: Icon(Icons.favorite_rounded, color: favoriteIconColor, size: 40),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _onSwipe(int previousIndex, int? currentIndex, CardSwiperDirection direction) {
    debugPrint('The card $previousIndex was swiped to the ${direction.name}.');

    // Handle swipe directions
    if (direction == CardSwiperDirection.left) {
      setState(() {
        closeIconColor = Colors.red;
        favoriteIconColor = Colors.black;
        cartIconColor = Colors.black;
      });
    } else if (direction == CardSwiperDirection.right) {
      setState(() {
        favoriteIconColor = Colors.red;
        closeIconColor = Colors.black;
        cartIconColor = Colors.black;
      });
    } else if (direction == CardSwiperDirection.top) {
      setState(() {
        cartIconColor = Colors.red;
        closeIconColor = Colors.black;
        favoriteIconColor = Colors.black;
      });

      // Add the swiped product to the cart
      _addProductToCart(items[previousIndex]);

      // Navigate to the 'My Bag' page and pass the updated cart items
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyBagScreen(cartItems: cartItems),
        ),
      );
    }

    // Reset icon colors when the new card appears
    if (currentIndex != null) {
      Future.delayed(Duration(milliseconds: 300), () {
        setState(() {
          closeIconColor = Colors.black;
          favoriteIconColor = Colors.black;
          cartIconColor = Colors.black;
          favoriteBackgroundColor = Color(0xFFdcdcdc);
          cartBackgroundColor = Color(0xFFdcdcdc);
        });
      });
    }
    return true;
  }

  void _addProductToCart(Map<String, dynamic> productData) {
    int existingIndex = cartItems.indexWhere((item) => item.name == productData['title']);
    if (existingIndex != -1) {
      setState(() {
        cartItems[existingIndex].quantity++;
      });
    } else {
      setState(() {
        cartItems.add(Product(
          name: productData['title'],
          imageUrl: productData['image'],
          price: productData['price'],
          color: 'Assorted',
        ));
      });
    }
  }
}

class ClothCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final double price;

  const ClothCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Color(0xFFf2f3f4),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Rs ${price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
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