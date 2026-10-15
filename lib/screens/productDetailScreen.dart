import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:productsapp/model/cartItem.dart';
import 'package:productsapp/model/productModel.dart';
import 'package:productsapp/screens/cartScreen.dart';


class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.products});

  final ProductsModel products;

  @override
  Widget build(BuildContext context) {
    final p = products;
    final price = p.price ?? 0;
    final discount = p.discountPercentage ?? 0;
    final oldPrice = discount > 0 ? price / (1 - discount / 100) : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(p.title ?? 'Product'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartScreen()),
              );
            },
            icon: Badge(
              isLabelVisible: context.watch<CartProvider>().totalItems > 0,
              label: Text('${context.watch<CartProvider>().totalItems}'),
              child: const Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_shopping_cart),
        label:  Text('Add to Cart',

        ),
        onPressed: () {
          context.read<CartProvider>().addToCart(p);
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: double.infinity,
                height: 300,
                color: const Color(0xFFF3F4F6),
                child: Image.network(
                  p.thumbnail ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Center(
                    child: Icon(Icons.image_not_supported_outlined,
                        size: 48, color: Colors.grey),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            Text(
              p.title ?? 'No title',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Text(
              p.description ?? '',
              style: const TextStyle(fontSize: 13, height: 1.5, color: Colors.grey),
            ),
            const SizedBox(height: 12),

            Text(
              '\$${price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            if (oldPrice != null)
              Row(
                children: [
                  Text(
                    '\$${oldPrice.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${discount.round()}%Off',
                    style: const TextStyle(
                        fontSize: 13,
                        color: Color.fromRGBO(250, 113, 137, 1)),
                  ),
                ],
              ),
            const SizedBox(height: 8),

            Row(
              children: [
                const Icon(Icons.star, size: 16, color: Colors.amber),
                const SizedBox(width: 4),
                Text(
                  (p.rating ?? 0).toStringAsFixed(1),
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}