import 'dart:convert';

import 'package:coswan/models/register_otp_model.dart';
import 'package:coswan/screens/otpsuccess.dart';
import 'package:coswan/screens/password_reset_btn.dart';
import 'package:coswan/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

class OTPAPI {
// register otp api and forgot passwoed otp api
  static Future<void> postOtp(
      BuildContext context,
      String endval,
      String userEmail,
      String otp1,
      String otp2,
      String otp3,
      String otp4) async {
    final navigator = Navigator.of(context);
    try {
      final url = '${APIRoute.route}/$endval';
      RegisterOTPModel req = RegisterOTPModel(
          email: userEmail, submittedOTP: otp1 + otp2 + otp3 + otp4);
          print(req);
      final res = await http.post(
        Uri.parse(url),
        body: req.toJson(),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      );
      print(res.statusCode);
      if (res.statusCode == 200) {
        navigator.push(
          MaterialPageRoute(
              builder: (context) => endval == 'submit-otp'
                  ? const OtpSuccesspage()
                  : ForgotPassWordBtn(userMail: userEmail)),
        );
      }else{
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
}
// Future <void> forgotpasswordOTPAPI() async {
//   final navigator =Navigator.of(context);
//   try{
//     const  uri ='${APIRoute.route}/verify-otp';
//     final url = Uri.parse(uri);
//   final req = {'email': widget.userEmail,'otp':'${controller1.text}${controller2.text}${controller3.text}${controller4.text}'};
//     final res =await http.post(url,  headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json'
//       },body: jsonEncode(req));
//       print(req);
//       print(res.statusCode);
// if(res.statusCode==200){
//    navigator.push(
//                             NavigationTransition( ForgotPassWordBtn(userMail: widget.userEmail,)));
// }
//   }catch(e){
//     throw e;
//   }
//}
