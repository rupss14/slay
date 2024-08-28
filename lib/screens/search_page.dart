import 'package:flutter/material.dart';

class SearchResultsPage extends StatelessWidget {
  final String searchQuery;

  SearchResultsPage({required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ProductGrid(searchQuery: searchQuery),
    );
  }
}

class ProductGrid extends StatelessWidget {
  final String searchQuery;

  ProductGrid({required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> products = [
      {'name': 'Dress', 'price': 999, 'image': 'assets/images/swipe_to_style_images/c1.png', 'isFavorite': true},
      {'name': 'Dress', 'price': 899, 'image': 'assets/images/swipe_to_style_images/c2.png', 'isFavorite': false},
      {'name': 'Jwellery', 'price': 2999, 'image': 'assets/images/swipe_to_style_images/c3.png', 'isFavorite': true},
      {'name': 'Dress', 'price': 599, 'image': 'assets/images/swipe_to_style_images/c4.png', 'isFavorite': false},
      {'name': 'Jeans', 'price': 799, 'image': 'assets/images/swipe_to_style_images/c5.png', 'isFavorite': false},
      {'name': 'Shoes', 'price': 4999, 'image': 'assets/images/swipe_to_style_images/c6.png', 'isFavorite': true},
      {'name': 'Jwellery', 'price': 499, 'image': 'assets/images/swipe_to_style_images/c7.png', 'isFavorite': false},
      {'name': 'Rings', 'price': 299, 'image': 'assets/images/swipe_to_style_images/c8.png', 'isFavorite': true},
      {'name': 'Shoes', 'price': 6999, 'image': 'assets/images/swipe_to_style_images/c9.png', 'isFavorite': true},
      {'name': 'Dress', 'price': 899, 'image': 'assets/images/swipe_to_style_images/c10.png', 'isFavorite': true},
    ];

    return SafeArea(
      child: products.isEmpty
          ? Center(child: Text('No products found'))
          : GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.68, // Adjusted from 0.7 to 0.68
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(product: products[index]);
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.asset(
                  product['image'],
                  height: 110, // Reduced from 120 to 110
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 110,
                      color: Colors.grey[300],
                      child: Center(child: Text('Image not found')),
                    );
                  },
                ),
              ),
              Positioned(
                top: 5, // Reduced from 10 to 5
                right: 5, // Reduced from 10 to 5
                child: Icon(
                  product['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                  color: product['isFavorite'] ? Colors.red : Colors.grey,
                  size: 20, // Reduced size from default
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(6), // Reduced from 8 to 6
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['name'],
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), // Reduced font size
                      ),
                      SizedBox(height: 2), // Reduced from 4 to 2
                      Text(
                        'Rs ${product['price'].toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]), // Reduced font size
                      ),
                      SizedBox(height: 2), // Reduced from 4 to 2
                      Row(
                        children: List.generate(
                          5,
                              (index) => Icon(Icons.star, size: 14, color: Colors.yellow[700]), // Reduced size
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 12, // Reduced from 15 to 12
                      child: Icon(Icons.add, color: Colors.white, size: 16), // Reduced size
                    ),
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