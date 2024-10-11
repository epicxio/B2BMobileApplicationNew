import 'dart:convert';

import 'package:coswan/models/products_model.dart';
import 'package:coswan/providers/userprovider.dart';
import 'package:coswan/providers/whislist_provider.dart';
import 'package:coswan/utils/route.dart';
import 'package:coswan/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class WhishlistApi {
  // to remove the  item from the whilist
  static Future<void> removewishlistItem(
      BuildContext context, String itemId) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false).user;
    final whislist = Provider.of<WhislistProvider>(context, listen: false);
    try {
    

      whislist.removeFromWishlist(itemId);
      final url = '${APIRoute.route}/Removewishlist/${userprovider.id}/$itemId';
      final uri = Uri.parse(url);
      final res = await http.put(
        uri,
        //    body: jsonEncode(removalData),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userprovider.token}'
        },
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        CustomNotifyToast.showCustomToast(context, 'Item Removed Sucessfully');
      }
    } catch (e) {
      print(e);
    }
  }

  // to add the whislist
  static Future<void> whislistAPI(BuildContext context, String itemId) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false).user;
    final wishlistprovider =
        Provider.of<WhislistProvider>(context, listen: false);
    try {
      // final removalData = <String, dynamic>{
      //   'productId': itemId,
      //   'userId': userprovider.id
      // };
      final url = '${APIRoute.route}/wishlist/${userprovider.id}/$itemId';
      final uri = Uri.parse(url);
      final res = await http.post(
        uri,
        //   body: jsonEncode(removalData),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userprovider.token}'
        },
      );
      print(res.statusCode);
      print(res.body);
      if (res.statusCode == 200) {
        // wishlistprovider.addfavorite(

        // );
        fetchWhishlistData(context);

        final result = jsonDecode(res.body);
        wishlistprovider.addfavorite(result);
      }
    } catch (e) {
      print(e);
    }
  }

  // to get the items from the whishlist
  static void fetchWhishlistData(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    final wishlistProvider =
        Provider.of<WhislistProvider>(context, listen: false);
    print(userProvider.email);
    print(userProvider.id);
    try {
      final url = '${APIRoute.route}/favorites/${userProvider.id}';
      print(url);
      final uri = Uri.parse(url);
      final res = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userProvider.token}'
        },
      );
      print(res.body);
      if (res.statusCode == 200) {
        final Map<String, dynamic> result = jsonDecode(res.body);
        final List<Map<String, dynamic>> pro =
            List<Map<String, dynamic>>.from(result['products']);
        print(pro);

        final transformed = pro.map((e) => ProductsModel.fromMap(e)).toList();
        print(transformed);
        // print('dfklsdflktransfor,');
        // final List<ProductsModel> products = result
        //     .expand((wishlistEntry) => wishlistEntry['products'])
        //     .map((product) => ProductsModel.fromMap(product))
        //     .toList();
        wishlistProvider.setwhislist(transformed);
      } else {
        print(res.body);
      }
    } catch (e) {
      print(e);
    }
  }
}
