import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:slay/screens/my_bag_screen.dart';
import 'package:slay/screens/product_page.dart';
import 'package:slay/constants/product.dart';

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
  'product_name': 'Stylish Summer Dress',
  'description': 'A light and airy summer dress, perfect for warm days.',
  'retail_price': 59.99,
  'brand':'Puma',
  'tertiary':'Casual Wear'
},
{
'image': 'assets/images/swipe_to_style_images/c2.png',
'product_name': 'Comfortable Summer Outfit',
'description': 'Designed for ultimate comfort during your summer outings.',
'retail_price': 49.99,
'brand':'Puma',
'tertiary':'Casual Wear'
},
{
'image': 'assets/images/swipe_to_style_images/c3.png',
'product_name': 'Elegant Evening Wear',
'description': 'A perfect choice for a night out or formal event.',
'retail_price': 89.99,
'brand':'Puma',
'tertiary':'Casual Wear'
},
{
'image': 'assets/images/swipe_to_style_images/c4.png',
'product_name': 'Casual Chic',
'description': 'A blend of casual and chic for a relaxed day.',
'retail_price': 44.99,
'brand':'Puma',
'tertiary':'Casual Wear'
},
{
'image': 'assets/images/swipe_to_style_images/c5.png',
'product_name': 'Unique Occasion Dress',
'description': 'Stand out at any special event with this unique design.',
'retail_price': 79.99,
'brand':'Puma',
'tertiary':'Casual Wear'
},
{
'image': 'assets/images/swipe_to_style_images/c6.png',
'product_name': 'Trendy Summer Look',
'description': 'A trendy outfit to keep you cool and stylish this summer.',
'retail_price': 54.99,
'brand':'Puma',
'tertiary':'Casual Wear'
},
{
'image': 'assets/images/swipe_to_style_images/c7.png',
'product_name': 'Comfort Meets Style',
'description': 'Combining comfort and style in this must-have summer dress.',
'retail_price': 64.99,
'brand':'Puma',
'tertiary':'Casual Wear'
},
{
'image': 'assets/images/swipe_to_style_images/c8.png',
'product_name': 'Event Ready',
'description': 'An elegant and versatile outfit, ready for any event.',
'retail_price': 74.99,
'brand':'Puma',
'tertiary':'Casual Wear'
},
{
'image': 'assets/images/swipe_to_style_images/c9.png',
'product_name': 'Classic with a Twist',
'description': 'A modern take on a classic design, perfect for any occasion.',
'retail_price': 69.99,
'brand':'Puma',
'tertiary':'Casual Wear'
},
{
'image': 'assets/images/swipe_to_style_images/c10.png',
'product_name': 'Elegant and Comfortable',
'description': 'An elegant outfit that prioritizes comfort without compromise.',
'retail_price': 79.99,
'brand':'Puma',
'tertiary':'Casual Wear'

    },
    // Add more items here...
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
                                  retail_price: items[index]['retail_price'] as double,
                                  image: items[index]['image'] as String,
                                  product_name: items[index]['product_name'] as String,
                                  description: items[index]['description'] as String,
                                  brand: items[index]['brand'] as String,
                                  tertiary: items[index]['tertiary'] as String,
                                ),
                              ),
                            );
                          },
                          child: ClothCard(
                            image: items[index]['image'] as String,
                            product_name: items[index]['product_name'] as String,
                            description: items[index]['description'] as String,
                            retail_price: items[index]['retail_price'] as double,
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
      debugPrint("Swiped up to add to cart");

      setState(() {
        cartIconColor = Colors.red;
        closeIconColor = Colors.black;
        favoriteIconColor = Colors.black;
      });

      // Add the swiped product to the cart
      _addProductToCart(items[previousIndex]);

      // Schedule navigation after the current frame completes
      WidgetsBinding.instance.addPostFrameCallback((_) {
        debugPrint("Navigating to MyBagScreen");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyBagScreen(cartItems: cartItems),
          ),
        );
      });
    }

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
    int existingIndex = cartItems.indexWhere((item) => item.product_name == productData['product_name']);
    if (existingIndex != -1) {
      setState(() {
        cartItems[existingIndex].quantity++;
      });
    } else {
      setState(() {
        cartItems.add(Product(
          product_name: productData['product_name'],
          image: productData['image'],
          retail_price: productData['retail_price'],
          color: 'Assorted',
          quantity: 1,
        ));
      });
    }
    debugPrint('Cart items: $cartItems');
  }
}

class ClothCard extends StatelessWidget {
  final String image;
  final String product_name;
  final String description;
  final double? retail_price;

  const ClothCard({
    Key? key,
    required this.image,
    required this.product_name,
    required this.description,
    required this.retail_price,
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
                image,
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
                    product_name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 8),
                  Text(
                    retail_price != null ? 'Rs ${retail_price!.toStringAsFixed(2)}' : 'Price not available',
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
