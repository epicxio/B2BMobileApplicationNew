import 'dart:convert';
import 'package:coswan/models/cart_model.dart';
import 'package:coswan/providers/cartprovider.dart';
import 'package:coswan/providers/userprovider.dart';
import 'package:coswan/services/notification_api.dart';
import 'package:coswan/utils/route.dart';
import 'package:coswan/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CartAPI {
  //
  static Future<void> storeOwnerUpdateForHisCart(
      BuildContext context, String cartId, String quantity) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;

    try {
      final url = '${APIRoute.route}/store-update-cart/$cartId';
      final uri = Uri.parse(url);
      final data = {
        'role': user.role,
        "variant_quantity": quantity,
      };
      //   print(data);
      final res = await http.put(uri,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${user.token}'
          },
          body: jsonEncode(data));
      print('dfjjdkshskjfhskjhgskjghksjghkjsfhg');
      print(res.body);
      print(res.statusCode);
      if (res.statusCode == 200) {
        CartAPI.fetchCartData(context);
        CustomNotifyToast.showCustomToast(
            context, 'Product Quantity updated Sucessfully');
      }
      if (res.statusCode == 400) {
        bool isSnackBarVisible = false;

        if (!isSnackBarVisible) {
          isSnackBarVisible = true;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Invalid Quantity or Invalid data ',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
              duration: Durations.extralong3,
            ),
          );
        }
      }
    } catch (e) {
      throw e;
    }
  }

