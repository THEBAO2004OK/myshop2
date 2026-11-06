import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/product.dart';

class ProductGridTile extends StatelessWidget {
  const ProductGridTile(this.product, {super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: ProductGridFooter(
          product: product,
          onFavoritePressed: () {
            debugPrint('Toggle a favorite product');
          },
          onAddToCartPressed: () {
            debugPrint('Add item to cart');
          },
        ),
        child: GestureDetector(
          onTap: () {
            context.push('/products/${product.id}');
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const ColoredBox(
              color: Colors.black12,
              child: Center(child: Icon(Icons.image_not_supported_outlined)),
            ),
          ),
        ),
      ),
    );
  }
}

class ProductGridFooter extends StatelessWidget {
  const ProductGridFooter({
    super.key,
    required this.product,
    this.onFavoritePressed,
    this.onAddToCartPressed,
  });

  final Product product;
  final VoidCallback? onFavoritePressed;
  final VoidCallback? onAddToCartPressed;

  @override
  Widget build(BuildContext context) {
    return GridTileBar(
      backgroundColor: const Color(0xdd000000),
      leading: IconButton(
        icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
        color: const Color(0xffff5722),
        onPressed: onFavoritePressed,
      ),
      title: Text(
        product.title,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.shopping_cart),
        color: const Color(0xffff5722),
        onPressed: onAddToCartPressed,
      ),
    );
  }
}
