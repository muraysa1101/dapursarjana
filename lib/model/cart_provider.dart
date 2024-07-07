import 'package:flutter/material.dart';

class CartItem {
  final String name;
  final double price;
  final int quantity;

  CartItem({required this.name, required this.price, required this.quantity});
}

class CartProvider with ChangeNotifier {
  List<CartItem> cartItems = [];

  void addToCart(CartItem item) {
    cartItems.add(item);
    notifyListeners();
  }
}
