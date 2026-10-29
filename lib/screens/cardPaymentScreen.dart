import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productsapp/widgets/creditCardView.dart';

const _accent = Color(0xFFE23B5B);

class CardPaymentScreen extends StatefulWidget {
  const CardPaymentScreen({super.key});

  @override
  State<CardPaymentScreen> createState() => _CardPaymentScreenState();
}

class _CardPaymentScreenState extends State<CardPaymentScreen> {
  String _cardNumber = '';
  String _cardName = '';
  String _cardExpiry = '';
  String _cv = '';


  String _formatNumber(String digits) {
    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i > 0 && i % 4 == 0) buffer.write(' ');
      buffer.write(digits[i]);
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Card Details'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          CreditCardView(
            number: _cardNumber,
            name: _cardName,
            expiry: _cardExpiry,
          ),
          const SizedBox(height: 24),
          TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(16),
            ],
            decoration: const InputDecoration(
              labelText: 'Card number',
              border: OutlineInputBorder(),
            ),
            onChanged: (v) => setState(() => _cardNumber = _formatNumber(v)),
          ),
          const SizedBox(height: 12),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Card holder name',
              border: OutlineInputBorder(),
            ),
            onChanged: (v) => setState(() => _cardName = v),
          ),
          const SizedBox(height: 12),
          TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(4),
            ],
            decoration: const InputDecoration(
              labelText: 'Expiry (MM/YY)',
              border: OutlineInputBorder(),
            ),
            onChanged: (v) => setState(() => _cardExpiry = v),
          ),
          SizedBox(height: 12,),
          TextFormField(
            keyboardType: TextInputType.number,
            obscureText: true,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3),
            ],
            decoration: const InputDecoration(
              labelText: 'CVV',
              border: OutlineInputBorder(),
            ),
            onChanged: (v) => setState(() => _cv = v),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: 52,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: _accent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text('Save Card'),
            ),
          ),
        ),
      ),
    );
  }
}