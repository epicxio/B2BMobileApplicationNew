import 'package:coswan/models/notification_model.dart';

import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  List<NotificationModel> notificationData = [];
   int notificationCount = 0;
  void setData(List<NotificationModel> data) {
    notificationData = data;
    notifyListeners();
  }

  void clearData() {
    notificationData = [];
    notifyListeners();
  }
  void clearCount () {
    notificationCount = 0;
    notifyListeners();
  }
  void remove(int index) {
    if (index >= 0 && index < notificationData.length) {
      notificationData.removeAt(index);
      notifyListeners();
    } else {
      print('Invalid index');
    }
  }
}
