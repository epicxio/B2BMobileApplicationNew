
import 'package:coswan/models/category_model.dart';
import 'package:coswan/models/products_model.dart';

class BannerCarouselModel {
  final String id;
  final String bannerName;
  final String bannerImage;
  final String associatedWith;
  final dynamic associatedDocument;

  BannerCarouselModel(
      {required this.id,
      required this.bannerName,
      required this.bannerImage,
      required this.associatedWith,
      required this.associatedDocument});

  factory BannerCarouselModel.fromMap(Map<String, dynamic> map) {
    return BannerCarouselModel(
      id: map['_id']  ?? '',
      bannerName: map['bannerName']  ?? '',
      bannerImage: map['bannerImage']  ?? '',
      associatedWith: map['associatedWith']  ?? '',
      associatedDocument: map['associatedWith'] =='Product' ?ProductsModel.fromMap( map['associatedDocument'] as Map<String, dynamic>) : CategoryModel.fromMap(map['associatedDocument'] as Map<String, dynamic>),

    );
  }

 
}
