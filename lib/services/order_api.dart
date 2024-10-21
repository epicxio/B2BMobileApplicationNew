import 'dart:convert';
import 'package:coswan/models/order_model.dart';
import 'package:coswan/providers/cartprovider.dart';
import 'package:coswan/screens/paymentsuccessful.dart';
import 'package:coswan/providers/userprovider.dart';
import 'package:coswan/services/cart_api.dart';
import 'package:coswan/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class OrderApi {
  // to order the product
  static Future<void> orderAPI(BuildContext context, String payment,
      List cartIds, String addressID) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    final cart = Provider.of<CartProvider>(context, listen: false);
    final navigator = Navigator.of(context);

    try {
      const url = '${APIRoute.route}/order-placed';
      final uri = Uri.parse(url);
      final req = <String, dynamic>{
        'userId': user.id,
        'cartIds': cartIds,
        'gstnumber': user.gstnumber,
        'paymentMethod': payment,
        'currentAddressId': addressID,
      };

      print(req);
      final res = await http.post(
        uri,
        body: jsonEncode(req),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${user.token}'
        },
      );
      print(res.statusCode);
      print(res.body);
      print('order da');
      print(res.statusCode);
      final List<Map<String, dynamic>> data =
          List<Map<String, dynamic>>.from(jsonDecode(res.body));

      final List<String> orderId = [];
      final List<String> transactionId = [];
      for (int i = 0; i < data.length; i++) {
        orderId.add(data[i]['_id']);
        transactionId.add(data[i]['transactionId']);
      }

      // print('order da');
      // print(data[0]["_id"].toString());

      print(res.body);
      if (res.statusCode == 200) {
        print(orderId);
        print(transactionId);
        cart.clearData();
        //  Provider.of<NotificationDataProvider>(context, listen: false).clearData();
     Provider.of<CartProvider>(context, listen: false).clearData();
        navigator.pushReplacement(MaterialPageRoute(
            builder: (context) => PaymentSucessful(
                  orderid: orderId,
                  transactionId: transactionId,
                )));
      }

      CartAPI.fetchCartData(context);
    } catch (e) {
      throw e.toString();
    }
  }

  // order history api for S.O and P.M
  static Future<List<OrderModel>> orderHistoryAPI(BuildContext context) async {
    final userAuth = Provider.of<UserProvider>(context, listen: false).user;
    final url = '${APIRoute.route}/orders-history/${userAuth.id}';
    print(url);
    final List<dynamic> result;
    try {
      final res = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userAuth.token}'
        },
      );

      print(res.body);
      if (res.statusCode == 200) {
        result = jsonDecode(res.body);
        print('ddatatatatataat');
        print(result);
        final transformed = result.map((e) => OrderModel.fromMap(e)).toList();

        // showCustomToast(endval);
        return transformed;
      } else {
        print('Failed to send data: ${res.statusCode}');
        return [];
      }
    } catch (e) {
      throw e;
    }
  }
}
