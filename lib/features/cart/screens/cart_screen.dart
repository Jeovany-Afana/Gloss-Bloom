import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gloss_bloom/l10n/app_localizations.dart';
import 'package:gloss_bloom/app/router.dart';
import 'package:gloss_bloom/core/widgets/empty_state.dart';
import 'package:gloss_bloom/core/widgets/price_tag.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.cart),
        actions: [
          TextButton(
            onPressed: () => _clearCart(context),
            child: const Text('Vider'),
          ),
        ],
      ),
      body: _buildCartContent(context, l10n),
      bottomNavigationBar: _buildCheckoutBar(context, l10n),
    );
  }

  Widget _buildCartContent(BuildContext context, AppLocalizations l10n) {
    // Demo: empty cart
    return EmptyState(
      icon: Icons.shopping_cart_outlined,
      title: l10n.cartEmpty,
      subtitle: 'Ajoutez des produits à votre panier pour les voir ici',
      action: FilledButton(
        onPressed: () => context.go(RouteNames.catalog),
        child: const Text('Découvrir les produits'),
      ),
    );
  }

  Widget _buildCheckoutBar(BuildContext context, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.cartTotal,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const PriceTag(price: 0),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => context.go(RouteNames.checkout),
              child: Text(l10n.checkout),
            ),
          ),
        ],
      ),
    );
  }

  void _clearCart(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Panier vidé')),
    );
  }
}