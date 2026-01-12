import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gloss_bloom/l10n/app_localizations.dart';
import 'package:gloss_bloom/core/widgets/empty_state.dart';
import 'package:gloss_bloom/core/widgets/shimmer_loading.dart';
import 'package:gloss_bloom/core/constants/app_constants.dart';

class CatalogScreen extends ConsumerStatefulWidget {
  final String? searchQuery;
  final String? category;

  const CatalogScreen({
    super.key,
    this.searchQuery,
    this.category,
  });

  @override
  ConsumerState<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends ConsumerState<CatalogScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    if (widget.searchQuery != null) {
      _searchController.text = widget.searchQuery!;
    }
    _simulateLoad();
  }

  void _simulateLoad() async {
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.catalog),
        actions: [
          IconButton(
            onPressed: () => _showFilters(context),
            icon: const Icon(Icons.tune),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchBar(
              controller: _searchController,
              hintText: '${l10n.search} produits...',
              leading: const Icon(Icons.search),
              onSubmitted: (query) {
                // Handle search
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Recherche: $query')),
                );
              },
            ),
          ),

          // Active Filters (if any)
          if (widget.category != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Wrap(
                spacing: 8,
                children: [
                  Chip(
                    label: Text('Catégorie: ${widget.category}'),
                    onDeleted: () {
                      // Remove filter
                    },
                  ),
                ],
              ),
            ),

          // Products Grid
          Expanded(
            child: _isLoading
                ? _buildShimmerGrid()
                : AppConstants.demoMode 
                    ? _buildEmptyState(l10n)
                    : _buildEmptyState(l10n),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showSortOptions(context),
        icon: const Icon(Icons.sort),
        label: const Text('Trier'),
      ),
    );
  }

  Widget _buildShimmerGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: 8,
      itemBuilder: (context, index) => const ShimmerProductCard(),
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n) {
    return EmptyState(
      icon: Icons.search_off,
      title: l10n.noResults,
      subtitle: 'Aucun produit ne correspond à vos critères',
      action: ElevatedButton(
        onPressed: () {
          _searchController.clear();
          // Reset filters
        },
        child: Text(l10n.tryAgain),
      ),
    );
  }

  void _showFilters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const FilterBottomSheet(),
    );
  }

  void _showSortOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const SortBottomSheet(),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.9,
      minChildSize: 0.5,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: [
              Text(
                'Filtres',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              const Expanded(
                child: Center(
                  child: Text('Interface de filtres à implémenter'),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Réinitialiser'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FilledButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Appliquer'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class SortBottomSheet extends StatelessWidget {
  const SortBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final sortOptions = [
      'Pertinence',
      'Prix croissant',
      'Prix décroissant',
      'Nouveautés',
      'Mieux notés',
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Trier par',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          ...sortOptions.map(
            (option) => ListTile(
              title: Text(option),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Tri par: $option')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}