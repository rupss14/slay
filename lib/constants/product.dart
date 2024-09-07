
class Product {
  final String product_name;
  final String image;
  final int retail_price;
  final String color;
  int quantity;

  Product({
    required this.product_name,
    required this.image,
    required this.retail_price,
    required this.color,
    this.quantity = 1,
  });
}
