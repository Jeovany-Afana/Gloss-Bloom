import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gloss_bloom/l10n/app_localizations.dart';
import 'package:gloss_bloom/core/widgets/empty_state.dart';
import 'package:gloss_bloom/domain/entities/order.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.orders),
      ),
      body: EmptyState(
        icon: Icons.shopping_bag_outlined,
        title: 'Aucune commande',
        subtitle: 'Vos commandes apparaîtront ici une fois que vous aurez effectué des achats',
        action: FilledButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Découvrir les produits'),
        ),
      ),
    );
  }
}

class OrderStatusTimeline extends StatelessWidget {
  final OrderStatus currentStatus;
  final List<OrderStatusUpdate> timeline;

  const OrderStatusTimeline({
    super.key,
    required this.currentStatus,
    required this.timeline,
  });

  @override
  Widget build(BuildContext context) {
    final statuses = [
      OrderStatus.placed,
      OrderStatus.confirmed,
      OrderStatus.shipped,
      OrderStatus.delivered,
    ];

    return Column(
      children: statuses.map((status) {
        final isCompleted = _isStatusCompleted(status);
        final isCurrent = currentStatus == status;
        
        return Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted || isCurrent 
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.surfaceContainerHighest,
              ),
              child: Icon(
                isCompleted ? Icons.check : Icons.circle,
                size: 12,
                color: isCompleted || isCurrent 
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _getStatusLabel(status),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: isCurrent ? FontWeight.bold : null,
                  color: isCompleted || isCurrent 
                    ? null 
                    : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  bool _isStatusCompleted(OrderStatus status) {
    final currentIndex = _getStatusIndex(currentStatus);
    final statusIndex = _getStatusIndex(status);
    return statusIndex < currentIndex;
  }

  int _getStatusIndex(OrderStatus status) {
    switch (status) {
      case OrderStatus.placed: return 0;
      case OrderStatus.confirmed: return 1;
      case OrderStatus.shipped: return 2;
      case OrderStatus.delivered: return 3;
      default: return -1;
    }
  }

  String _getStatusLabel(OrderStatus status) {
    switch (status) {
      case OrderStatus.placed: return 'Commande passée';
      case OrderStatus.confirmed: return 'Confirmée';
      case OrderStatus.shipped: return 'Expédiée';
      case OrderStatus.delivered: return 'Livrée';
      default: return status.toString();
    }
  }
}