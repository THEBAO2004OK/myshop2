import 'package:flutter/material.dart';

import 'products_grid.dart';

enum FilterOptions { favorites, all }

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _currentFilter = FilterOptions.all;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: <Widget>[
          ProductFilterMenu(
            currentFilter: _currentFilter,
            onFilterSelected: (filter) {
              setState(() {
                _currentFilter = filter;
              });
            },
          ),
          ShoppingCartButton(
            onPressed: () {
              debugPrint('Go to cart screen');
            },
          ),
        ],
      ),
      body: ProductsGrid(_currentFilter == FilterOptions.favorites),
    );
  }
}

class ProductFilterMenu extends StatelessWidget {
  const ProductFilterMenu({
    super.key,
    this.currentFilter,
    this.onFilterSelected,
  });

  final FilterOptions? currentFilter;
  final ValueChanged<FilterOptions>? onFilterSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<FilterOptions>(
      initialValue: currentFilter,
      onSelected: onFilterSelected,
      icon: const Icon(Icons.more_vert),
      itemBuilder: (ctx) => const [
        PopupMenuItem(
          value: FilterOptions.favorites,
          child: Text('Only Favorites'),
        ),
        PopupMenuItem(value: FilterOptions.all, child: Text('Show All')),
      ],
    );
  }
}

class ShoppingCartButton extends StatelessWidget {
  const ShoppingCartButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.shopping_cart),
      onPressed: onPressed,
    );
  }
}
