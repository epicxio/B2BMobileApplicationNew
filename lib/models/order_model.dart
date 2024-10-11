import 'dart:convert';
import 'package:coswan/models/address_model.dart';


class OrderModel {
  final String id;
  final String productId;
  final String cartId;
  final String title;
  final String storeName;
  final String description;
  final String status;
  final String image;
  final String variant_type;
  final int variant_size;
  final String variant_style;
  final String variant_material;
  final String variant_color;
  final int variant_price;
  final double variant_weight;
  final String variant_SKU;
  final int variant_quantity;
  final String parentSKU_childSKU;
  final String paymentMethod;
  final String paymentStatus;
  final AddressModel address;
  final String role;
  final int order_Id;
  final int remainingQuantity ;
  final String email;
  final String  date ;
  final String transactionId;

  OrderModel({
    required this.id,
    required this.productId,
    required this.cartId,
    required this.title,
    required this.storeName,
    required this.description,
    required this.status,
    required this.image,
    required this.variant_type,
    required this.variant_size,
    required this.variant_style,
    required this.variant_material,
    required this.variant_color,
    required this.variant_price,
    required this.variant_weight,
    required this.variant_SKU,
    required this.variant_quantity,
    required this.parentSKU_childSKU,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.order_Id,
    required this.address,
    required this.email,
    required this.role,
    required this.date,
    required this.remainingQuantity,
    required this.transactionId,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['_id'] ?? '',
      productId: map['productId'] ?? '',
      cartId: map['cartId'] ?? '',
      title: map['title'] ?? '',
      storeName: map['storename'] ?? '',
      description: map['description'] ?? '',
      status: map['status'] ?? '',
      image: map['image'] ?? '',
      variant_type: map['variant_type'] ?? '',
      variant_size: map['variant_size'].toInt() ?? 0,
      variant_style: map['variant_style'] ?? '',
      variant_material: map['variant_material'] ?? '',
      variant_color: map['variant_color'] ?? '',
      variant_price: map['variant_price'].toInt() ?? 0,
      variant_weight: (map['variant_weight'] ?? 0).toDouble(),
      variant_SKU: map['variant_SKU'] ?? '',
      variant_quantity: map['variant_quantity']?.toInt() ?? 0,
      parentSKU_childSKU: map['parentSKU_childSKU'] ?? '',
      paymentMethod: map['paymentMethod'] ?? '',
      paymentStatus: map['paymentStatus'] ?? '',
      address: AddressModel.fromMap(map['address']['address']),
      order_Id: map['order_Id'].toInt() ?? 0,
      email : map['email'] ?? '',    
      role: map['role'] ?? '',
      date: map['date'] ?? '',
      remainingQuantity: map['remainingQuantity']?.toInt() ?? 0,
      transactionId: map['transactionId'] ?? '',
    );
  }

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));
}
