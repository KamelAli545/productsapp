import 'package:flutter/material.dart';
import 'package:productsapp/model/productModel.dart';
import 'package:productsapp/screens/productDetailScreen.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final ProductsModel product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProductDetailScreen(products: product),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 2 / 3,
            child: Hero(
              tag: 'product-poster-${product.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: (product.thumbnail ?? '').isEmpty
                    ? const ColoredBox(
                  color: Colors.black26,
                  child: Center(child: Icon(Icons.image_outlined)),
                )
                    : Image.network(
                  product.thumbnail!,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Center(
            child: Text(
              product.title ?? '',
              style: const TextStyle(color: Colors.black),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Center(
            child: Text(
              '\$${(product.price ?? 0).toStringAsFixed(2)}',
              style: const TextStyle(color: Colors.black),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}