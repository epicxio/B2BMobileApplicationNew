import 'dart:convert';
import 'package:coswan/models/user_model.dart';
import 'package:coswan/screens/otplogin.dart';
import 'package:coswan/utils/route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterApi {
  static Future<List<String>> registerCityAPI() async {
    try {
      const url = '${APIRoute.route}/unique-cities';
      final uri = Uri.parse(url);
      final res = await http.get(uri);
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

  // to register the new user
  static Future<void> postData(
      BuildContext context,
      String storename,
      String address,
      String email,
      String password,
      int phoneno,
      String gst,
      String city,
      String role,
      bool acceptedTerms) async {
    final scaffold = ScaffoldMessenger.of(context);
    try {
      final String fcmtoken = FirebaseMessaging.instance.getToken().toString();

      const url = '${APIRoute.route}/register';
      User register = User(
          id: '',
          storename: storename,
          address: address,
          role: role,
          email: email,
          gstnumber: gst,
          city: city,
          password: password,
          phonenumber: phoneno,
          acceptedTerms: acceptedTerms,
          token: '',
          fcmRegisterToken: fcmtoken);
      print(register.toMap());
      final res = await http.post(
        Uri.parse(url),
        body: register.toJson(),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      );

      if (res.statusCode == 200) {
        print('Data sent successfully');
        await Future.delayed(const Duration(seconds: 2));
        const snackBar = SnackBar(
          content: Text('OTP sent successfully'),
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Color.fromRGBO(144, 110, 16, 1),
        );
        scaffold.showSnackBar(snackBar);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OtpLoginpage(useremail: email)));
        // Fluttertoast.showToast(msg: "Login success");
      } else {
        final snackBar = SnackBar(
          content: Text(
            jsonDecode(res.body)['error'],
            style: const TextStyle(color: Colors.white),
          ),
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
        );
        scaffold.showSnackBar(snackBar);
      }

      print(res.body);
    } catch (e) {
      print(e);
    }
  }
}
