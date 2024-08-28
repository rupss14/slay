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
      'price': 500
    },
    {
      'image': 'assets/images/swipe_to_style_images/c2.png',
      'title': 'Comfortable Summer Outfit',
      'description': 'Designed for ultimate comfort during your summer outings.',
      'price': 300
    },
    {
      'image': 'assets/images/swipe_to_style_images/c3.png',
      'title': 'Elegant Evening Wear',
      'description': 'A perfect choice for a night out or formal event.',
      'price': 1200
    },
    // Add more items as needed
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
                                  imagePath: items[index]['image']!,
                                  title: items[index]['title']!,
                                  description: items[index]['description']!,
                                ),
                              ),
                            );
                          },
                          child: ClothCard(
                            imagePath: items[index]['image']!,
                            title: items[index]['title']!,
                            description: items[index]['description']!,
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
          name: productData['title']!,
          imageUrl: productData['image']!,
          price: productData['price']!,
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

  const ClothCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.description,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
