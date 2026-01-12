import 'package:gloss_bloom/domain/entities/ad_placement.dart';
import 'package:gloss_bloom/domain/entities/product.dart';

class AdSlot {
  final PlacementType type;
  final String name;
  final String description;
  final double baseCost;
  final int maxProducts;
  final bool isAvailable;

  const AdSlot({
    required this.type,
    required this.name,
    required this.description,
    required this.baseCost,
    required this.maxProducts,
    required this.isAvailable,
  });
}

abstract class AdsRepository {
  Future<List<Product>> getFeaturedProducts(PlacementType placementType);
  Future<List<AdSlot>> getAvailableSlots();
  Future<AdPlacement> purchaseSlot({
    required String vendorId,
    required PlacementType placementType,
    required List<String> productIds,
    required DateTime startDate,
    required DateTime endDate,
  });
  Future<List<AdPlacement>> getVendorPlacements(String vendorId);
  Future<void> cancelPlacement(String placementId);
  Future<void> updatePlacement(String placementId, {
    List<String>? productIds,
    DateTime? endDate,
  });
}