import 'package:flutter/material.dart';

class CreditCardView extends StatelessWidget {
  const CreditCardView({
    super.key,
    required this.number,
    required this.name,
    required this.expiry,
  });

  final String number;
  final String name;
  final String expiry;

  @override
  Widget build(BuildContext context) {
    final display = number.isEmpty ? '•••• •••• •••• ••••' : number;

    return AspectRatio(
      aspectRatio: 1.586,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Color(0xFF1B2333), Color(0xFFE23B5B)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.topRight,
              child: Text(
                'VISA',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const Spacer(),
            Text(
              display,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name.isEmpty ? 'CARD HOLDER' : name.toUpperCase(),
                  style: const TextStyle(color: Colors.white70),
                ),
                Text(
                  expiry.isEmpty ? 'MM/YY' : expiry,
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
