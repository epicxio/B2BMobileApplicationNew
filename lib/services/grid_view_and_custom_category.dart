import 'dart:convert';
import 'package:coswan/models/products_model.dart';
import 'package:coswan/providers/userprovider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class QueryParamsApi {
  static Future<List<ProductsModel>> getproduct(
      BuildContext context, String urlString) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false).user;
    final url = urlString;
    try {
      final res = await http.get(
        Uri.parse(
          url,
        ),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userprovider.token}'
        },
      );
      final List<dynamic> productdata = jsonDecode(res.body);

      if (res.statusCode == 200) {
        // print('sucess');
        print(res.body);
      }

      final transformed =
          productdata.map((e) => ProductsModel.fromMap(e)).toList();
      return transformed;
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }
}
