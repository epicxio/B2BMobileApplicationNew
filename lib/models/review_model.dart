class ReviewModel {
  
  final int  totalReviews;
  final int totalUsers;
  final double averageRating;
  final List<Review> reviews;


  ReviewModel({
    required this.totalReviews,
    required this.totalUsers,
    // required this.totalStars,
    required this.averageRating,
    required this.reviews,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    var reviewsFromJson = json['reviews'] as List;
    List<Review> reviewList =
        reviewsFromJson.map((i) => Review.fromJson(i)).toList();

    return ReviewModel(
      totalReviews: json['totalReviews'] ?? 0,
      totalUsers: json['totalUsers'] ?? 0,
      // totalStars: json['totalStars'].toDouble() ?? 0.0,
      averageRating: double.parse(json['averageRating'] ?? 1),
      reviews: reviewList,
    );
  }
}

class Review {

  final String id;
  final double stars;
  final String comment;
  final String storename;

  Review({
    required this.id,
    required this.stars,
    required this.comment,
    required this.storename
   
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['_id'] ?? '',
      stars: json['stars'].toDouble() ?? 0.0 ,
      comment: json['comment']?.toString() ?? '',
      storename: json['storename']?.toString() ?? ''
    
    );
  }
}
