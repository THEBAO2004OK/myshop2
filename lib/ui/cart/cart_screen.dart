import 'package:flutter/material.dart';

import 'cart_item_card.dart';
import 'cart_manager.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartManager _cart = CartManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: Column(
        children: <Widget>[
          CartSummary(
            cart: _cart,
            onOrderNowPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('An order has been added')),
              );
            },
          ),
          const SizedBox(height: 10),
          Expanded(
            child: CartItemList(_cart, onChanged: () => setState(() {})),
          ),
        ],
      ),
    );
  }
}

class CartItemList extends StatelessWidget {
  const CartItemList(this.cart, {super.key, required this.onChanged});

  final CartManager cart;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: cart.productEntries
          .map(
            (entry) => CartItemCard(
              productId: entry.key,
              cartItem: entry.value,
              onDismissed: () {
                cart.removeItem(entry.key);
                onChanged();
              },
            ),
          )
          .toList(),
    );
  }
}

class CartSummary extends StatelessWidget {
  const CartSummary({
    super.key,
    required this.cart,
    required this.onOrderNowPressed,
  });

  final CartManager cart;
  final VoidCallback onOrderNowPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text('Total', style: TextStyle(fontSize: 20)),
            Chip(
              label: Text('\$${cart.totalAmount.toStringAsFixed(2)}'),
              backgroundColor: Theme.of(context).colorScheme.primary,
              labelStyle: Theme.of(context).textTheme.titleLarge
                  ?.copyWith(color: Colors.white),
            ),
            TextButton(
              onPressed: onOrderNowPressed,
              child: Text(
                'ORDER NOW',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
