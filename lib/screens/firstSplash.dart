import 'package:flutter/material.dart';
import 'package:productsapp/screens/authGate.dart';
import 'package:productsapp/screens/secondSplash.dart';
import 'package:productsapp/widgets/onBoardingScreen.dart';

class FirstSplash extends StatelessWidget {
  const FirstSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: OnboardingPageView(
        image: 'assets/images/fashion shop-rafiki 1.png',
        title: 'Choose Products',
        description:
        'Browse our collection and add your favorite items to the cart.',
        currentPage: 0,
        totalPages: 3,
        buttonText: 'Next',
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SecondSplash()),
        ),
        onPrev: null,
        onSkip: () => goToAuthGate(context),
      ),
    );
  }
}