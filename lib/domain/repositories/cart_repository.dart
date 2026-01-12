import 'package:gloss_bloom/domain/entities/cart_item.dart';

abstract class CartRepository {
  Stream<List<CartItem>> watchCart();
  Future<List<CartItem>> getCartItems();
  Future<void> addToCart(CartItem item);
  Future<void> updateQuantity(String productId, String variantId, int quantity);
  Future<void> removeFromCart(String productId, String variantId);
  Future<void> clearCart();
  Future<int> getCartItemCount();
}