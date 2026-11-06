import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/order_item.dart';

class OrderItemCard extends StatefulWidget {
  const OrderItemCard(this.order, {super.key});

  final OrderItem order;

  @override
  State<OrderItemCard> createState() => _OrderItemCardState();
}

class _OrderItemCardState extends State<OrderItemCard> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          OrderSummary(
            expanded: _expanded,
            order: widget.order,
            onExpandPressed: () => setState(() => _expanded = !_expanded),
          ),
          if (_expanded) OrderItemList(widget.order),
        ],
      ),
    );
  }
}

class OrderItemList extends StatelessWidget {
  const OrderItemList(this.order, {super.key});

  final OrderItem order;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      constraints: BoxConstraints(maxHeight: order.productCount * 44.0 + 10),
      child: ListView(
        shrinkWrap: true,
        children: order.products
            .map(
              (product) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${product.quantity} x \$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

class OrderSummary extends StatelessWidget {
  const OrderSummary({
    super.key,
    required this.order,
    required this.expanded,
    this.onExpandPressed,
  });

  final bool expanded;
  final OrderItem order;
  final VoidCallback? onExpandPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        '\$${order.amount.toStringAsFixed(2)}',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      subtitle: Text(DateFormat('dd/MM/yyyy HH:mm').format(order.dateTime)),
      trailing: IconButton(
        icon: Icon(expanded ? Icons.expand_less : Icons.expand_more),
        onPressed: onExpandPressed,
      ),
    );
  }
}
