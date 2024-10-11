import 'dart:convert';
import 'package:coswan/models/products_model.dart';
import 'package:coswan/providers/userprovider.dart';
import 'package:coswan/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ShortsApi {
  static Future<List<ProductsModel>> videoApi(BuildContext context) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false).user;
    try {
      const url = '${APIRoute.route}/videos';
      final uri = Uri.parse(url);
      final res = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userprovider.token}'
        },
      );
      final videosdata = jsonDecode(res.body);
      print(res.body);
      final List<ProductsModel> transformed = List<ProductsModel>.from(
          videosdata.map((e) => ProductsModel.fromMap(e)).toList());
      if (res.statusCode == 200) {
        print(' api call sucess');
      }
      return transformed;
    } catch (e) {
      throw e.toString();
    }
  }
}
