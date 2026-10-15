import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:productsapp/screens/paymentScreen.dart';
import 'package:provider/provider.dart';
import 'package:productsapp/model/cartItem.dart';

const _accent = Color(0xFFE23B5B);

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: cart.items.isEmpty
          ?  Center(
        child: Lottie.asset(
          "assets/aminations/empty.json",
          width: 600,
          height: 600
      ))
            : ListView.builder(
        itemCount: cart.items.length,
        itemBuilder: (context, index) {
          final item = cart.items[index];
          final p = item.product;
          final price = p.price ?? 0;
          final discount = p.discountPercentage ?? 0;
          final oldPrice =
          discount > 0 ? price / (1 - discount / 100) : null;

          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                p.thumbnail ?? '',
                width: 56,
                height: 56,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox(
                  width: 56,
                  height: 56,
                  child: Icon(Icons.image_not_supported_outlined),
                ),
              ),
            ),
            title: Text(p.title ?? 'Product'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '\$${price.toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    if (oldPrice != null) ...[
                      const SizedBox(width: 8),
                      Text(
                        '\$${oldPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),
                if (oldPrice != null)
                  Text(
                    'up to ${discount.round()}% off',
                    style: const TextStyle(fontSize: 12, color: _accent),
                  ),
                if (oldPrice != null)
                  Text(
                    'You save \$${(oldPrice - price).toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 12, color: Colors.green),
                  ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => cart.decreaseQuantity(p),
                ),
                Text('${item.quantity}'),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => cart.increaseQuantity(p),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => cart.removeFromCart(p),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: cart.items.isEmpty
          ? null
          : SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
          ),
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\$ ${cart.totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'View Details',
                    style: TextStyle(fontSize: 12, color: _accent),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: _accent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PaymentScreen(
                          total: cart.totalPrice,
                          itemCount: cart.totalItems,
                        ),
                      ),
                    ),
                    child: const Text('Proceed to Payment'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}