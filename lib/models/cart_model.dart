// ignore_for_file: public_member_api_docs, sort_constructors_first

class CartModel {
  final String id;
  final String productId;
  final String title;
  final int product_quantity;
  final String status;
  final String image;
  final String description;
  final String variant_type;
  final String variant_size;
  final String variant_style;
  final String variant_material;
  final String variant_color;
  final int variant_price;
  final double  variant_weight;
  final int variant_quantity;
  final String variant_SKU;
  final String parentSKU_childSKU;

  CartModel({
    required this.id,
    required this.productId,
    required this.title,
    required this.status,
    required this.image,
    required this.description,
    required this.product_quantity,
    required this.variant_type,
    required this.variant_size,
    required this.variant_style,
    required this.variant_material,
    required this.variant_color,
    required this.variant_price,
    required this.variant_weight,
    required this.variant_quantity,
    required this.variant_SKU,
    required this.parentSKU_childSKU,
  });

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
        id: map['_id'] ?? '',
        productId: map['productId'] ?? '',
        title: map['title'] ?? '',
        status: map['status'] ?? '',
        image: map['image'] ?? '',
        description: map['description'] ?? 'No description found',
        variant_type: map['variant_type'] ?? '',
        variant_size: map['variant_size'] ?? '',
        variant_style: map['variant_style'] ?? '',
        variant_material: map['variant_material'] ?? '',
        variant_price: map['variant_price'] ?? 0,
        variant_color: map['variant_color'] ?? '',
         product_quantity: map['product_quantity'] ?? 0,
        variant_quantity: map['variant_quantity'] ?? 0,
        variant_weight: map['variant_weight']?.toDouble() ?? 0,
        variant_SKU: map['variant_SKU'] ?? '',
        parentSKU_childSKU: map['parentSKU_childSKU'] ?? '');
  }
}
