import 'package:flutter/material.dart';

import 'products_manager.dart';
import 'user_product_list_tile.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          AddUserProductButton(
            onPressed: () {
              debugPrint('Go to edit product screen');
            },
          ),
        ],
      ),
      body: const UserProductList(),
    );
  }
}

class UserProductList extends StatelessWidget {
  const UserProductList({super.key});

  @override
  Widget build(BuildContext context) {
    final productsManager = ProductsManager();
    final products = productsManager.items;

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            UserProductListTile(products[index]),
            const Divider(),
          ],
        );
      },
    );
  }
}

class AddUserProductButton extends StatelessWidget {
  const AddUserProductButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(icon: const Icon(Icons.add), onPressed: onPressed);
  }
}
