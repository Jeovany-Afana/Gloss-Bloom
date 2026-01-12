enum VendorType {
  professional,
  individual,
}

enum VendorSubscriptionTier {
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
  final VendorSubscriptionTier subscriptionPlan;
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
    this.subscriptionPlan = VendorSubscriptionTier.starter,
    this.subscriptionExpiresAt,
    this.createdAt,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      city: json['city'],
      type: VendorType.values.byName(json['type']),
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: json['reviewCount'] ?? 0,
      isVerified: json['isVerified'] ?? false,
      description: json['description'],
      instagramHandle: json['instagramHandle'],
      whatsappNumber: json['whatsappNumber'],
      profileImageUrl: json['profileImageUrl'],
      subscriptionPlan: VendorSubscriptionTier.values.byName(json['subscriptionPlan'] ?? 'starter'),
      subscriptionExpiresAt: json['subscriptionExpiresAt'] != null 
        ? DateTime.parse(json['subscriptionExpiresAt']) 
        : null,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'city': city,
      'type': type.name,
      'rating': rating,
      'reviewCount': reviewCount,
      'isVerified': isVerified,
      'description': description,
      'instagramHandle': instagramHandle,
      'whatsappNumber': whatsappNumber,
      'profileImageUrl': profileImageUrl,
      'subscriptionPlan': subscriptionPlan.name,
      'subscriptionExpiresAt': subscriptionExpiresAt?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}