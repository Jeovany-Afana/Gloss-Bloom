import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gloss_bloom/l10n/app_localizations.dart';
import 'package:gloss_bloom/app/router.dart';
import 'package:gloss_bloom/core/widgets/empty_state.dart';
import 'package:gloss_bloom/core/widgets/shimmer_loading.dart';
import 'package:gloss_bloom/features/home/widgets/search_bar.dart';
import 'package:gloss_bloom/features/home/widgets/category_chips.dart';
import 'package:gloss_bloom/features/home/widgets/sponsored_section.dart';
import 'package:gloss_bloom/features/home/widgets/product_section.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _currentNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: _currentNavIndex == 0 ? _buildHomeContent(l10n) : _buildOtherContent(l10n),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentNavIndex,
        onDestinationSelected: (index) {
          if (index == _currentNavIndex) return;
          
          setState(() {
            _currentNavIndex = index;
          });

          switch (index) {
            case 1:
              context.go(RouteNames.catalog);
              break;
            case 2:
              context.go(RouteNames.cart);
              break;
            case 3:
              context.go(RouteNames.profile);
              break;
          }
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: l10n.home,
          ),
          NavigationDestination(
            icon: const Icon(Icons.search_outlined),
            selectedIcon: const Icon(Icons.search),
            label: l10n.catalog,
          ),
          NavigationDestination(
            icon: const Icon(Icons.shopping_cart_outlined),
            selectedIcon: const Icon(Icons.shopping_cart),
            label: l10n.cart,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person),
            label: l10n.profile,
          ),
        ],
      ),
    );
  }

  Widget _buildHomeContent(AppLocalizations l10n) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Bar avec recherche
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: HomeSearchBar(
                      controller: _searchController,
                      onSearch: (query) {
                        context.go('${RouteNames.catalog}?search=$query');
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () => context.go(RouteNames.settings),
                    icon: const Icon(Icons.settings),
                  ),
                ],
              ),
            ),

            // Raccourcis catégories
            const CategoryChips(),
            const SizedBox(height: 24),

            // Section sponsorisée
            SponsoredSection(
              onProductTap: (productId) => context.go('${RouteNames.productDetail}/$productId'),
            ),
            const SizedBox(height: 24),

            // Tendances
            ProductSection(
              title: 'Tendances',
              onSeeAll: () => context.go('${RouteNames.catalog}?category=trending'),
              onProductTap: (productId) => context.go('${RouteNames.productDetail}/$productId'),
            ),
            const SizedBox(height: 24),

            // Nouveautés
            ProductSection(
              title: 'Nouveautés',
              onSeeAll: () => context.go('${RouteNames.catalog}?category=new'),
              onProductTap: (productId) => context.go('${RouteNames.productDetail}/$productId'),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildOtherContent(AppLocalizations l10n) {
    return const Center(
      child: Text('Navigation en cours...'),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}