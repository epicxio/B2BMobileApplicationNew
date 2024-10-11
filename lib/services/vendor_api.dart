import 'dart:convert';

import 'package:coswan/models/user_model.dart';
import 'package:coswan/providers/userprovider.dart';
import 'package:coswan/providers/vendor_provider.dart';
import 'package:coswan/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class VendorApi {
//api to delete the vendor
  static Future<void> vendorsAPIDelete(
      BuildContext context, String vendorId) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    final vendordelete = Provider.of<VendorProvider>(context, listen: false);
    try {
      final url = "${APIRoute.route}/vendor-delete/$vendorId";
      print(url);
      final uri = Uri.parse(url);
      print(uri);
      final res = await http.put(uri, headers: {
        'Content-Type': 'Application/json',
        'Accept': 'Application/json',
        'Authorization': 'Bearer ${user.token}'
      });
      print(res.statusCode);
      print(res.body);
      if (res.statusCode == 200) {
        vendordelete.removeFromvendor(vendorId);
      }
    } catch (e) {
      throw e;
    }
  }

  // api to get the vendor
  static Future<void> vendorAPI(BuildContext context) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    final vendor = Provider.of<VendorProvider>(context, listen: false);
    try {
      const url = "${APIRoute.route}/vendors_store_owners";
      final uri = Uri.parse(url);
      final res = await http.get(uri, headers: {
        'Content-Type': 'Application/json',
        'Accept': 'Application/json',
        'Authorization': 'Bearer ${user.token}'
      });
      if (res.statusCode == 200) {
        final result = jsonDecode(res.body);
        final List<User> transformed =
            List<User>.from(result.map((e) => User.fromMap(e)).toList());
        vendor.setvendor(transformed);
      //  print(res.body);
      } else {
        print(res.body);
      }
    } catch (e) {
      print(e);
    }
  }
}
