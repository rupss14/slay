import 'package:flutter/material.dart';

class ProductDescriptionPage extends StatelessWidget {
 // final String id;
  final String image;
  final String product_name;
  final String description;
  final double retail_price;
  final double? discount_price;
  final String brand;
  final String tertiary;

  const ProductDescriptionPage({
    Key? key,
   // required this.id,
    required this.image,
    required this.product_name,
    required this.description,
    required this.retail_price,
    this.discount_price,
    required this.brand,
    required this.tertiary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Product Description',style: TextStyle(
          fontWeight: FontWeight.w600,
        ),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(icon: Icon(Icons.favorite_border), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  image,
                  height: 350,
                  //fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 20),
              Text(
                product_name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                brand,
                style: TextStyle(fontSize: 20, color: Colors.grey[600]),
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start, // Align items to the start vertically
                children: [
                  Icon(Icons.category_outlined, size: 18, color: Colors.black,), // Icon on the left
                  SizedBox(width: 5), // Spacing between the icon and text
                  Text(
                    'Category:',
                    style: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold), // "Category:" in black
                  ),
                  SizedBox(width: 5), // Optional spacing between texts
                  Text(
                    ' "$tertiary"',
                    style: TextStyle(fontSize: 16, color:Colors.black,), // `tertiary` in original color
                  ),
                ],
              ),

              SizedBox(height: 10),
              Text(
                description,
                style: TextStyle(fontSize: 18, color: Colors.grey[800]),
              ),
              SizedBox(height: 20),
              Text(
                'Size',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ['XS', 'S', 'M', 'L','XL','XXL'].map((size) =>
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFFfafad2),
                        border: Border.all(color: Color(0xFFE5C366),),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(child: Text('$size')),
                    )
                ).toList(),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(bottom:16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rs ${retail_price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            decoration: discount_price != null ? TextDecoration.lineThrough : TextDecoration.none,
                            color: discount_price != null ? Colors.grey : Colors.black,
                          ),
                        ),
                        if (discount_price != null)
                          Text(
                            '\$${discount_price?.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Add to Cart'),
                      style: ElevatedButton.styleFrom(
                        shape:RoundedRectangleBorder(  // Custom shape
                          borderRadius: BorderRadius.circular(10),  // Rounded corners
                    ),
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Example of how to use this widget with data from an API call
class ProductPage extends StatefulWidget {
  final String productId;

  ProductPage({required this.productId});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Future<Map<String, dynamic>> _productFuture;

  @override
  void initState() {
    super.initState();
    _productFuture = fetchProductData(widget.productId);
  }

  Future<Map<String, dynamic>> fetchProductData(String id) async {
    // Simulated API call
    await Future.delayed(Duration(seconds: 2));
    return {
      'id': id,
      'image': 'https://example.com/product_image.jpg',
      'product_name': 'Sample Product',
      'description': 'This is a sample product description.',
      'retail_price': 99.99,
      'discount_price': 79.99,
      'brand': 'Sample Brand',
      'tertiary': 'Casual Wear',
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _productFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final productData = snapshot.data!;
          return ProductDescriptionPage(
            //id: productData['id'],
            image: productData['image'],
            product_name: productData['product_name'],
            description: productData['description'],
            retail_price: productData['retail_price'],
            discount_price: productData['discount_price'],
            brand: productData['brand'],
            tertiary: productData['tertiary'],
          );
        } else {
          return Center(child: Text('No data available'));
        }
      },
    );
  }
}