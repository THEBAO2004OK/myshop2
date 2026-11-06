import '../../models/cart_item.dart';
import '../../models/order_item.dart';

class OrderManager {
  final List<OrderItem> _orders = [
    OrderItem(
      id: 'o1',
      amount: 59.98,
      products: [
        CartItem(
          id: 'c1',
          title: 'Red Shirt',
          imageUrl: 'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
          price: 29.99,
          quantity: 2,
        ),
      ],
      dateTime: DateTime(2022, 6, 24, 10, 33),
    ),
  ];

  int get orderCount => _orders.length;

  List<OrderItem> get orders => [..._orders];
}
