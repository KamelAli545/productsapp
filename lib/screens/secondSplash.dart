import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:productsapp/screens/authGate.dart';
import 'package:productsapp/screens/thirdSplash.dart';
import 'package:productsapp/widgets/onBoardingScreen.dart';

class SecondSplash extends StatelessWidget {
  const SecondSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: OnboardingPageView(
        image: "assets/images/Sales consulting-pana 1.png",
        title: "Make Payment",
        description:
        'Pay securely with a few taps and confirm your order right away.',
        currentPage: 1,
        totalPages: 3,
        buttonText: "Next",
        onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>ThirdSplash())),
        onPrev: ()=>Navigator.pop(context),
        onSkip: ()=>goToAuthGate(context),
      ),
    );
  }
}
