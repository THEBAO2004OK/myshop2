class CartItem {
  CartItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });

  final String id;
  final String title;
  final String imageUrl;
  final double price;
  int quantity;
}
