import 'dart:convert';

class MultivariantModel {
  final String variant_size;
  final String variant_style;
  final String variant_material;
  final String variant_color;
  final double variant_weight;
  final int variant_price;
  final String variant_SKU;
  final int variant_quantity;
  final String parentSKU_childSKU;
  MultivariantModel({
    required this.variant_size,
    required this.variant_style,
    required this.variant_material,
    required this.variant_color,
    required this.variant_weight,
    required this.variant_price,
    required this.variant_SKU,
    required this.variant_quantity,
    required this.parentSKU_childSKU,
  });

  factory MultivariantModel.fromMap(Map<String, dynamic> map) {
    return MultivariantModel(
      variant_size: map['variant_size'] ?? '',
      variant_style: map['variant_style'] ?? '',
      variant_material: map['variant_material'] ?? '',
      variant_color: map['variant_color'] ?? '',
      variant_weight: (map['variant_weight']).toDouble() ?? 0,
      variant_price: map['variant_price'] ?? 0,
      variant_SKU: map['variant_SKU'] ?? '',
      variant_quantity: map['variant_quantity'] ?? 0,
      parentSKU_childSKU: map['parentSKU_childSKU'] ?? '',
    );
  }

  // String toJson() => json.encode(toMap());

  factory MultivariantModel.fromJson(String source) =>
      MultivariantModel.fromMap(json.decode(source));
}
