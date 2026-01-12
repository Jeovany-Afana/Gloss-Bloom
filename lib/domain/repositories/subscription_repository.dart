import 'package:gloss_bloom/domain/entities/subscription_plan.dart';
import 'package:gloss_bloom/domain/entities/vendor.dart';

class VendorSubscription {
  final String id;
  final String vendorId;
  final SubscriptionPlan plan;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;
  final DateTime? cancelledAt;

  const VendorSubscription({
    required this.id,
    required this.vendorId,
    required this.plan,
    required this.startDate,
    required this.endDate,
    required this.isActive,
    this.cancelledAt,
  });
}

abstract class SubscriptionRepository {
  Future<List<SubscriptionPlan>> getAvailablePlans();
  Future<VendorSubscription?> getVendorSubscription(String vendorId);
  Future<VendorSubscription> subscribe(String vendorId, SubscriptionPlan plan);
  Future<void> cancelSubscription(String subscriptionId);
  Future<VendorSubscription> renewSubscription(String subscriptionId);
  Future<bool> canVendorPerformAction(String vendorId, String action);
}