import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productsapp/cubit/auth_cubit.dart';
import 'package:productsapp/model/cartItem.dart';
import 'package:productsapp/screens/cartScreen.dart';

class AppDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserAccountsDrawerHeader(
              decoration:
                BoxDecoration(color: Colors.transparent),
              accountName: Text(
                user?.displayName ?? 'guest',
              style: TextStyle(
                color: Colors.red
              ),
              ),
              accountEmail: Text(user?.email ?? '',
                style: TextStyle(
                    color: Colors.black
                ),
              ),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person,
                    size: 50,
                    color: Color(0xFF4329F9)),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart_outlined),
              title: const Text('Cart'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CartScreen()),
                );
              },
            ),
            const Spacer(),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Log out', style: TextStyle(color: Colors.red)),
              onTap: () async {
                Navigator.pop(context);
                context.read<CartProvider>().clearCart();
                await context.read<AuthCubit>().logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}