import 'dart:convert';

import 'package:coswan/models/notification_model.dart';
import 'package:coswan/providers/userprovider.dart';
import 'package:coswan/utils/route.dart';
import 'package:coswan/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class NotificationAPI {
// notification get api for store owner , purchase manager and distributor
  static Future<List<NotificationModel>> notificationApi(BuildContext context) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false).user;
    // final notification =
    //     Provider.of<NotificationDataProvider>(context, listen: false);

    try {
      final url =
          '${APIRoute.route}/notifications-${userprovider.role == 'Store Owner' ? 'storeowner' : 'purchase'}?receiverUserId=${userprovider.id}&receiverRole=${userprovider.role}';
      final uri = Uri.parse(url);

      final res = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userprovider.token}'
        },
      );
      // print(res.body);
      //print(res.statusCode);
      if (res.statusCode == 200) {
        final result = jsonDecode(res.body);
        final List<NotificationModel> trasformed = List<NotificationModel>.from(
            result.map((e) => NotificationModel.fromMap(e)).toList());
        //notification.setData(trasformed);
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: Text('Notifciation data called')));
        // print(result);
        return trasformed;
      }else{
        return [];
      }
    } catch (e) {
      throw e.toString();
    }
  }

  // accept and decline api
  static Future<Response> productAcceptAndDeclineAPI(
      BuildContext context,
      String cartId,
      String productId,
      String quantity,
      String endPoint,
      String variantSKU,
      String parentSKUchildSKU,
      int index,
      String variant_type,
      String toast) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      final url = '${APIRoute.route}/$endPoint/$cartId';
      final uri = Uri.parse(url);
      print(url);
      final req = <String, dynamic>{
        'role': user.role,
        'productId': productId,
        'userId': user.id,
        'gstnumber': user.gstnumber,
        'variant_quantity': quantity,
        'parentSKU_childSKU': parentSKUchildSKU,
        'variant_SKU': variantSKU,
        'variant_type': variant_type
      };
      print(req);
      final res = await http.put(
        uri,
        body: jsonEncode(req),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${user.token}'
        },
      );
  
      if (res.statusCode == 200 ) {
        CustomNotifyToast.showCustomToast(context, toast);
      }
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
