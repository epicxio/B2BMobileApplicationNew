import 'package:coswan/models/cart_model.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<CartModel> cart = [];
  int totalcountinprovider = 0;

  void addProduct(CartModel productToCart) {
    cart.add(productToCart);
    notifyListeners();
  }

  void clearData() {
    cart = [];
    notifyListeners();
  }

  // void removeProduct(Map<String, dynamic> removeFromCart) {
  //   cart.remove(removeFromCart);
  //   notifyListeners();
  // }

  void setCart(List<CartModel> cartData) {
    cart = cartData;
    notifyListeners();
  
    
  }

  void removeFromcart(String itemId) {
    // Check if the item with the given ID exists in the list
    bool exists = cart.any((item) => item.id == itemId);
    if (exists) {
      // Find the index of the item with the given ID
      int index = cart.indexWhere((item) => item.id == itemId);
      // If the item is found, remove it from the list
      cart.removeAt(index);
      notifyListeners(); // Notify listeners to update the UI
    }
  }

  List<CartModel> getCart() => cart;
  // void addbadgecount() {
  //   totalcountinprovider += 1;
  //   notifyListeners();
  // }

  // void removebadge() {
  //   totalcountinprovider = 0;
  //   notifyListeners();
  // }
  // Future<void> fetchCartData(BuildContext context) async {
  //   await CartAPI.fetchCartData(context);
  // }
}
