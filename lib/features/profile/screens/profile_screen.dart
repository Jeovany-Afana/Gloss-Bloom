import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gloss_bloom/l10n/app_localizations.dart';
import 'package:gloss_bloom/app/router.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profile),
        actions: [
          IconButton(
            onPressed: () => context.go(RouteNames.settings),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // User Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primaryContainer,
                    Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Utilisateur Demo',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  Text(
                    'demo@glossmarket.com',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),

            // Menu Items
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildMenuItem(
                    context,
                    icon: Icons.shopping_bag,
                    title: 'Mes commandes',
                    onTap: () => context.go(RouteNames.orders),
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.favorite,
                    title: 'Mes favoris',
                    onTap: () => _showNotImplemented(context, 'Favoris'),
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.location_on,
                    title: 'Mes adresses',
                    onTap: () => _showNotImplemented(context, 'Adresses'),
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.payment,
                    title: 'Moyens de paiement',
                    onTap: () => _showNotImplemented(context, 'Paiements'),
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.star,
                    title: 'Mes avis',
                    onTap: () => _showNotImplemented(context, 'Avis'),
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.notifications,
                    title: 'Notifications',
                    onTap: () => _showNotImplemented(context, 'Notifications'),
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.help,
                    title: 'Aide et support',
                    onTap: () => _showNotImplemented(context, 'Support'),
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.info,
                    title: 'À propos',
                    onTap: () => _showNotImplemented(context, 'À propos'),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => _showSignOutDialog(context),
                      icon: const Icon(Icons.logout),
                      label: Text(l10n.signOut),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.error,
                        side: BorderSide(color: Theme.of(context).colorScheme.error),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  void _showNotImplemented(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$feature - Fonctionnalité en développement')),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Déconnexion'),
        content: const Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              context.go(RouteNames.auth);
            },
            child: const Text('Déconnexion'),
          ),
        ],
      ),
    );
  }
}