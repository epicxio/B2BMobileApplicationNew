import 'dart:convert';
import 'package:coswan/models/banner_carousel.dart';
import 'package:coswan/models/products_model.dart';
import 'package:coswan/models/category_model.dart';
import 'package:coswan/models/review_model.dart';
import 'package:coswan/providers/userprovider.dart';
import 'package:coswan/utils/route.dart';
import 'package:coswan/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomePageProdutsAPI {
  static Future<List<ProductsModel>> homePageAPI(
      BuildContext context, String endval) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false).user;
    try {
      final url = '${APIRoute.route}/$endval';
      final uri = Uri.parse(url);
      final res = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userprovider.token}'
        },
      );
      final List<dynamic> fastmovingdata = jsonDecode(res.body);
      if (res.statusCode == 200) {
        print(' api call sucess');
      }
      final transformed = fastmovingdata.map((e) {
        return ProductsModel.fromMap(e);
      }).toList();
      return transformed;
    } catch (e) {
      throw e.toString();
    }
  }

  // carousel banners API
  static Future<List<BannerCarouselModel>> homePageBannersAPI(
    BuildContext context,
  ) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false).user;
    try {
      const url = '${APIRoute.route}/products/carousel';
      final uri = Uri.parse(url);
      final res = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userprovider.token}'
        },
      );
      final List<dynamic> fastmovingdata = jsonDecode(res.body);
      if (res.statusCode == 200) {
        print(' api call sucess');
      }
      final transformed = fastmovingdata.map((e) {
        return BannerCarouselModel.fromMap(e);
      }).toList();
      return transformed;
    } catch (e) {
      throw e.toString();
    }
  }
}

class HomePageCategoryAPI {
  static Future<List<CategoryModel>> homePageAPIDynamic(
      BuildContext context) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false).user;
    try {
      const url = '${APIRoute.route}/categories';
      final uri = Uri.parse(url);
      final res = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json', // Update content type to JSON
          'Accept': 'application/json', // Update accept type to JSON
          'Authorization': 'Bearer ${userprovider.token}'
        },
      );
      if (res.statusCode == 200) {
        print('API call success');
        // print(res.body);
        final List<dynamic> categorydata = jsonDecode(res.body);
        final transformed = categorydata.map((e) {
          return CategoryModel.fromMap(e);
        }).toList();
        return transformed;
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }

  static Future<void> askQuestion(
      BuildContext context, String question, String productId) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false).user;
    try {
      const url = '${APIRoute.route}/question';
      final uri = Uri.parse(url);
      final req = {
        'role': userprovider.role,
        'questions': question,
        'userId': userprovider.id,
        'productId': productId
      };
      final res = await http.post(uri,
          headers: {
            'Content-Type': 'application/json', // Update content type to JSON
            'Accept': 'application/json', // Update accept type to JSON
            'Authorization': 'Bearer ${userprovider.token}'
          },
          body: jsonEncode(req));
      // print(res.body);
      // print(res.statusCode);
      if (res.statusCode == 200 || res.statusCode == 201) {
        CustomNotifyToast.showCustomToast(
            context, 'Question Submitted Successfully');
      }
    } catch (e) {
      rethrow;
    }
  }

  // to get the product variants Api
  static Future<Map<String, dynamic>> getVariants(
      BuildContext context, String productId) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false).user;

    try {
      final url = '${APIRoute.route}/products?productId=$productId';
      final uri = Uri.parse(url);
      final res = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${userprovider.token}'
      });
    
      if (res.statusCode == 200) {
        print(res.body);
        final data = jsonDecode(res.body);
        //  print(res.body);
        return data;
      } else {
        return {};
      }
    } catch (e) {
      rethrow;
    }
  }

  // to get the product (outofstock) and parentSku Api

  static Future<Map<String, dynamic>> getSKU(
      BuildContext context,
      String productId,
      String? vSize,
      String vWeight,
      String? vMaterial,
      String? vColor,
      String? vStyle) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false).user;

    try {
      final url =
          '${APIRoute.route}/productschecking?productId=$productId&variant_size=$vSize&variant_weight=$vWeight&&variant_style=$vStyle&variant_material=$vMaterial&&variant_color=$vColor';

      final uri = Uri.parse(url);
      final res = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${userprovider.token}'
      });
      if (res.statusCode == 200) {
        print(url);
        final data = jsonDecode(res.body);
        if (data == 0) {
          return {};
        }
        print('${res.body},${res.statusCode}');
        return data;
      } else {
        return {};
      }
    } catch (e) {
      rethrow;
    }
  }

 static  Future<ReviewModel> review(context ,String productId) async {
    try {
      final userprovider =
          Provider.of<UserProvider>(context, listen: false).user;

      final url = '${APIRoute.route}/reviews-calculation?productId=$productId';
      final uri = Uri.parse(url);
      final res = await http.get(uri, headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${userprovider.token}'
      });
      if (res.statusCode == 200) {
        final result = jsonDecode(res.body);
        print(result);
        final transformed  = ReviewModel.fromJson(result);
        return transformed;
      }
      else{
        return ReviewModel.fromJson({});
      }
    } catch (e) {
      rethrow;
    }
  }
}
