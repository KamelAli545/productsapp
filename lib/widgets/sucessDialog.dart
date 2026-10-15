import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SucessDialog extends StatefulWidget {
  const SucessDialog({super.key});

  @override
  State<SucessDialog> createState() => _SucessDialogState();
}

class _SucessDialogState extends State<SucessDialog> {
  void initState() {
    super.initState();
    // يقفل الـ dialog بعد انتهاء الأنيميشن
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) Navigator.of(context).pop();
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/aminations/success.json', // غيّر الاسم لاسم ملفك
              width: 180,
              height: 180,
              repeat: false,
            ),
            const SizedBox(height: 8),
            const Text(
              'Payment done successfully.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
