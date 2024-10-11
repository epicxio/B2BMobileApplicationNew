import 'dart:convert';
import 'package:coswan/providers/userprovider.dart';
import 'package:coswan/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class DistributorDashboardAPI {
  static Future<Map<String, dynamic>> dasboardCount(
      BuildContext context, String endval) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      final url = "${APIRoute.route}/$endval";
      final uri = Uri.parse(url);
      final res = await http.get(uri, headers: {
        'Content-Type': 'Application/json',
        'Accept': 'Application/json',
        'Authorization': 'Bearer ${user.token}'
      });
      final Map<String, dynamic> result = jsonDecode(res.body);
      print(result);
      return result;
    } catch (e) {
      throw e;
    }
  }

  static Future<Map<String, dynamic>> WeekgraphAPI(
    BuildContext context,
  ) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      const url =
          "${APIRoute.route}/api/graph/completed-order-counts?type=week";
      final uri = Uri.parse(url);
      final res = await http.get(uri, headers: {
        'Content-Type': 'Application/json',
        'Accept': 'Application/json',
        'Authorization': 'Bearer ${user.token}'
      });
      final Map<String, dynamic> result = jsonDecode(res.body);

      print(result);
      return result;
    } catch (e) {
      throw e;
    }
  }

  static Future<Map<String, dynamic>> yeargraphAPI(
      BuildContext context, String year) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      final url =
          "${APIRoute.route}/api/graph/completed-order-counts?type=year&year=$year";
      final uri = Uri.parse(url);
      final res = await http.get(uri, headers: {
        'Content-Type': 'Application/json',
        'Accept': 'Application/json',
        'Authorization': 'Bearer ${user.token}'
      });
      final Map<String, dynamic> result = jsonDecode(res.body);

      print(result);
      return result;
    } catch (e) {
      throw e;
    }
  }

  static Future<Map<dynamic, dynamic>> monthgraphAPI(
      BuildContext context, String month, String year) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      final url =
          "${APIRoute.route}/api/graph/completed-order-counts?type=month&year=$year&month=$month";
      final uri = Uri.parse(url);
      final res = await http.get(uri, headers: {
        'Content-Type': 'Application/json',
        'Accept': 'Application/json',
        'Authorization': 'Bearer ${user.token}'
      });
      final Map<dynamic, dynamic> result = jsonDecode(res.body);

      print(result);
      return result;
    } catch (e) {
      throw e;
    }
  }

  static Future<Map<String, dynamic>> ordersCountAPI(
      BuildContext context) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;

    try {
      const url = '${APIRoute.route}/orders-distributor-counts';
      final uri = Uri.parse(url);
      final res = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.token}'
      });
      if (res.statusCode == 200) {
        final Map<String, dynamic> result = jsonDecode(res.body);
        return result;
      } else {
        return {};
      }
    } catch (e) {
      rethrow;
    }
  }
}
