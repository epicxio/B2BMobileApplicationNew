import 'package:coswan/models/notification_model.dart';

import 'package:flutter/material.dart';

class NotificationDataProvider extends ChangeNotifier {
 List<NotificationModel> notificationDataList = [];
   int notificationCount = 0;
    bool isloading = true;


  // void setData(List<NotificationModel> data) {
  //   notificationDataList = data;
  //    isloading = false;
  //   notifyListeners();
  // }

  // void clearData() {
  //   notificationDataList = [];
  //    isloading = false;
  //   notifyListeners();

  // }
  void clearCount () {
    notificationCount = 0;
    notifyListeners();
  }
  // void remove(int index) {
  //   if (index >= 0 && index < notificationDataList.length) {
  //     notificationDataList.removeAt(index);
    
  //     notifyListeners();
  //   } else {
  //     print('Invalid index');
  //   }
  // }
  //     List<NotificationModel> getnotificationCollection() => notificationDataList;
    

}
