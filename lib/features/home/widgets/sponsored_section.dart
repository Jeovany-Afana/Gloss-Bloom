import 'package:flutter/material.dart';
import 'package:gloss_bloom/core/widgets/empty_state.dart';
import 'package:gloss_bloom/core/widgets/shimmer_loading.dart';
import 'package:gloss_bloom/core/constants/app_constants.dart';

class SponsoredSection extends StatelessWidget {
  final ValueChanged<String> onProductTap;

  const SponsoredSection({
    super.key,
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
            children: [
              Icon(
                Icons.star,
                color: Theme.of(context).colorScheme.tertiary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Mise en avant',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: AppConstants.demoMode 
            ? _buildDemoContent(context)
            : _buildEmptyState(context),
        ),
      ],
    );
  }

  Widget _buildDemoContent(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      separatorBuilder: (context, index) => const SizedBox(width: 12),
      itemBuilder: (context, index) => _buildSponsoredCard(context, index),
    );
  }

  Widget _buildSponsoredCard(BuildContext context, int index) {
    return GestureDetector(
      onTap: () => onProductTap('sponsored_$index'),
      child: SizedBox(
        width: 160,
        child: Card(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainerHighest,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                      ),
                      child: Icon(
                        Icons.image,
                        size: 48,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Produit Sponsorisé ${index + 1}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '0 FCFA',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Sponsorisé',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onTertiary,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return const Center(
      child: EmptyState(
        icon: Icons.star_border,
        title: 'Aucune promotion',
        subtitle: 'Aucun produit sponsorisé disponible pour le moment',
      ),
    );
  }
}