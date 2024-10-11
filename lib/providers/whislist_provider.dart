import 'package:coswan/models/products_model.dart';
import 'package:flutter/material.dart';

class WhislistProvider extends ChangeNotifier {
  List<ProductsModel> listOfwhislist = [];

  void setwhislist(List<ProductsModel> favouriteData) {
    listOfwhislist = favouriteData;
    notifyListeners();
  }

  void clearData() {
    listOfwhislist = [];
    notifyListeners();
  }

  void addfavorite(ProductsModel productToCart) {
    listOfwhislist.insert(0, productToCart);
  
    notifyListeners();
  }

  // void removeFromWishlist(String itemId) {
  //   // Check if the item with the given ID exists in the list
  //   bool exists = listOfwhislist.any((item) => item.productId == itemId);
  //   if (exists) {
  //     // Find the index of the item with the given ID
  //     int index = listOfwhislist.indexWhere((item) => item.productId == itemId);
  //     // If the item is found, remove it from the list
  //     listOfwhislist.removeAt(index);

  //     notifyListeners(); // Notify listeners to update the UI
  //   }
  // }
  //   void removeFromWishlist(String itemId) {
  //   int index = listOfwhislist.indexWhere((item) => item.products[].productId == itemId);
  //   if (index != -1) {
  //     listOfwhislist.removeAt(index);
  //     notifyListeners(); // Notify listeners to update the UI
  //   }
  // }
  // void removeFromWishlist(String itemId) {
  //   for (int i = 0; i < listOfwhislist.length; i++) {
  //     WhislistModel wishlist = listOfwhislist[i];
  //     int productIndex =
  //         wishlist.products.indexWhere((product) => product.id == itemId);

  //     if (productIndex != -1) {
  //       wishlist.products.removeAt(productIndex);
  //       notifyListeners(); // Notify listeners to update the UI
  //       break; // Exit the loop once the product is found and removed
  //     }
  //   }
  // }
  void removeFromWishlist(String itemId) {
    int index = listOfwhislist.indexWhere((product) => product.id == itemId);
    if (index != -1) {
      listOfwhislist.removeAt(index);
      notifyListeners(); // Notify listeners to update the UI
    }
  }
}
