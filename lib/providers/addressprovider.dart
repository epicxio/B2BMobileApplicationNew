import 'package:flutter/material.dart';

class AddressProvider extends ChangeNotifier {
  List<Map<String, dynamic>> address = [];

  void addAddress(Map<String, dynamic> addressval) {
    address.add(addressval);
    notifyListeners();
  }

  void clearData() {
    address = [];
    notifyListeners();
  }
}
