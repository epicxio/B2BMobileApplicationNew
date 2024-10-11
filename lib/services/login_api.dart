import 'dart:convert';
import 'package:coswan/screens/distributor_pages/dashboard.dart';
import 'package:coswan/screens/forgot_pwd_otp.dart';
import 'package:coswan/screens/homepage.dart';
import 'package:coswan/screens/password_update_success.dart';
import 'package:coswan/providers/userprovider.dart';
import 'package:coswan/storageservice.dart';
import 'package:coswan/utils/navigation_transition.dart';
import 'package:coswan/utils/route.dart';
import 'package:coswan/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class LoginAPI {
  static Future<void> postData(BuildContext context, String identifier,
      String password, bool isChecked) async {
    final user = Provider.of<UserProvider>(context, listen: false);
    final scaffold = ScaffoldMessenger.of(context);
    try {
      final navigator = Navigator.of(context);
      const url = '${APIRoute.route}/login';
      final uri = Uri.parse(url);
      // Determine if the identifier is email or phone number
      Map<String, String> loginData;

      if (RegExp(r'^\d{10}$').hasMatch(identifier)) {
        loginData = {
          "phonenumber": identifier.trim(),
          "password": password.trim()
        };
      } else {
        loginData = {"email": identifier.trim(), "password": password.trim()};
      }
      // var loginData = {"email": email.trim(), "password": password.trim()};
      final res = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(loginData),
      );

      if (res.statusCode == 200) {
        user.setUSer(res.body);

        if (isChecked) {
          final storageService = StorageService();
          await storageService.saveUserLoginDataForReme(identifier, password);
        
        }
        user.user.role == "Distributor"
            ? navigator.push(MaterialPageRoute(
                builder: (context) => const DashboradDistribtor()))
            : navigator.push(NavigationTransition(const HomePage()));
      
      } else {
        final snackBar = SnackBar(
          content: Text(
            jsonDecode(res.body)['error'],
            style: const TextStyle(color: Colors.white),
          ),
          duration: const  Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
        );
        scaffold.showSnackBar(snackBar);
        // print('Failed to send data: ${res.statusCode}');
      }

      //print(res.body);
    } catch (e) {
      print(e);
    }
  }

  // forgot password API

  static Future<void> forgotpassword(BuildContext context, String email) async {
    final navigator = Navigator.of(context);
    try {
      const uri = '${APIRoute.route}/forgot-password';
      final url = Uri.parse(uri);
      final req = {'email': email};
      final res = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode(req));
      print(res.statusCode);
      if (res.statusCode == 200) {
        navigator.pushReplacement(MaterialPageRoute(
            builder: (context) => ForgotPasswordOtp(
                  userEmail: email,
                )));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            jsonDecode(res.body)['error'],
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
            ),
          ),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      rethrow;
    }
  }

// update password api
  static Future<void> newpasswordAPI(BuildContext context, String email,
      String newpassword, String confirmPassword) async {
    final navigator = Navigator.of(context);
    try {
      const uri = '${APIRoute.route}/reset-password';
      final url = Uri.parse(uri);
      final req = {
        'email': email,
        'newPassword': newpassword,
        'confirmPassword': confirmPassword
      };
      final res = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode(req));
      if (res.statusCode == 200) {
        navigator.push(NavigationTransition(const PasswordUpdateSuccess()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              jsonDecode(res.body)['error'],
              style: TextStyle(fontSize: 14.sp, color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
