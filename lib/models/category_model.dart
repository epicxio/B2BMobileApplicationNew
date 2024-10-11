class CategoryModel {
  final String id;
  final String categoryName;
  final String categoryImage;
  CategoryModel({
    required this.id,
    required this.categoryName,
    required this.categoryImage,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['_id'] ?? '',
      categoryName: map['categoryName'] ?? '',
      categoryImage: map['categoryImage'] ?? '',
    );
  }

  static List<CategoryModel> fromList(List<dynamic> list) {
    return list.map((item) => CategoryModel.fromMap(item)).toList();
  }
}
