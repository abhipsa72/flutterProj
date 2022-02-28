// To parse this JSON data, do
//
//     final productReview = productReviewFromJson(jsonString);

ProductReviewResponse productReviewFromJson(dynamic str) =>
    ProductReviewResponse.fromJson(str);

class ProductReviewResponse {
  ProductReviewResponse({
    this.success,
  });

  Success success;

  factory ProductReviewResponse.fromJson(Map<String, dynamic> json) =>
      ProductReviewResponse(
        success:
            json["success"] == null ? null : Success.fromJson(json["success"]),
      );
}

class Success {
  Success({
    this.reviews,
  });

  List<Review> reviews;

  factory Success.fromJson(Map<String, dynamic> json) => Success(
        reviews: json["reviews"] == null
            ? []
            : List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
      );
}

class Review {
  Review({
    this.reviewId,
    this.name,
    this.author,
    this.rating,
    this.status,
    this.dateAdded,
    this.text,
  });

  String reviewId;
  String name;
  String text;
  String author;
  String rating;
  String status;
  DateTime dateAdded;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        reviewId: json["review_id"] == null ? null : json["review_id"],
        name: json["name"] == null ? null : json["name"],
        author: json["author"] == null ? null : json["author"],
        rating: json["rating"] == null ? null : json["rating"],
        text: json["text"] == null ? null : json["text"],
        status: json["status"] == null ? null : json["status"],
        dateAdded: json["date_added"] == null
            ? null
            : DateTime.parse(json["date_added"]),
      );
}
