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
}