import 'package:gloss_bloom/domain/entities/cart_item.dart';
import 'package:gloss_bloom/domain/entities/delivery_info.dart';
import 'package:gloss_bloom/domain/entities/payment_info.dart';

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

  factory OrderStatusUpdate.fromJson(Map<String, dynamic> json) {
    return OrderStatusUpdate(
      status: OrderStatus.values.byName(json['status']),
      timestamp: DateTime.parse(json['timestamp']),
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status.name,
      'timestamp': timestamp.toIso8601String(),
      'note': note,
    };
  }
}

class Order {
  final String id;
  final String userId;
  final List<CartItem> items;
  final double total;
  final String currency;
  final OrderStatus status;
  final DeliveryInfo? deliveryInfo;
  final PaymentInfo? paymentInfo;
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
    DeliveryInfo? deliveryInfo,
    PaymentInfo? paymentInfo,
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

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      userId: json['userId'],
      items: (json['items'] as List).map((item) => CartItem.fromJson(item)).toList(),
      total: (json['total'] as num).toDouble(),
      currency: json['currency'],
      status: OrderStatus.values.byName(json['status']),
      deliveryInfo: json['deliveryInfo'] != null ? DeliveryInfo.fromJson(json['deliveryInfo']) : null,
      paymentInfo: json['paymentInfo'] != null ? PaymentInfo.fromJson(json['paymentInfo']) : null,
      statusTimeline: (json['statusTimeline'] as List? ?? [])
        .map((update) => OrderStatusUpdate.fromJson(update)).toList(),
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'items': items.map((item) => item.toJson()).toList(),
      'total': total,
      'currency': currency,
      'status': status.name,
      'deliveryInfo': deliveryInfo?.toJson(),
      'paymentInfo': paymentInfo?.toJson(),
      'statusTimeline': statusTimeline.map((update) => update.toJson()).toList(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}