import 'package:gloss_bloom/domain/entities/cart_item_simple.dart';

enum OrderStatus {
  draft,
  placed,
  confirmed,
  shipped,
  delivered,
  cancelled,
}

class OrderStatusUpdate {
  final OrderStatus status;
  final DateTime timestamp;
  final String? note;

  const OrderStatusUpdate({
    required this.status,
    required this.timestamp,
    this.note,
  });
}

class Order {
  final String id;
  final String userId;
  final List<CartItem> items;
  final double total;
  final String currency;
  final OrderStatus status;
  final dynamic deliveryInfo;
  final dynamic paymentInfo;
  final List<OrderStatusUpdate> statusTimeline;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.total,
    required this.currency,
    required this.status,
    this.deliveryInfo,
    this.paymentInfo,
    this.statusTimeline = const [],
    this.createdAt,
    this.updatedAt,
  });

  Order copyWith({
    String? id,
    String? userId,
    List<CartItem>? items,
    double? total,
    String? currency,
    OrderStatus? status,
    dynamic deliveryInfo,
    dynamic paymentInfo,
    List<OrderStatusUpdate>? statusTimeline,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Order(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      items: items ?? this.items,
      total: total ?? this.total,
      currency: currency ?? this.currency,
      status: status ?? this.status,
      deliveryInfo: deliveryInfo ?? this.deliveryInfo,
      paymentInfo: paymentInfo ?? this.paymentInfo,
      statusTimeline: statusTimeline ?? this.statusTimeline,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}