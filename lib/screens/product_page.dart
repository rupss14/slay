import 'package:flutter/material.dart';

class ProductDescriptionPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final double? price;
  final double? rating;
  final int? reviewCount;

  const ProductDescriptionPage({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.price,
    this.rating,
    this.reviewCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(icon: Icon(Icons.favorite_border), onPressed: () {}),
          IconButton(icon: Icon(Icons.shopping_cart_outlined), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(imagePath, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  if (price != null || rating != null)
                    Row(
                      children: [
                        if (price != null)
                          Text(
                            'Rs ${price!.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        Spacer(),
                        if (rating != null) ...[
                          Icon(Icons.star, color: Colors.amber, size: 20),
                          Text(
                            '$rating',
                            style: TextStyle(fontSize: 16),
                          ),
                          if (reviewCount != null)
                            Text(
                              ' ($reviewCount Reviews)',
                              style: TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                        ],
                      ],
                    ),
                  SizedBox(height: 16),
                  Text('Size', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: ['S', 'M', 'L', 'XL', 'XXL'].map((size) =>
                        OutlinedButton(
                          child: Text(size),
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                    ).toList(),
                  ),
                  SizedBox(height: 16),
                  Text('Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text(description, style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'My Profile'),
        ],
      ),
    );
  }
}
