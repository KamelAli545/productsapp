import 'package:flutter/material.dart';
import 'package:productsapp/cartItem.dart';
import 'package:productsapp/homeScreen.dart';
import 'package:productsapp/products_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) =>
          ProductsCubit()
            ..loadProducts(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider()
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
