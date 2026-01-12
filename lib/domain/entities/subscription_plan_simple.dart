class SubscriptionPlan {
  final String id;
  final String name;
  final String planType;
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
}