import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:productsapp/model/cartItem.dart';
import 'package:productsapp/widgets/sucessDialog.dart';
import 'package:productsapp/widgets/summaryRow.dart';

const _accent = Color(0xFFE23B5B);
const _shippingFee = 30.0;

class PaymentMethod {
  const PaymentMethod(this.name, this.icon);

  final String name;
  final IconData icon;
}

const _methods = [
  PaymentMethod('Cash on Delivery', Icons.payments_outlined),
  PaymentMethod('Visa', Icons.credit_card),
  PaymentMethod('PayPal', Icons.account_balance_wallet_outlined),
];

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({
    super.key,
    required this.total,
    required this.itemCount,
  });

  final double total; // إجمالي بعد الخصم
  final int itemCount;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selected = 0;
  bool _placing = false;

  /// السعر الأصلي قبل الخصم لكل المنتجات
  double _originalTotal(List<CartItem> items) {
    double sum = 0;
    for (final item in items) {
      final price = item.product.price ?? 0;
      final discount = item.product.discountPercentage ?? 0;
      final original = discount > 0 ? price / (1 - discount / 100) : price;
      sum += original * item.quantity;
    }
    return sum;
  }

  Future<void> _placeOrder() async {
    final cart = context.read<CartProvider>();
    setState(() => _placing = true);
    await Future.delayed(const Duration(seconds: 2)); // mock order
    if (!mounted) return;

    cart.clearCart();

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const SucessDialog(),
    );

    if (!mounted) return;
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final afterDiscount = cart.totalPrice;
    final beforeDiscount = _originalTotal(cart.items);
    final discount = beforeDiscount - afterDiscount;
    final grandTotal = afterDiscount + _shippingFee;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Checkout'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SummaryRow(label: 'Price before discount', value: beforeDiscount),
          const SizedBox(height: 10),
          SummaryRow(
            label: 'Discount',
            value: -discount,
            valueColor: Colors.green,
          ),
          const SizedBox(height: 10),
          SummaryRow(label: 'Shipping', value: _shippingFee),
          const Divider(height: 32),
          SummaryRow(
            label: 'Total',
            value: grandTotal,
            bold: true,
            labelColor: Colors.black87,
          ),
          const SizedBox(height: 32),
          const Text(
            'Payment',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          for (var i = 0; i < _methods.length; i++) ...[
            InkWell(
              onTap: () => setState(() => _selected = i),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                decoration: BoxDecoration(
                  color: _selected == i
                      ? const Color.fromRGBO(248, 55, 88, 0.1)
                      : const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _selected == i ? _accent : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(_methods[i].icon, size: 22, color: Colors.black87),
                    const SizedBox(width: 12),
                    Text(
                      _methods[i].name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    Icon(
                      _selected == i
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                      color: _selected == i ? _accent : Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
          ),
          child: SizedBox(
            height: 52,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: _accent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: _placing || cart.items.isEmpty ? null : _placeOrder,
              child: _placing
                  ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.white),
              )
                  : const Text('Place Order', style: TextStyle(fontSize: 16)),
            ),
          ),
        ),
      ),
    );
  }
}