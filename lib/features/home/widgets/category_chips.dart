import 'package:flutter/material.dart';

class CategoryChips extends StatelessWidget {
  const CategoryChips({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      CategoryChip(icon: Icons.brush, label: 'Finition', category: 'finish'),
      CategoryChip(icon: Icons.palette, label: 'Teintes', category: 'colors'),
      CategoryChip(icon: Icons.business, label: 'Marques', category: 'brands'),
      CategoryChip(icon: Icons.local_fire_department, label: 'Tendance', category: 'trending'),
    ];

    return SizedBox(
      height: 100,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () => _onCategoryTap(context, category.category),
            child: SizedBox(
              width: 70,
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      category.icon,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category.label,
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onCategoryTap(BuildContext context, String category) {
    // Navigate to catalog with category filter
    // context.go('${RouteNames.catalog}?category=$category');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Navigation vers catégorie: $category')),
    );
  }
}

class CategoryChip {
  final IconData icon;
  final String label;
  final String category;

  const CategoryChip({
    required this.icon,
    required this.label,
    required this.category,
  });
}