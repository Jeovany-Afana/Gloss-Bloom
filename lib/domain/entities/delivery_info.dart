enum DeliveryProvider {
  yobantel,
  colisExpress,
  pickup,
}

class DeliveryInfo {
  final DeliveryProvider provider;
  final String address;
  final String city;
  final String? trackingCode;
  final double? cost;
  final DateTime? estimatedDeliveryDate;

  const DeliveryInfo({
    required this.provider,
    required this.address,
    required this.city,
    this.trackingCode,
    this.cost,
    this.estimatedDeliveryDate,
  });

  factory DeliveryInfo.fromJson(Map<String, dynamic> json) {
    return DeliveryInfo(
      provider: DeliveryProvider.values.byName(json['provider']),
      address: json['address'],
      city: json['city'],
      trackingCode: json['trackingCode'],
      cost: json['cost']?.toDouble(),
      estimatedDeliveryDate: json['estimatedDeliveryDate'] != null 
        ? DateTime.parse(json['estimatedDeliveryDate']) 
        : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'provider': provider.name,
      'address': address,
      'city': city,
      'trackingCode': trackingCode,
      'cost': cost,
      'estimatedDeliveryDate': estimatedDeliveryDate?.toIso8601String(),
    };
  }
}