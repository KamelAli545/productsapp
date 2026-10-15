import 'package:flutter/material.dart';


class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    this.oldPrice,
    this.discountLabel,
    this.onTap,
  });

  final String imageUrl;
  final String title;
  final String description;
  final double price;
  final double rating;
  final double? oldPrice;
  final String? discountLabel; // e.g. "40%Off"
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: double.infinity,
                color: const Color(0xFFF3F4F6),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Center(
                    child: Icon(Icons.image_not_supported_outlined,
                        color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          Text(
            description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 6),
          Text(
            '\$${price.toStringAsFixed(0)}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          if (oldPrice != null || discountLabel != null)
            Row(
              children: [
                if (oldPrice != null)
                  Text(
                    '\$${oldPrice!.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                if (oldPrice != null && discountLabel != null)
                  const SizedBox(width: 6),
                if (discountLabel != null)
                  Text(
                    discountLabel!,
                    style: const TextStyle(fontSize: 13, color: Color.fromRGBO(250, 113, 137, 1)),
                  ),
              ],
            ),
        ],
      ),
    );
  }

}