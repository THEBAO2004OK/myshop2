import 'package:flutter/material.dart';

import 'product_grid_tile.dart';
import 'products_manager.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid(this.showFavorites, {super.key});

  final bool showFavorites;

  @override
  Widget build(BuildContext context) {
    final productsManager = ProductsManager();
    final products = showFavorites
        ? productsManager.favoriteItems
        : productsManager.items;

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(10, 12, 10, 10),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ProductGridTile(products[i]),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.08,
        crossAxisSpacing: 10,
        mainAxisSpacing: 12,
      ),
    );
  }
}
