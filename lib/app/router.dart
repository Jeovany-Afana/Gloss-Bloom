import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gloss_bloom/features/onboarding/screens/onboarding_screen.dart';
import 'package:gloss_bloom/features/auth/screens/auth_screen.dart';
import 'package:gloss_bloom/features/home/screens/home_screen.dart';
import 'package:gloss_bloom/features/catalog/screens/catalog_screen.dart';
import 'package:gloss_bloom/features/product/screens/product_detail_screen.dart';
import 'package:gloss_bloom/features/cart/screens/cart_screen.dart';
import 'package:gloss_bloom/features/checkout/screens/checkout_screen.dart';
import 'package:gloss_bloom/features/orders/screens/orders_screen.dart';
import 'package:gloss_bloom/features/profile/screens/profile_screen.dart';
import 'package:gloss_bloom/features/settings/screens/settings_screen.dart';

// Route names
class RouteNames {
  static const String onboarding = '/onboarding';
  static const String auth = '/auth';
  static const String home = '/';
  static const String catalog = '/catalog';
  static const String productDetail = '/product';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String orders = '/orders';
  static const String profile = '/profile';
  static const String settings = '/settings';
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RouteNames.onboarding,
    routes: [
      GoRoute(
        path: RouteNames.onboarding,
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: RouteNames.auth,
        name: 'auth',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: RouteNames.home,
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: RouteNames.catalog,
        name: 'catalog',
        builder: (context, state) => CatalogScreen(
          searchQuery: state.uri.queryParameters['search'],
          category: state.uri.queryParameters['category'],
        ),
      ),
      GoRoute(
        path: '${RouteNames.productDetail}/:id',
        name: 'productDetail',
        builder: (context, state) => ProductDetailScreen(
          productId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: RouteNames.cart,
        name: 'cart',
        builder: (context, state) => const CartScreen(),
      ),
      GoRoute(
        path: RouteNames.checkout,
        name: 'checkout',
        builder: (context, state) => const CheckoutScreen(),
      ),
      GoRoute(
        path: RouteNames.orders,
        name: 'orders',
        builder: (context, state) => const OrdersScreen(),
      ),
      GoRoute(
        path: RouteNames.profile,
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: RouteNames.settings,
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
});