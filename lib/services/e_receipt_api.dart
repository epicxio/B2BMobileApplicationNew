import 'dart:convert';
import 'dart:typed_data';

import 'package:coswan/providers/userprovider.dart';
import 'package:coswan/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


class EReceiptAPI {
  static Future<Uint8List?> generateReceipt(BuildContext context,
      List<String> selectedItems, List<String> transactionId) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false).user;

    try {
      const url = '${APIRoute.route}/generate-receipt';
      final uri = Uri.parse(url);
      final req = {
        'selectedItems': selectedItems,
        'transactionId': transactionId
      };

      final res = await http.post(
        uri,
        body: jsonEncode(req),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userprovider.token}'
        },
      );

      print('erecipt da');
      print(res.statusCode);

      if (res.statusCode == 200) {
        // Get the path to the Downloads directory
        // final directory = await getExternalStorageDirectory();
        // final downloadsPath = path.join(directory!.path, 'Download');

        // // Ensure the Downloads directory exists
        // final downloadsDir = Directory(downloadsPath);
        // if (!downloadsDir.existsSync()) {
        //   downloadsDir.createSync(recursive: true);
        // }
        // final filePath = path.join(downloadsPath, 'receipt.pdf');
        // final file = File(filePath);
        // await file.writeAsBytes(res.bodyBytes);
        // print('PDF saved to $filePath');

        // CustomNotifyToast.showCustomToast(
        //     context, 'Receipt downloaded Successfully');
         print('PDF received successfully');
        return res.bodyBytes;
      } else {
        print('Failed to generate receipt: ${res.body}');
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
}
