import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors;

class SummaryRow extends StatelessWidget {
  const SummaryRow({
    required this.label,
    required this.value,
    this.bold = false,
    this.labelColor = Colors.grey,
    this.valueColor,
  });

  final String label;
  final double value;
  final bool bold;
  final Color labelColor;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final baseStyle = TextStyle(
      fontSize: bold ? 16 : 15,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    );
    final sign = value < 0 ? '- ' : '';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: baseStyle.copyWith(color: labelColor)),
        Text(
          '$sign\$ ${value.abs().toStringAsFixed(2)}',
          style: baseStyle.copyWith(color: valueColor ?? labelColor),
        ),
      ],
    );
  }
}