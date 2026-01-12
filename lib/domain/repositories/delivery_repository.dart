import 'package:gloss_bloom/domain/entities/delivery_info.dart';

enum TrackingStep {
  orderProcessed,
  inTransit,
  outForDelivery,
  delivered,
}

class TrackingInfo {
  final String trackingCode;
  final List<TrackingUpdate> updates;
  final TrackingStep currentStep;
  final DateTime? estimatedDelivery;

  const TrackingInfo({
    required this.trackingCode,
    required this.updates,
    required this.currentStep,
    this.estimatedDelivery,
  });
}

class TrackingUpdate {
  final TrackingStep step;
  final DateTime timestamp;
  final String? location;
  final String? note;

  const TrackingUpdate({
    required this.step,
    required this.timestamp,
    this.location,
    this.note,
  });
}

class DeliveryQuote {
  final DeliveryProvider provider;
  final double cost;
  final int estimatedDays;
  final String description;

  const DeliveryQuote({
    required this.provider,
    required this.cost,
    required this.estimatedDays,
    required this.description,
  });
}

abstract class DeliveryRepository {
  Future<List<DeliveryProvider>> getAvailableProviders();
  Future<List<DeliveryQuote>> getDeliveryQuotes(String city, double weight);
  Future<TrackingInfo?> trackPackage(String trackingCode);
  Future<String> createShipment(DeliveryInfo deliveryInfo);
}