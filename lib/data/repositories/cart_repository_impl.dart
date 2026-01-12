import 'dart:async';
import 'package:gloss_bloom/domain/entities/cart_item.dart';
import 'package:gloss_bloom/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final List<CartItem> _cartItems = [];
  final StreamController<List<CartItem>> _cartController = StreamController<List<CartItem>>.broadcast();

  @override
  Stream<List<CartItem>> watchCart() {
    return _cartController.stream;
  }

  @override
  Future<List<CartItem>> getCartItems() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_cartItems);
  }

  @override
  Future<void> addToCart(CartItem item) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    final existingIndex = _cartItems.indexWhere(
      (cartItem) => cartItem.productId == item.productId && cartItem.variantId == item.variantId,
    );

    if (existingIndex >= 0) {
      _cartItems[existingIndex] = _cartItems[existingIndex].copyWith(
        quantity: _cartItems[existingIndex].quantity + item.quantity,
      );
    } else {
      _cartItems.add(item);
    }

    _cartController.add(List.from(_cartItems));
  }

  @override
  Future<void> updateQuantity(String productId, String variantId, int quantity) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final index = _cartItems.indexWhere(
      (item) => item.productId == productId && item.variantId == variantId,
    );

    if (index >= 0) {
      if (quantity <= 0) {
        _cartItems.removeAt(index);
      } else {
        _cartItems[index] = _cartItems[index].copyWith(quantity: quantity);
      }
      _cartController.add(List.from(_cartItems));
    }
  }

  @override
  Future<void> removeFromCart(String productId, String variantId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    _cartItems.removeWhere(
      (item) => item.productId == productId && item.variantId == variantId,
    );
    _cartController.add(List.from(_cartItems));
  }

  @override
  Future<void> clearCart() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _cartItems.clear();
    _cartController.add([]);
  }

  @override
  Future<int> getCartItemCount() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _cartItems.fold<int>(0, (sum, item) => sum + item.quantity);
  }
}