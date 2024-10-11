import 'package:coswan/models/order_model.dart';
import 'package:flutter/material.dart';

class DistributorOrderProvider extends ChangeNotifier {
  List<OrderModel> newOrder = [];
  bool dataloading = true;

  void setOrders(List<OrderModel> data) {
    newOrder = data;
    dataloading = false;
    notifyListeners();
  }

  void clearData() {
    newOrder.clear();
    notifyListeners();
  }
}
