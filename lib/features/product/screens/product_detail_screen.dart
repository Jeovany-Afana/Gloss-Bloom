import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gloss_bloom/l10n/app_localizations.dart';
import 'package:gloss_bloom/core/widgets/rating_stars.dart';
import 'package:gloss_bloom/core/widgets/color_swatch.dart';
import 'package:gloss_bloom/core/widgets/price_tag.dart';
import 'package:gloss_bloom/core/utils/url_launcher_helper.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final String productId;

  const ProductDetailScreen({
    super.key,
    required this.productId,
  });

  @override
  ConsumerState<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedVariantIndex = 0;
  int _quantity = 1;

  // Demo variant colors
  final List<MapEntry<String, Color>> _variants = [
    const MapEntry('Rouge Passion', Color(0xFFDC143C)),
    const MapEntry('Rose Nude', Color(0xFFD4A574)),
    const MapEntry('Corail Vibrant', Color(0xFFFF7F50)),
    const MapEntry('Bordeaux Intense', Color(0xFF8B0000)),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: Icon(
                  Icons.image,
                  size: 80,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () => _showShareOptions(),
                icon: const Icon(Icons.share),
              ),
              IconButton(
                onPressed: () => _addToFavorites(),
                icon: const Icon(Icons.favorite_border),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Title & Rating
                  Text(
                    'Gloss Démo ${widget.productId}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const RatingStars(rating: 4.5, showRatingText: true),
                      const SizedBox(width: 8),
                      Text(
                        '(234 avis)',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Price
                  const PriceTag(
                    price: 0,
                    originalPrice: 0,
                  ),
                  const SizedBox(height: 16),

                  // Availability
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        l10n.inStock,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Variants
                  Text(
                    'Variantes disponibles',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  ColorSwatchList(
                    colors: _variants,
                    selectedColorName: _variants[_selectedVariantIndex].key,
                    onColorSelected: (colorName) {
                      final index = _variants.indexWhere((variant) => variant.key == colorName);
                      if (index >= 0) {
                        setState(() {
                          _selectedVariantIndex = index;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 24),

                  // Quantity
                  Row(
                    children: [
                      Text(
                        '${l10n.quantity}: ',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      IconButton(
                        onPressed: _quantity > 1 ? () => setState(() => _quantity--) : null,
                        icon: const Icon(Icons.remove),
                      ),
                      Text(
                        '$_quantity',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      IconButton(
                        onPressed: () => setState(() => _quantity++),
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Vendor Info
                  Card(
                    child: ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.store),
                      ),
                      title: const Text('Boutique Demo'),
                      subtitle: Row(
                        children: [
                          const RatingStars(rating: 4.8, size: 14),
                          const SizedBox(width: 8),
                          Text('Vérifiée', style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                      trailing: IconButton(
                        onPressed: () => _contactVendor(),
                        icon: const Icon(Icons.phone),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Tabs for Description & Reviews
                  TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'Description'),
                      Tab(text: 'Avis'),
                    ],
                  ),
                  SizedBox(
                    height: 300,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildDescriptionTab(),
                        _buildReviewsTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
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
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => _buyNow(),
                child: const Text('Acheter maintenant'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton.icon(
                onPressed: () => _addToCart(),
                icon: const Icon(Icons.shopping_cart),
                label: Text(l10n.addToCart),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionTab() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        'Description du produit non disponible en mode démo. '
        'Cette section contiendra les détails du gloss, sa composition, '
        'ses propriétés et ses conseils d\'utilisation.',
        style: TextStyle(height: 1.5),
      ),
    );
  }

  Widget _buildReviewsTab() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Text(
          'Les avis clients seront affichés ici une fois '
          'connecté à un backend.',
        ),
      ),
    );
  }

  void _addToCart() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ajouté au panier: ${_variants[_selectedVariantIndex].key} x$_quantity'),
        action: SnackBarAction(
          label: 'Voir panier',
          onPressed: () {
            // Navigate to cart
          },
        ),
      ),
    );
  }

  void _buyNow() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Achat immédiat - Redirection vers checkout'),
      ),
    );
  }

  void _contactVendor() async {
    // Demo WhatsApp number
    const phoneNumber = '221123456789';
    try {
      await UrlLauncherHelper.launchWhatsApp(phoneNumber);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $e')),
        );
      }
    }
  }

  void _addToFavorites() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ajouté aux favoris')),
    );
  }

  void _showShareOptions() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Partage du produit')),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}