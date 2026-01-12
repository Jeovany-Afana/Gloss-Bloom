import 'package:gloss_bloom/domain/entities/review.dart';

enum ReviewSortBy {
  newest,
  oldest,
  highestRating,
  lowestRating,
}

abstract class ReviewRepository {
  Future<List<Review>> getProductReviews(
    String productId, {
    ReviewSortBy sortBy = ReviewSortBy.newest,
    int page = 0,
    int pageSize = 20,
  });
  
  Future<void> addReview(Review review);
  
  Future<void> updateReview(String reviewId, {
    double? rating,
    String? comment,
    List<String>? images,
  });
  
  Future<void> deleteReview(String reviewId);
  
  Future<void> flagReview(String reviewId, String reason);
  
  Future<bool> hasUserReviewedProduct(String userId, String productId);
}