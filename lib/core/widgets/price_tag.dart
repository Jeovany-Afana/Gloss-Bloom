import 'package:flutter/material.dart';
import 'package:gloss_bloom/core/utils/formatters.dart';

class PriceTag extends StatelessWidget {
  final double price;
  final double? originalPrice;
  final TextStyle? style;
  final bool showCurrency;

  const PriceTag({
    super.key,
    required this.price,
    this.originalPrice,
    this.style,
    this.showCurrency = true,
  });

  @override
  Widget build(BuildContext context) {
    final hasDiscount = originalPrice != null && originalPrice! > price;
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          CurrencyFormatter.format(price),
          style: style ?? Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: hasDiscount ? Theme.of(context).colorScheme.error : null,
          ),
        ),
        if (hasDiscount) ...[
          const SizedBox(width: 8),
          Text(
            CurrencyFormatter.format(originalPrice!),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              decoration: TextDecoration.lineThrough,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
      ],
    );
  }
}

class PriceRange extends StatelessWidget {
  final double minPrice;
  final double maxPrice;
  final TextStyle? style;

  const PriceRange({
    super.key,
    required this.minPrice,
    required this.maxPrice,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    if (minPrice == maxPrice) {
      return PriceTag(price: minPrice, style: style);
    }

    return Text(
      '${CurrencyFormatter.format(minPrice)} - ${CurrencyFormatter.format(maxPrice)}',
      style: style ?? Theme.of(context).textTheme.titleMedium,
    );
  }
}