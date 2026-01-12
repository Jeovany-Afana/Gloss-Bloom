class Review {
  final String id;
  final String productId;
  final String userId;
  final String userName;
  final double rating;
  final String? comment;
  final List<String> images;
  final bool isVerified;
  final DateTime? createdAt;

  const Review({
    required this.id,
    required this.productId,
    required this.userId,
    required this.userName,
    required this.rating,
    this.comment,
    this.images = const [],
    this.isVerified = false,
    this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      productId: json['productId'],
      userId: json['userId'],
      userName: json['userName'],
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'],
      images: List<String>.from(json['images'] ?? []),
      isVerified: json['isVerified'] ?? false,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'userId': userId,
      'userName': userName,
      'rating': rating,
      'comment': comment,
      'images': images,
      'isVerified': isVerified,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}