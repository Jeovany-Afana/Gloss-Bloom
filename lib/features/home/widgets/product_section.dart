import 'package:flutter/material.dart';
import 'package:gloss_bloom/core/widgets/empty_state.dart';
import 'package:gloss_bloom/core/widgets/shimmer_loading.dart';
import 'package:gloss_bloom/core/constants/app_constants.dart';

class ProductSection extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAll;
  final ValueChanged<String> onProductTap;

  const ProductSection({
    super.key,
    required this.title,
    required this.onSeeAll,
    required this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: onSeeAll,
                child: const Text('Voir tout'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 240,
          child: AppConstants.demoMode 
            ? _buildShimmerContent()
            : _buildEmptyContent(),
        ),
      ],
    );
  }

  Widget _buildShimmerContent() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      scrollDirection: Axis.horizontal,
      itemCount: 4,
      separatorBuilder: (context, index) => const SizedBox(width: 12),
      itemBuilder: (context, index) => const SizedBox(
        width: 160,
        child: ShimmerProductCard(),
      ),
    );
  }

  Widget _buildEmptyContent() {
    return const Center(
      child: EmptyState(
        icon: Icons.shopping_bag_outlined,
        title: 'Aucun produit',
        subtitle: 'Aucun produit disponible dans cette section',
      ),
    );
  }
}