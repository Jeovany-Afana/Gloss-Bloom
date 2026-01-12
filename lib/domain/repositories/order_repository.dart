import 'package:gloss_bloom/domain/entities/order.dart';
import 'package:gloss_bloom/domain/entities/cart_item.dart';
import 'package:gloss_bloom/domain/entities/delivery_info.dart';
import 'package:gloss_bloom/domain/entities/payment_info.dart';

abstract class OrderRepository {
  Future<Order> createOrder(List<CartItem> items);
  Future<Order> updateOrder(String orderId, {
    DeliveryInfo? deliveryInfo,
    PaymentInfo? paymentInfo,
  });
  Future<void> confirmOrder(String orderId);
  Future<void> updateOrderStatus(String orderId, OrderStatus status, {String? note});
  Future<List<Order>> getUserOrders(String userId);
  Future<List<Order>> getVendorOrders(String vendorId);
  Future<Order?> getOrderById(String id);
}