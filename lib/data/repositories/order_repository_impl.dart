import 'package:gloss_bloom/domain/entities/order.dart';
import 'package:gloss_bloom/domain/entities/cart_item.dart';
import 'package:gloss_bloom/domain/entities/delivery_info.dart';
import 'package:gloss_bloom/domain/entities/payment_info.dart';
import 'package:gloss_bloom/domain/repositories/order_repository.dart';
import 'package:gloss_bloom/core/constants/app_constants.dart';

class OrderRepositoryImpl implements OrderRepository {
  final List<Order> _orders = [];

  @override
  Future<Order> createOrder(List<CartItem> items) async {
    await Future.delayed(const Duration(seconds: 1));
    
    final total = items.fold<double>(0.0, (sum, item) => sum + item.totalPrice);
    final order = Order(
      id: 'order_${DateTime.now().millisecondsSinceEpoch}',
      userId: 'current_user_id',
      items: items,
      total: total,
      currency: AppConstants.currencyCode,
      status: OrderStatus.draft,
      createdAt: DateTime.now(),
    );
    
    _orders.add(order);
    return order;
  }

  @override
  Future<Order> updateOrder(String orderId, {
    DeliveryInfo? deliveryInfo,
    PaymentInfo? paymentInfo,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    
    final index = _orders.indexWhere((order) => order.id == orderId);
    if (index >= 0) {
      _orders[index] = _orders[index].copyWith(
        deliveryInfo: deliveryInfo ?? _orders[index].deliveryInfo,
        paymentInfo: paymentInfo ?? _orders[index].paymentInfo,
        updatedAt: DateTime.now(),
      );
      return _orders[index];
    }
    
    throw Exception('Order not found');
  }

  @override
  Future<void> confirmOrder(String orderId) async {
    await Future.delayed(const Duration(seconds: 1));
    
    final index = _orders.indexWhere((order) => order.id == orderId);
    if (index >= 0) {
      final now = DateTime.now();
      _orders[index] = _orders[index].copyWith(
        status: OrderStatus.placed,
        statusTimeline: [
          ..._orders[index].statusTimeline,
          OrderStatusUpdate(
            status: OrderStatus.placed,
            timestamp: now,
            note: 'Commande confirmée',
          ),
        ],
        updatedAt: now,
      );
    }
  }

  @override
  Future<void> updateOrderStatus(String orderId, OrderStatus status, {String? note}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    final index = _orders.indexWhere((order) => order.id == orderId);
    if (index >= 0) {
      final now = DateTime.now();
      _orders[index] = _orders[index].copyWith(
        status: status,
        statusTimeline: [
          ..._orders[index].statusTimeline,
          OrderStatusUpdate(
            status: status,
            timestamp: now,
            note: note,
          ),
        ],
        updatedAt: now,
      );
    }
  }

  @override
  Future<List<Order>> getUserOrders(String userId) async {
    await Future.delayed(const Duration(seconds: 1));
    return _orders.where((order) => order.userId == userId).toList();
  }

  @override
  Future<List<Order>> getVendorOrders(String vendorId) async {
    await Future.delayed(const Duration(seconds: 1));
    // Filter orders that contain products from this vendor
    return _orders.where((order) => 
      order.items.any((item) => item.vendorName == vendorId)
    ).toList();
  }

  @override
  Future<Order?> getOrderById(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      return _orders.firstWhere((order) => order.id == id);
    } catch (e) {
      return null;
    }
  }
}