import 'package:coswan/models/user_model.dart';
import 'package:flutter/material.dart';

class VendorProvider extends ChangeNotifier {
  List<User> vendorlist = [];

  void setvendor(List<User> vendorData) {
    vendorlist = vendorData;
    notifyListeners();
  }

  void clearData() {
    vendorlist = [];
    notifyListeners();
  }

  void removeFromvendor(String itemId) {
    // Check if the item with the given ID exists in the list
    bool exists = vendorlist.any((item) => item.id == itemId);
    if (exists) {
      // Find the index of the item with the given ID
      int index = vendorlist.indexWhere((item) => item.id == itemId);
      // If the item is found, remove it from the list
      vendorlist.removeAt(index);
      notifyListeners(); // Notify listeners to update the UI
    }
  }
}
