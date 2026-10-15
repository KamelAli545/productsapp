import 'package:flutter/material.dart';

const Color kOnboardingAccent = Color(0xFFE23B5B);

class OnboardingPageView extends StatelessWidget {
  const OnboardingPageView({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.currentPage,
    required this.totalPages,
    required this.buttonText,
    required this.onPressed,
    this.onPrev,
    this.onSkip,
  });

  final String image;
  final String title;
  final String description;
  final int currentPage; // zero-based
  final int totalPages;
  final String buttonText;
  final VoidCallback onPressed;
  final VoidCallback? onPrev; // null disables Prev
  final VoidCallback? onSkip;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Top bar: page counter and Skip
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: [
                Text.rich(
                  TextSpan(
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                    children: [
                      TextSpan(
                        text: '${currentPage + 1}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      TextSpan(text: '/$totalPages'),
                    ],
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: onSkip,
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),

          // Illustration, title, description
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    image,
                    height: 260,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const SizedBox(
                      height: 260,
                      child: Icon(Icons.image_outlined,
                          size: 120, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.5,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom bar: Prev, dots, Next / Get Started
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Row(
              children: [
                SizedBox(
                  width: 80,
                  child: TextButton(
                    onPressed: onPrev,
                    style: TextButton.styleFrom(
                      foregroundColor: kOnboardingAccent,
                      disabledForegroundColor: Colors.grey.shade400,
                      padding: EdgeInsets.zero,
                    ),
                    child: const Text('Prev'),
                  ),
                ),
                Expanded(
                  child: _Dots(count: totalPages, active: currentPage),
                ),
                SizedBox(
                  width: 70,
                  child: TextButton(
                    onPressed: onPressed,
                    style: TextButton.styleFrom(
                      foregroundColor: kOnboardingAccent,
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerRight,
                    ),
                    child: Text(buttonText),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.count, required this.active});

  final int count;
  final int active;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final isActive = i == active;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: isActive ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? Colors.black87 : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}