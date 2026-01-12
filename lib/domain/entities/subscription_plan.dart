import 'package:gloss_bloom/domain/entities/vendor.dart';

class SubscriptionPlan {
  final String id;
  final String name;
  final VendorSubscriptionTier planType;
  final double price;
  final String currency;
  final int durationDays;
  final int productLimit;
  final int boostSlots;
  final bool verifiedBadge;
  final List<String> features;

  const SubscriptionPlan({
    required this.id,
    required this.name,
    required this.planType,
    required this.price,
    required this.currency,
    required this.durationDays,
    required this.productLimit,
    required this.boostSlots,
    this.verifiedBadge = false,
    this.features = const [],
  });

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlan(
      id: json['id'],
      name: json['name'],
      planType: VendorSubscriptionTier.values.byName(json['planType']),
      price: (json['price'] as num).toDouble(),
      currency: json['currency'],
      durationDays: json['durationDays'],
      productLimit: json['productLimit'],
      boostSlots: json['boostSlots'],
      verifiedBadge: json['verifiedBadge'] ?? false,
      features: List<String>.from(json['features'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'planType': planType.name,
      'price': price,
      'currency': currency,
      'durationDays': durationDays,
      'productLimit': productLimit,
      'boostSlots': boostSlots,
      'verifiedBadge': verifiedBadge,
      'features': features,
    };
  }
}