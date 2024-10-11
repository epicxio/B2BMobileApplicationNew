import 'dart:io';
import 'dart:convert';
import 'package:coswan/models/order_model.dart';
import 'package:coswan/providers/distributor_order_provider.dart';
import 'package:coswan/providers/userprovider.dart';
import 'package:coswan/utils/route.dart';
import 'package:coswan/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class OrderDistributor {
  static Future<void> orderStatusUpdate(
      BuildContext context,
      String cartId,
      String status,
      String toastmsg,
      String endpointForGetAPI,
      String comment,
      String variantQuantity,
      String remainingQuantity,
      String transactionId,
      File? photo) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      const url = '${APIRoute.route}/update-order-status';
      final uri = Uri.parse(url);
   showDialog(
        context: context,
        barrierDismissible: false,
        // Prevent dismissing
        builder: (BuildContext context) {
          return const  Center(
            child:  CircularProgressIndicator(),
          );
        },
      );
      // create the multipart request

      final request = http.MultipartRequest('PUT', uri);
      request.fields['cartId'] = cartId;
      request.fields['status'] = status;
      request.fields['comment'] = comment;
      request.fields['userId'] = user.id;
      request.fields['variant_quantity'] = variantQuantity;
      request.fields['remainingQuantity'] = remainingQuantity;
      request.fields['transactionId'] = transactionId;
      // Add a photo if not null
print(request.fields);
      if (photo != null) {
        request.files.add(http.MultipartFile(
            'statusImage', photo.readAsBytes().asStream(), photo.lengthSync(),
            filename: photo.path.split('/').last,
            contentType: MediaType('image', 'jpeg')));
      }

      // add headers
      request.headers.addAll({'Authorization': 'Bearer ${user.token}'});
      // Send request

      var res = await request.send();
       Navigator.of(context).pop();
      print(res.statusCode);
      print(res.reasonPhrase);
      if (res.statusCode == 200 || res.statusCode == 201) {
        CustomNotifyToast.showCustomToast(
            context, 'Order Moved to $status Section.');
        print(endpointForGetAPI);
        orderStatus(context, endpointForGetAPI);
        Navigator.pop(context);
        //  showCustomToast(context, toastmsg);
      }
    } catch (e) {
      throw e;
    }
  }

  // to get order
  static Future<void> orderStatus(BuildContext context, String endPoint) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    final orderDistributor =
        Provider.of<DistributorOrderProvider>(context, listen: false);
    orderDistributor.dataloading = true;
    //  orderDistributor.clearData();
     
    try {
      final url = "${APIRoute.route}/orders-distributor?status=$endPoint";
      final uri = Uri.parse(url);
      final res = await http.get(uri, headers: {
        'Content-Type': 'Application/json',
        'Accept': 'Application/json',
        'Authorization': 'Bearer ${user.token}'
      });
      final result = jsonDecode(res.body);
     
      final List<OrderModel> transformed = List<OrderModel>.from(
          result.map((e) => OrderModel.fromMap(e)).toList());
      print(result);

      // if (res.statusCode == 200) {
      orderDistributor.setOrders(transformed);

      //    return transformed;
    } catch (e) {
      throw e;
    }
  }
}
