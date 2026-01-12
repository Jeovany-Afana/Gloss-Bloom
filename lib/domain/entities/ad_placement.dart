enum PlacementType {
  homeHero,
  homeTrending,
  categoryBanner,
}

enum AdStatus {
  scheduled,
  active,
  expired,
  cancelled,
}

class AdPlacement {
  final String id;
  final String vendorId;
  final PlacementType placementType;
  final List<String> productIds;
  final DateTime startDate;
  final DateTime endDate;
  final double cost;
  final String currency;
  final AdStatus status;
  final DateTime? createdAt;

  const AdPlacement({
    required this.id,
    required this.vendorId,
    required this.placementType,
    required this.productIds,
    required this.startDate,
    required this.endDate,
    required this.cost,
    required this.currency,
    this.status = AdStatus.scheduled,
    this.createdAt,
  });

  factory AdPlacement.fromJson(Map<String, dynamic> json) {
    return AdPlacement(
      id: json['id'],
      vendorId: json['vendorId'],
      placementType: PlacementType.values.byName(json['placementType']),
      productIds: List<String>.from(json['productIds']),
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      cost: (json['cost'] as num).toDouble(),
      currency: json['currency'],
      status: AdStatus.values.byName(json['status'] ?? 'scheduled'),
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vendorId': vendorId,
      'placementType': placementType.name,
      'productIds': productIds,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'cost': cost,
      'currency': currency,
      'status': status.name,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}