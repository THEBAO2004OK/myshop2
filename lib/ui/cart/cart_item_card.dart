import 'package:flutter/material.dart';

import '../../models/cart_item.dart';
import '../shared/dialog_utils.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    required this.productId,
    required this.cartItem,
    required this.onDismissed,
  });

  final String productId;
  final CartItem cartItem;
  final VoidCallback onDismissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(productId),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        color: Colors.red.shade900,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        child: const Icon(Icons.delete, color: Colors.white, size: 30),
      ),
      confirmDismiss: (_) => showConfirmDialog(
        context,
        'Do you want to remove the item from the cart?',
      ),
      onDismissed: (_) => onDismissed(),
      child: ItemInfoCard(cartItem),
    );
  }
}

class ItemInfoCard extends StatelessWidget {
  const ItemInfoCard(this.cartItem, {super.key});

  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                cartItem.imageUrl,
                fit: BoxFit.cover,
                width: 80,
                height: 80,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.image_not_supported_outlined),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(cartItem.title),
                  Text(
                    'Total: \$${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}',
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '${cartItem.quantity} x \$${cartItem.price.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