// purchase owner update .. for their prodcut
  static Future<void> purchaseManagerUpdate(
      BuildContext context,
      String id,
      String productId,
      String quantity,
      String parentSKUchildSKU,
      String variantSKU) async {
    print(id);
    final user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      final url = '${APIRoute.route}/purchase-quantity/$id';
      final uri = Uri.parse(url);
      final Map<String, dynamic> data = {
        'role': user.role,
        'productId': productId,
        'userId': user.id,
        'gstnumber': user.gstnumber,
        'variant_quantity': quantity,
        'parentSKU_childSKU': parentSKUchildSKU,
        'variant_SKU': variantSKU,
      };
      print(data);
      final res = await http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${user.token}'
        },
        body: jsonEncode(data),
      );
      if (res.statusCode == 200) {
        CartAPI.fetchCartData(context);
        CustomNotifyToast.showCustomToast(
            context, 'Product Quantity updated Sucessfully');
      }
      if (res.statusCode == 400) {
        bool isSnackBarVisible = false;

        if (!isSnackBarVisible) {
          isSnackBarVisible = true;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Invalid Quantity or Invalid data ',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
              duration: Durations.extralong3,
            ),
          );
        }
      }
      print(res.body);
      print(res.statusCode);
    } catch (e) {
      throw e;
    }
  }

  // to add the product to the cart
  static Future<void> sendForApproval(
      BuildContext context,
      String endval,
      dynamic totalcount,
      String productid,
      String variantType,
      String variantSize,
      String variantStyle,
      String variantMaterial,
      String variantColor,
      String variantWeight,
      String variantPrice,
      String variantSKU,
      String parentchildSku) async {
    final userAuth = Provider.of<UserProvider>(context, listen: false).user;
    final url = '${APIRoute.route}/$endval';

    String toastnotify() {
      if (endval == 'Storeownerupdate') {
        return 'Updated Successfully';
      } else if (endval == 'add-to-cart') {
        return 'Product Added Successfully';
      } else {
        return 'Approval send to store owner successfully';
      }
    }

    try {
      print(url);
      final valu = {
        "gstnumber": userAuth.gstnumber,
        "userId": userAuth.id,
        "productId": productid,
        "role": userAuth.role,
        'variantType': variantType,
        'variant_SKU': variantSKU,
        'variant_size': variantSize,
        'variant_style': variantStyle,
        'variant_material': variantMaterial,
        'variant_color': variantColor,
        'variant_weight': variantWeight,
        'variant_price': variantPrice,
        "variant_quantity": totalcount,
        'parentSKU_childSKU': parentchildSku,
      };
      print(valu);

      // print(valu);
      final res = await http.post(
        Uri.parse(url),
        body: jsonEncode(valu),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userAuth.token}'
        },
      );
      //  print(res.statusCode);
      if (res.statusCode == 200) {
        // final result = jsonDecode(res.body);

        CartAPI.fetchCartData(context);

        CustomNotifyToast.showCustomToast(context, toastnotify());
      } else {
        print(res.body);
        print('Failed to send data: ${res.statusCode}');
      }
      if (res.statusCode == 400) {
        bool isSnackBarVisible = false;

        if (!isSnackBarVisible) {
          isSnackBarVisible = true;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Invalid Quantity or Invalid data ',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
              duration: Durations.extralong3,
            ),
          );
        }
      }
    } catch (e) {
     rethrow;
    }
  }

  // to update the product
  static Future<void> updateFromStoreOwner(
      BuildContext context,
      String cartIdFromNotification,
      String productid,
      quantity,
      String parentSKUchildSKU,
      String variantSKU) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    print(cartIdFromNotification);

    try {
      final url = '${APIRoute.route}/quantity/$cartIdFromNotification';
      final uri = Uri.parse(url);
      final data = {
        'role': user.role,
        'productId': productid,
        'userId': user.id,
        'gstnumber': user.gstnumber,
        'variant_quantity': quantity,
        'parentSKU_childSKU': parentSKUchildSKU,
        'variant_SKU': variantSKU,
      };
      //  print(data);
      final res = await http.put(uri,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${user.token}'
          },
          body: jsonEncode(data));

      if (res.statusCode == 200) {
        //   print(res.body);
        NotificationAPI.notificationApi(context);
        CustomNotifyToast.showCustomToast(
            context, 'Product updated Sucessfully');
      }
      if (res.statusCode == 400) {
        bool isSnackBarVisible = false;

        if (!isSnackBarVisible) {
          isSnackBarVisible = true;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Invalid Quantity or Invalid data ',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
              duration: Durations.extralong3,
            ),
          );
        }
      }
    } catch (e) {
      throw e;
    }
  }

  // to get the cart items
  static Future<void> fetchCartData(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    final cart = Provider.of<CartProvider>(context, listen: false);
    try {
      final url = '${APIRoute.route}/get-cart-items/${userProvider.id}';
      final uri = Uri.parse(
        url,
      );
      final res = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userProvider.token}'
        },
      );
      print('${res.statusCode} for  get cart');
      if (res.statusCode == 200) {
        print('cartItem');
        // print(res.body);

        final List<dynamic> result = jsonDecode(res.body);

        final transformed = result.map((e) => CartModel.fromMap(e)).toList();
        print('dfklsdflktransfor,');
        cart.setCart(transformed);
      }
    } catch (e) {
      rethrow;
    }
  }

  // // to display the total price
  // Future<void> totalPriceAPI(BuildContext context, selectedCartId) async {
  //   final userprovider = Provider.of<UserProvider>(context, listen: false).user;

  //   try {
  //     final req = <String, dynamic>{
  //       'role': userprovider.role,
  //       'selectedItems': selectedCartId
  //     };
  //     const url = '${APIRoute.route}/totalamount';
  //     final uri = Uri.parse(url);
  //     final res = await http.post(uri, body: jsonEncode(req), headers: {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer ${userprovider.token}'
  //     });
  //     // final result = jsonDecode(res.body);
  //     // setState(() {
  //     //   totalPrice = result['totalAmount'];
  //     //   print(totalPrice);
  //     // });
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  // to remove the item from the cart
  static Future<void> removeCartItem(
      BuildContext context, String itemId) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false).user;
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    try {
      final removalData = <String, dynamic>{
        'role': userprovider.role,
        'addcartId': itemId
      };
      const url = '${APIRoute.route}/remove';
      final uri = Uri.parse(url);
      final res = await http.post(
        uri,
        body: jsonEncode(removalData),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userprovider.token}'
        },
      );
      if (res.statusCode == 200) {
        cartProvider.removeFromcart(itemId);
        CustomNotifyToast.showCustomToast(
            context, "Cart Item Deleted Successfully");
      }

      //  print(res.statusCode);
    } catch (e) {
      rethrow;
    }
  }
}
