enum VendorType {
  professional,
  individual,
}

enum SubscriptionPlanType {
  starter,
  pro,
  elite,
}

class Vendor {
  final String id;
  final String userId;
  final String name;
  final String city;
  final VendorType type;
  final double rating;
  final int reviewCount;
  final bool isVerified;
  final String? description;
  final String? instagramHandle;
  final String? whatsappNumber;
  final String? profileImageUrl;
  final SubscriptionPlanType subscriptionPlan;
  final DateTime? subscriptionExpiresAt;
  final DateTime? createdAt;

  const Vendor({
    required this.id,
    required this.userId,
    required this.name,
    required this.city,
    required this.type,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.isVerified = false,
    this.description,
    this.instagramHandle,
    this.whatsappNumber,
    this.profileImageUrl,
    this.subscriptionPlan = SubscriptionPlanType.starter,
    this.subscriptionExpiresAt,
    this.createdAt,
  });
}