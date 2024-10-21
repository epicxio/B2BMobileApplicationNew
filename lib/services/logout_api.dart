import 'dart:convert';

import 'package:coswan/providers/addressprovider.dart';
import 'package:coswan/providers/cartprovider.dart';
import 'package:coswan/providers/notificatiion_provider.dart';
import 'package:coswan/providers/userprovider.dart';
import 'package:coswan/providers/vendor_provider.dart';
import 'package:coswan/providers/whislist_provider.dart';
import 'package:coswan/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class LogoutAPI {
  static Future<void> logOutAPi(BuildContext context) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    final address = Provider.of<AddressProvider>(context, listen: false);
    
    final distrbutor = Provider.of<WhislistProvider>(context, listen: false);
    final notification = Provider.of<NotificationDataProvider>(context, listen: false);
    final cart = Provider.of<CartProvider>(context, listen: false);
    final wishlist = Provider.of<WhislistProvider>(context, listen: false);
    final vendor = Provider.of<VendorProvider>(context, listen: false);
    try {
      final tokendata = <String, dynamic>{
        'token': userprovider.user.token,
      };
      const url = '${APIRoute.route}/logout';
      final uri = Uri.parse(url);
      final res = await http.post(
        uri,
        body: jsonEncode(tokendata),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization': 'Bearer ${userprovider.token}'
        },
      );
      // userprovider.user.role == 'Distributor'
      //     ? null
      //     : FcmUpdateAPI.fcmUpdateAPI(context, 'logout');
      userprovider.clearUserData();
      address.clearData();
      cart.clearData();
      wishlist.clearData();
      distrbutor.clearData();
    //  notification.clearData();
      vendor.clearData();
      print(res.body);
      print("jpwdfsdfkljsdfklj:${res.statusCode}");
    } catch (e) {
      print(e);
    }
  }
}
