import 'package:flutter/cupertino.dart';
import 'package:productsapp/productModel.dart';

class CartItem {
   final ProductsModel product;
   int quantity;

   CartItem({required this.product, this.quantity=1});

}
class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice => _items.fold(
      0.0, (sum, item) => sum + (item.product.price ?? 0) * item.quantity);

  void addToCart(ProductsModel product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(product: product));
    }
    notifyListeners();
  }

  void removeFromCart(ProductsModel product) {
    _items.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }

  void increaseQuantity(ProductsModel product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index == -1) return;
    _items[index].quantity++;
    notifyListeners();
  }

  void decreaseQuantity(ProductsModel product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index == -1) return;
    _items[index].quantity--;
    if (_items[index].quantity <= 0) {
      _items.removeAt(index);
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}