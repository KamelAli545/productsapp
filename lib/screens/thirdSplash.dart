import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:productsapp/screens/authGate.dart';
import 'package:productsapp/screens/loginScreen.dart';
import 'package:productsapp/widgets/onBoardingScreen.dart';

class ThirdSplash extends StatelessWidget {
  const ThirdSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: OnboardingPageView(
        image: "assets/images/Shopping bag-rafiki 1.png",
        title: "Get Your Order",
        description:     'Track your order in real time and receive it at your door.',
        currentPage: 2,
        totalPages: 3,
        buttonText: "Get Started",
        onPressed: ()=>goToAuthGate(context),
          onPrev: ()=>Navigator.pop(context),
      onSkip: ()=>goToAuthGate(context),
      ),
    );
  }
}
