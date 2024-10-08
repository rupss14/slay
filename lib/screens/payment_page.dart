import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  final int totalAmount;

  PaymentScreen({required this.totalAmount});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiryDate = '';
  String cvv = '';
  String cardHolderName = '';
  String upiId = ''; // State for UPI ID

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Ensures keyboard does not overlap content
      body: SafeArea(
        child: SingleChildScrollView( // Wrap the entire content in a SingleChildScrollView
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
                      "Payment",
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
              SizedBox(height: 40),
              _buildPaymentForm(),
              SizedBox(height: 30),
              _buildTotalAmount(),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Center(child: _buildCheckoutButton(context)),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildTotalAmount() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "   Total Amount ",
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Rs ${widget.totalAmount}  ",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // UPI Payment Section at the top
          _buildUPIPaymentSection(),
          SizedBox(height: 20),

          PaymentTextField(
            labelText: 'Card Number',
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a card number';
              } else if (value.length != 16) {
                return 'Card number must be 16 digits';
              }
              return null;
            },
            onSaved: (value) {
              cardNumber = value!;
            },
          ),
          SizedBox(height: 20),
          PaymentTextField(
            labelText: 'Expiry Date (MM/YY)',
            keyboardType: TextInputType.datetime,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an expiry date';
              }
              return null;
            },
            onSaved: (value) {
              expiryDate = value!;
            },
          ),
          SizedBox(height: 20),
          PaymentTextField(
            labelText: 'CVV',
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the CVV';
              } else if (value.length != 3) {
                return 'CVV must be 3 digits';
              }
              return null;
            },
            onSaved: (value) {
              cvv = value!;
            },
          ),
          SizedBox(height: 20),
          PaymentTextField(
            labelText: 'Card Holder Name',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the card holder name';
              }
              return null;
            },
            onSaved: (value) {
              cardHolderName = value!;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildUPIPaymentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "   Pay using UPI",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        PaymentTextField(
          labelText: 'Enter UPI ID',
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a UPI ID';
            }
            return null;
          },
          onSaved: (value) {
            upiId = value!;
          },
        ),
        SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: _processUPIPayment,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFE5C366),
              padding: EdgeInsets.symmetric(horizontal: 120, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              "Pay via UPI",
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
          ),
        ),
      ],
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
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            _processPayment();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFE5C366),
          padding: EdgeInsets.symmetric(horizontal: 120, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          "Confirm",
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
      ),
    );
  }

  void _processPayment() {
    // Implement the payment gateway logic here

    // Example: Mocking a successful payment
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Payment Successful'),
        content: Text('Thank you for your purchase!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Return to previous screen after payment
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _processUPIPayment() {
    // Validate UPI ID
    if (upiId.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Invalid UPI ID'),
          content: Text('Please enter a valid UPI ID'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    // Implement UPI payment logic here
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Payment Successful'),
        content: Text('Thank you for your UPI payment!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Return to previous screen after payment
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}

class PaymentTextField extends StatelessWidget {
  final String labelText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;

  PaymentTextField({
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16.0, right: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(vertical: 3),
        ),
        keyboardType: keyboardType,
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }
}
