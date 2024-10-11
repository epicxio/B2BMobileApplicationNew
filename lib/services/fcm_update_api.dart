import 'dart:convert';
import 'package:coswan/providers/userprovider.dart';
import 'package:coswan/utils/route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class FcmUpdateAPI {
  static fcmUpdateAPI(BuildContext context ,  [String? inLogOUt]) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      const url = '${APIRoute.route}/register/update-fcm-token';
      final uri = Uri.parse(url);
      final req = {
        'userId': user.id,
        'gstnumber': user.gstnumber,
        'role': user.role,
        'fcmRegisterToken': inLogOUt == 'logout' ? null : await FirebaseMessaging.instance.getToken()
      };
      
    print(req);
      final response = await http.put(uri,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${user.token}'
          },
      
          body: jsonEncode(req));
             print(response.body);
      print(req);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(
            '------------------------------------------------------------------------');
      }
    } catch (e) {
      rethrow;
    }
  }
}
