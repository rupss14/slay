import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:slay/screens/payment_page.dart';
import 'package:slay/screens/shipment_page.dart';

class MyBagScreen extends StatefulWidget {
  final List<Product> cartItems;

  MyBagScreen({required this.cartItems});

  @override
  _MyBagScreenState createState() => _MyBagScreenState();
}

class _MyBagScreenState extends State<MyBagScreen> {
  // Calculate the total amount
  int getTotalAmount() {
    return widget.cartItems.fold(0, (total, item) => total + (item.price * item.quantity));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            // Added space at the top
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "My Bag",
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // Go back to the previous screen
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      "Back",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            // Spacing below the title
            Expanded(
              child: ListView.builder(
                itemCount: widget.cartItems.length,
                itemBuilder: (context, index) {
                  final item = widget.cartItems[index];
                  return _buildCartItem(item, index);
                },
              ),
            ),
            _buildTotalAmount(),
            SizedBox(height: 80),
            Center(child: _buildCheckoutButton(context)),
            // Centered Checkout button
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(bottom:10.0),
              child: Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Continue shopping",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
                  ),
                ),
              ),
            ),
            // Centered Continue shopping button
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(Product product, int index) {
    return Slidable(
      key: ValueKey(product.name),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.3,
        children: [
          SlidableAction(
            onPressed: (context) {
              setState(() {
                widget.cartItems.removeAt(index); // Delete the product from cart
              });
            },
            backgroundColor: Colors.white,
            foregroundColor: Colors.grey.shade600,
            icon: Icons.delete_rounded,
            label: 'Delete',
            spacing: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
          padding: EdgeInsets.all(16), // Padding inside each product box
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
              ),
            ],
          ),
          child: Row(
            children: [
              Image.asset(
                  product.imageUrl, height: 80, width: 80, fit: BoxFit.cover),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name, style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('Color: ${product.color}',
                        style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 8),
                    Text('Rs ${product.price}', style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade300, // Grey background color
                    ),
                    child: IconButton(
                      icon: Icon(Icons.remove,size: 19),
                      onPressed: () {
                        setState(() {
                          if (product.quantity > 1) {
                            product.quantity--;
                          }
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 8), // Add some spacing between the buttons
                  Text('${product.quantity}'),
                  SizedBox(width: 8), // Add some spacing between the buttons
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade300, // Grey background color
                    ),
                    child: IconButton(
                      icon: Icon(Icons.add,size: 19),
                      onPressed: () {
                        setState(() {
                          product.quantity++;
                        });
                      },
                    ),
                  ),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTotalAmount() {
    return Padding(
      padding: const EdgeInsets.only(top:8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "  Total Amount ",
            style: TextStyle(fontSize: 15,color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          Text(
            "Rs ${getTotalAmount()}  ",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 15,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShipmentPage(totalAmount: getTotalAmount()),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFE5C366),
          padding: EdgeInsets.symmetric(horizontal: 120, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          "Check out",
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
      ),
    );
  }
}

class Product {
  final String name;
  final String imageUrl;
  final int price;
  final String color;
  int quantity;

  Product({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.color,
    this.quantity = 1,
  });
}
