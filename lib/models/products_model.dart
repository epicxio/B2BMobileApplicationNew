// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:coswan/models/multivariant_model.dart';

class ProductsModel {
  final String id;
  final String title;
  final String description;
  final String image;
  final String videoUrl;
  final String variant_type;
  final String variant_size;
  final String variant_style;
  final String variant_material;
  final String variant_color;
  final int variant_price;
  final double variant_weight;
  final String variant_SKU;
  final int variant_quantity;
  final List<MultivariantModel> multipleVariants;
  final String parentSKU_childSKU;

  // final double weight;
  // variants
  //multipleVariants
  ProductsModel({
    required this.id,
    required this.title,
    required this.description,
    //  required this.compareprice,
    required this.image,
    required this.videoUrl,
    // required this.weight,
    required this.variant_type,
    required this.variant_size,
    required this.variant_style,
    required this.variant_material,
    required this.variant_color,
    required this.variant_price,
    required this.variant_weight,
    required this.variant_quantity,
    required this.variant_SKU,
    required this.multipleVariants,
    required this.parentSKU_childSKU,
  });
  factory ProductsModel.fromMap(Map<String, dynamic> e) {
    return ProductsModel(
      id: e['_id'] ?? '',
      title: e['title'] ?? '',
      description: e['description'] ?? '',
      //   price: (e['price'] ?? 0).toDouble(),
      //  compareprice: (e['compareprice'] ?? 0).toDouble(),
      image: e['image'] ?? '',
      videoUrl: e['video'] ?? '',
      variant_type: e['variant_type'] ?? '',
      variant_size: e['variant_size'] ?? '',
      variant_style: e['variant_style'] ?? '',
      variant_material: e['variant_material'] ?? '',
      variant_color: e['variant_color'] ?? '',
      variant_price: e['variant_price'] ?? 0,
      variant_weight: e['variant_weight']?.toDouble() ?? 0.0,
      variant_quantity: e['variant_quantity'] ?? 0,
      variant_SKU: e['variant_SKU'] ?? '',
      multipleVariants: (e['multipleVariants'] as List<dynamic> ?? [])
          .map((variant) => MultivariantModel.fromMap(variant))
          .toList(),
      parentSKU_childSKU: e['parentSKU_childSKU'] ?? '',

      // weight: (e['weight'] ?? 0).toDouble(),
    );
  }

  // factory ProductsModel.fromMap(Map<String, dynamic> map) {
  //   return ProductsModel(
  //     id: map['id'] as String,
  //     title: map['title'] as String,
  //     description: map['description'] as String,
  //     price: map['price'] as double,
  //     customcategory: map['customcategory'] as String,
  //     collection: map['collection'] as String,
  //     tags: map['tags'] as String,
  //     vendor: map['vendor'] as String,
  //     compareprice: map['compareprice'] as double,
  //     image: map['image'] as String,
  //     video: map['video'] as String,
  //     newarrived: map['newarrived'] as bool,
  //     gst: map['gst'] as double,
  //     totalprice: map['totalprice'] as double,
  //     sku: map['sku'] as String,
  //     barcode: map['barcode'] as String,
  //     gender: map['gender'] as String,
  //     weight: map['weight'] as double,
  //   );
  // }

  factory ProductsModel.fromJson(String source) =>
      ProductsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
