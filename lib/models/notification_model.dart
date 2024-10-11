import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class NotificationModel {
  final String id;
  final String from;
  final String senderUserId;
  final String senderRole;
  // final String gstnumber;
  final String productId;
  final String variantType;
  final int variant_size;
  final String variant_style;
  final String variant_material;
  final String variant_color;
  final double variant_weight;
  final int variant_price;
  final int variant_quantity;
  final int product_quantity;
  final String receiverUserId;
  final String receiverRole;
  final String receiverMessage;
  final String title;
  final String description;
  final String variant_SKU;
  final String parentSKU_childSKU;
  final String image;
  final String cartId;
  final String approvalStatus;
  final String createdAt;

  NotificationModel(
      {required this.id,
      required this.from,
      required this.senderUserId,
      required this.senderRole,
      required this.productId,
      required this.variantType,
      required this.variant_size,
      required this.variant_style,
      required this.variant_material,
      required this.variant_color,
      required this.variant_weight,
      required this.variant_price,
      required this.variant_quantity,
      required this.product_quantity,
      required this.receiverUserId,
      required this.receiverRole,
      required this.receiverMessage,
      required this.title,
      required this.description,
      required this.variant_SKU,
      required this.parentSKU_childSKU,
      required this.image,
      required this.cartId,
      required this.createdAt,
      required this.approvalStatus});

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
        id: map['_id'] ?? '',
        from: map['from'] ?? '',
        senderUserId: map['senderUserId'] ?? '',
        senderRole: map['senderRole'] ?? '',
        productId: map['productId'] ?? '',
        variantType: map['variantType'] ?? '',
        variant_size: map['variant_size']?.toInt() ?? 0,
        variant_style: map['variant_style'] ?? '',
        variant_material: map['variant_material'] ?? '',
        variant_color: map['variant_color'] ?? '',
        variant_weight: map['variant_weight']?.toDouble() ?? 0,
        variant_price: map['variant_price']?.toInt() ?? 0,
        variant_quantity: map['variant_quantity']?.toInt() ?? 0,
        receiverUserId: map['receiverUserId'] ?? '',
        receiverRole: map['receiverRole'] ?? '',
        receiverMessage: map['receiverMessage'] ?? '',
        product_quantity: map['product_quantity'] ?? 0,
        title: map['title'] ?? '',
        description: map['description'] ?? '',
        variant_SKU: map['variant_SKU'] ?? '',
        parentSKU_childSKU: map['parentSKU_childSKU'] ?? '',
        image: map['image'] ?? '',
        cartId: map['cartId'] ?? '',
        approvalStatus: map['approvalStatus'] ?? '',
        createdAt: map['createdAt'] ?? '');
  }

 

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source));
}
