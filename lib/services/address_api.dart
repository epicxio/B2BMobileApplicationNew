import 'dart:convert';
import 'package:coswan/models/address_model.dart';
import 'package:coswan/screens/address%20_list.dart';
import 'package:coswan/screens/addresselectionpage.dart';
import 'package:coswan/providers/userprovider.dart';
import 'package:coswan/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AddressApi {
// address state API
  static Future<List<String>> addressStateAPI(BuildContext context) async {
    try {
      final user = Provider.of<UserProvider>(context, listen: false).user;
      const url = '${APIRoute.route}/states';
      final uri = Uri.parse(url);
      final res = await http.get(uri,
      headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${user.token}'
        },);
      //  print(res.body);
      print(res.statusCode);
      final cities = List<String>.from(jsonDecode(res.body));

      if (res.statusCode == 200) {
        print(res.body);
      }
      return cities;
    } catch (e) {
      rethrow;
    }
  }

  // address city API
  static Future<List<String>> addressCityAPI(BuildContext context , String state) async {
    try {
      final user = Provider.of<UserProvider>(context, listen: false).user;
      final url = '${APIRoute.route}/cities-by-state?state=$state';
      final uri = Uri.parse(url);
      final res = await http.get(uri,
       headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${user.token}'
        },);
      //  print(res.body);
   
      final cities = List<String>.from(jsonDecode(res.body));

      if (res.statusCode == 200) {
         print(res.statusCode);
      }
      return cities;
    } catch (e) {
      rethrow;
    }
  }

// get api to display the address after selecting from the list
  static Future<AddressModel> getCurretAddress(BuildContext context) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      final url = '${APIRoute.route}/get-current-address/${user.id}';
      final uri = Uri.parse(url);
      final res = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${user.token}'
        },
      );

      final dynamic address = jsonDecode(res.body);
       print(res.statusCode);
      return AddressModel.fromMapForCurrentAddressSelected(address);
    } catch (e) {
      rethrow;
    }
  }

// to select the address api
  static Future<void> addressSelectAPI(
      BuildContext context, String defaultaddress, checkoutproduct) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    final navigator = Navigator.of(context);
    try {
      print(defaultaddress);
      const url = '${APIRoute.route}/select-address';
      final uri = Uri.parse(url);
      final req = <String, dynamic>{
        'userId': user.id,
        'selectedAddressId': defaultaddress.toString()
      };
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
      if (res.statusCode == 200) {
        navigator.pushReplacement(MaterialPageRoute(
            builder: (context) =>
                AddresselectionPage(checkoutproduct: checkoutproduct)));
        print(' api call sucess');
      }
    } catch (e) {
      throw e.toString();
    }
  }

//list of address get  api
  static Future<List<AddressModel>> addressListAPI(BuildContext context) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      final url = '${APIRoute.route}/get-addresses/${user.id}';
      final uri = Uri.parse(url);
      final res = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${user.token}'
        },
      );
      final List<dynamic> addresslist = jsonDecode(res.body);
      final trasformed =
          addresslist.map((e) => AddressModel.fromMap(e)).toList();
      if (res.statusCode == 200) {
        print(' api call sucess');
      }
      return trasformed;
    } catch (e) {
      throw e.toString();
    }
  }

  // to post  the address from the input fields
  static Future<void> addAddressAPI(
      BuildContext context,
      String fullName,
      String houseNo,
      String phoneNo,
      String state,
      String city,
      String landMark,
      String roadName,
      String typeOfAddress,
      int pinCode,
      checkoutproduct) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    final navigator = Navigator.of(context);
    try {
      const url = '${APIRoute.route}/save-address';
      final uri = Uri.parse(url);

      AddressModel address = AddressModel(
          id: '',
          fullName: fullName,
          houseNo: houseNo,
          phoneNumber: phoneNo,
          state: state,
          city: city,
          landmark: landMark,
          roadName: roadName,
          pincode: pinCode,
          addressType: typeOfAddress);

      final req = jsonEncode(address.toMap(user.id.trim()));
      final res = await http.post(uri, body: req, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.token}'
      });

      print(req);
      print(res.statusCode);
      print(res.body);
      if (res.statusCode == 200) {
        navigator.pushReplacement(MaterialPageRoute(
            builder: (context) =>
                AddressList(checkoutproduct: checkoutproduct)));
      }
    } catch (e) {
      rethrow;
    }
  }
}
