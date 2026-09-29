import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:productsapp/cartItem.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart Screen"),
      ),
      body:Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) {
            return Center(
              child: Text("CART IS EMPTY"),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context,index){
                      final item= cart.items[index];
                      return ListTile(
                        title: Text(item.product.title??"No Product Found"),
                        subtitle: Text("Price:\$${item.product.price}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(onPressed: (){
                              context.read<CartProvider>().decreaseQuantity(item.product);
                            }, icon: Icon(Icons.remove)
                            ),
                            Text("${item.quantity}"),
                            IconButton(onPressed: (){
                               context.read<CartProvider>().increaseQuantity(item.product);
                            }, icon: Icon(Icons.add)),
                            IconButton(onPressed: (){
                              context.read<CartProvider>().removeFromCart(item.product);
                            }, icon: Icon(Icons.delete)),
                          ],
                        ),
                      );
                    }
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "Total: \$${cart.totalPrice.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<CartProvider>().clearCart();
                    },
                    child: Text("Clear Cart"),
                  )
              )
            ],
          );
        },
      ),
    );
  }
}
