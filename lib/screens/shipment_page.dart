import 'package:flutter/material.dart';
import 'package:slay/screens/payment_page.dart';
import 'package:slay/screens/my_bag_screen.dart';

class ShipmentPage extends StatefulWidget {
  final int totalAmount;
  ShipmentPage({required this.totalAmount});

  @override
  State<ShipmentPage> createState() => _ShipmentPageState();
}

class _ShipmentPageState extends State<ShipmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Shipping",
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
              SizedBox(height: 90),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      PaymentTextField(
                        labelText: 'Present Address',
                      ),
                      SizedBox(height: 20),
                      PaymentTextField(
                        labelText: 'Landmark',
                      ),
                      SizedBox(height: 20),
                      PaymentTextField(
                        labelText: 'City',
                      ),
                      SizedBox(height: 20),
                      PaymentTextField(
                        labelText: 'Pincode',
                      ),
                      SizedBox(height: 20),
                      PaymentTextField(
                        labelText: 'State',
                      ),
                      SizedBox(height: 20),
                      PaymentTextField(
                        labelText: 'Country',
                      ),
                      SizedBox(height: 20),
                      PaymentTextField(
                        labelText: 'Payment Method?',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.only(bottom: 65.0),
                child: Center(child: _buildCheckoutButton(context)),
              ),
            ],
          ),
        ),
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
          // Navigate to Payment Page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PaymentScreen(totalAmount: widget.totalAmount), // Example total amount
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFE5C366),
          padding: EdgeInsets.symmetric(horizontal: 75, vertical: 12),
          // Adjusted padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          fixedSize: Size(double.infinity, 50),
        ),
        child: Text(
          "Continue to Payment",
          style: TextStyle(fontSize: 15, color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}