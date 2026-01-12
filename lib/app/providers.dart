import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gloss_bloom/domain/repositories/auth_repository.dart';
import 'package:gloss_bloom/domain/repositories/catalog_repository.dart';
import 'package:gloss_bloom/domain/repositories/cart_repository.dart';
import 'package:gloss_bloom/domain/repositories/order_repository.dart';
import 'package:gloss_bloom/domain/repositories/review_repository.dart';
import 'package:gloss_bloom/domain/repositories/payment_repository.dart';
import 'package:gloss_bloom/domain/repositories/delivery_repository.dart';
import 'package:gloss_bloom/domain/repositories/subscription_repository.dart';
import 'package:gloss_bloom/domain/repositories/ads_repository.dart';

import 'package:gloss_bloom/data/repositories/auth_repository_impl.dart';
import 'package:gloss_bloom/data/repositories/catalog_repository_impl.dart';
import 'package:gloss_bloom/data/repositories/cart_repository_impl.dart';
import 'package:gloss_bloom/data/repositories/order_repository_impl.dart';

// Repository Providers
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl();
});

final catalogRepositoryProvider = Provider<CatalogRepository>((ref) {
  return CatalogRepositoryImpl();
});

final cartRepositoryProvider = Provider<CartRepository>((ref) {
  return CartRepositoryImpl();
});

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  return OrderRepositoryImpl();
});

// Current user provider
final currentUserProvider = StreamProvider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.currentUserStream;
});

// Cart provider
final cartItemsProvider = StreamProvider((ref) {
  final cartRepository = ref.watch(cartRepositoryProvider);
  return cartRepository.watchCart();
});

final cartItemCountProvider = FutureProvider<int>((ref) async {
  final cartRepository = ref.watch(cartRepositoryProvider);
  return await cartRepository.getCartItemCount();
});

// Products providers
final featuredProductsProvider = FutureProvider((ref) async {
  final catalogRepository = ref.watch(catalogRepositoryProvider);
  return await catalogRepository.getSponsoredProducts();
});

final trendingProductsProvider = FutureProvider((ref) async {
  final catalogRepository = ref.watch(catalogRepositoryProvider);
  return await catalogRepository.getTrendingProducts();
});

final newProductsProvider = FutureProvider((ref) async {
  final catalogRepository = ref.watch(catalogRepositoryProvider);
  return await catalogRepository.getNewProducts();
});