import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:productsapp/screens/authGate.dart';
import 'package:productsapp/screens/firstSplash.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      final isLoggedIn = FirebaseAuth.instance.currentUser != null;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
          isLoggedIn ? const AuthGate() : const FirstSplash(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/aminations/Product.json'),
      ),
    );
  }
}