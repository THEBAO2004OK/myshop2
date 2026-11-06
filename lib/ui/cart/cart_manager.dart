import '../../models/cart_item.dart';

class CartManager {
  final Map<String, CartItem> _items = {
    'c1': CartItem(
      id: 'c1',
      title: 'Red Shirt',
      imageUrl: 'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
      price: 29.99,
      quantity: 2,
    ),
  };

  int get productCount => _items.length;

  List<CartItem> get products => _items.values.toList();

  Iterable<MapEntry<String, CartItem>> get productEntries => _items.entries;

  double get totalAmount => _items.values.fold(
    0,
    (total, item) => total + item.price * item.quantity,
  );

  void removeItem(String productId) => _items.remove(productId);
}
