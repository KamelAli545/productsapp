import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productsapp/firebase_options.dart';
import 'package:productsapp/productTab.dart';
import 'package:provider/provider.dart';
import 'package:productsapp/cubit/auth_cubit.dart';
import 'package:productsapp/cubit/products_cubit.dart';
import 'package:productsapp/model/cartItem.dart';
import 'package:productsapp/screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(
          create: (_) => ProductsCubit()..loadProducts(productTabs.first),
        ),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: const Color(0xFF1B2333),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}