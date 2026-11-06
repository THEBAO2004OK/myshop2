import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/product.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen(this.product, {super.key});
  final Product product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String _color = 'Đỏ';
  String _size = 'S';
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết sản phẩm'),
        leading: const BackButton(),
        actions: [
          IconButton(
            tooltip: 'Trang chủ',
            icon: const Icon(Icons.home_outlined),
            onPressed: () => context.go('/products'),
          ),
          IconButton(
            tooltip: 'Giỏ hàng',
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () => context.go('/cart'),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(22, 8, 22, 14),
        child: SizedBox(
          height: 60,
          child: ElevatedButton.icon(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Đã thêm sản phẩm vào giỏ hàng.')),
            ),
            icon: const Icon(Icons.shopping_cart_outlined),
            label: const Text(
              'Thêm vào giỏ hàng',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff85558a),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 375,
                  width: double.infinity,
                  child: Image.network(product.imageUrl, fit: BoxFit.contain),
                ),
                Positioned(
                  top: 18,
                  right: 18,
                  child: Material(
                    color: Colors.white,
                    elevation: 3,
                    shape: const CircleBorder(),
                    child: IconButton(
                      icon: Icon(
                        product.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                      color: const Color(0xffff5722),
                      iconSize: 28,
                      onPressed: () => setState(
                        () => product.isFavorite = !product.isFavorite,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 20, 22, 0),
              child: Text(
                product.title,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 12, 22, 0),
              child: Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Color(0xff85558a),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 24, 22, 20),
              child: Text(
                product.description,
                style: const TextStyle(color: Colors.black54, fontSize: 18),
              ),
            ),
            const Divider(indent: 22, endIndent: 22, height: 1),
            _Options(
              title: 'Màu sắc',
              values: const ['Đỏ', 'Đen', 'Trắng'],
              selected: _color,
              onChanged: (v) => setState(() => _color = v),
            ),
            _Options(
              title: 'Kích thước',
              values: const ['S', 'M', 'L', 'XL'],
              selected: _size,
              onChanged: (v) => setState(() => _size = v),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(22, 22, 22, 9),
              child: Text(
                'Số lượng',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 22),
              child: Container(
                width: 186,
                height: 58,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: _quantity > 1
                          ? () => setState(() => _quantity--)
                          : null,
                      icon: const Icon(Icons.remove),
                      color: const Color(0xff85558a),
                    ),
                    Text(
                      '$_quantity',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: _quantity < 99
                          ? () => setState(() => _quantity++)
                          : null,
                      icon: const Icon(Icons.add),
                      color: const Color(0xff85558a),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(22, 10, 22, 12),
              child: Text(
                'Chọn từ 1 đến 99 sản phẩm.',
                style: TextStyle(color: Colors.black38),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Options extends StatelessWidget {
  const _Options({
    required this.title,
    required this.values,
    required this.selected,
    required this.onChanged,
  });
  final String title;
  final List<String> values;
  final String selected;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(22, 27, 22, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          children: values
              .map(
                (value) => ChoiceChip(
                  label: Text(value),
                  selected: selected == value,
                  onSelected: (_) => onChanged(value),
                  selectedColor: const Color(0xffffcafa),
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xffd8c8d8)),
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                ),
              )
              .toList(),
        ),
      ],
    ),
  );
}
