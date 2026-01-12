import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gloss_bloom/app/app.dart';
import 'package:gloss_bloom/core/widgets/empty_state.dart';
import 'package:gloss_bloom/core/widgets/rating_stars.dart';
import 'package:gloss_bloom/features/orders/screens/orders_screen.dart';
import 'package:gloss_bloom/domain/entities/order.dart';

void main() {
  group('Gloss Market Widget Tests', () {
    testWidgets('EmptyState displays correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EmptyState(
              icon: Icons.shopping_cart,
              title: 'Test Empty State',
              subtitle: 'Test subtitle',
            ),
          ),
        ),
      );

      expect(find.text('Test Empty State'), findsOneWidget);
      expect(find.text('Test subtitle'), findsOneWidget);
      expect(find.byIcon(Icons.shopping_cart), findsOneWidget);
    });

    testWidgets('RatingStars shows correct rating', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: RatingStars(
              rating: 4.5,
              showRatingText: true,
            ),
          ),
        ),
      );

      expect(find.text('4.5'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsNWidgets(4));
      expect(find.byIcon(Icons.star_half), findsOneWidget);
    });

    testWidgets('OrderStatusTimeline shows 4 steps', (WidgetTester tester) async {
      final timeline = [
        OrderStatusUpdate(
          status: OrderStatus.placed,
          timestamp: DateTime.now(),
          note: 'Commande passée',
        ),
        OrderStatusUpdate(
          status: OrderStatus.confirmed,
          timestamp: DateTime.now(),
          note: 'Commande confirmée',
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OrderStatusTimeline(
              currentStatus: OrderStatus.confirmed,
              timeline: timeline,
            ),
          ),
        ),
      );

      expect(find.text('Commande passée'), findsOneWidget);
      expect(find.text('Confirmée'), findsOneWidget);
      expect(find.text('Expédiée'), findsOneWidget);
      expect(find.text('Livrée'), findsOneWidget);
    });

    testWidgets('App loads without crashing', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: GlossMarketApp(),
        ),
      );

      // Wait for app to settle
      await tester.pumpAndSettle();

      // Should show onboarding screen
      expect(find.textContaining('Marketplace dédiée aux gloss'), findsOneWidget);
    });
  });
}