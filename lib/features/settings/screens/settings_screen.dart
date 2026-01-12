import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gloss_bloom/l10n/app_localizations.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  String _selectedLanguage = 'fr';
  String _selectedCurrency = 'XOF';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: ListView(
        children: [
          // Account Settings
          _buildSection(
            context,
            title: 'Compte',
            children: [
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Modifier le profil'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showNotImplemented('Modifier le profil'),
              ),
              ListTile(
                leading: const Icon(Icons.lock),
                title: const Text('Changer le mot de passe'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showNotImplemented('Mot de passe'),
              ),
              ListTile(
                leading: const Icon(Icons.delete_forever),
                title: const Text('Supprimer le compte'),
                titleTextStyle: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showDeleteAccountDialog(),
              ),
            ],
          ),

          // App Settings
          _buildSection(
            context,
            title: 'Préférences',
            children: [
              SwitchListTile(
                secondary: const Icon(Icons.notifications),
                title: const Text('Notifications'),
                subtitle: const Text('Recevoir les notifications push'),
                value: _notificationsEnabled,
                onChanged: (value) => setState(() => _notificationsEnabled = value),
              ),
              SwitchListTile(
                secondary: const Icon(Icons.dark_mode),
                title: const Text('Mode sombre'),
                subtitle: const Text('Activer le thème sombre'),
                value: _darkModeEnabled,
                onChanged: (value) => setState(() => _darkModeEnabled = value),
              ),
              ListTile(
                leading: const Icon(Icons.language),
                title: const Text('Langue'),
                subtitle: Text(_getLanguageLabel(_selectedLanguage)),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showLanguageDialog(),
              ),
              ListTile(
                leading: const Icon(Icons.money),
                title: const Text('Devise'),
                subtitle: Text(_getCurrencyLabel(_selectedCurrency)),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showCurrencyDialog(),
              ),
            ],
          ),

          // Support & Legal
          _buildSection(
            context,
            title: 'Support et légal',
            children: [
              ListTile(
                leading: const Icon(Icons.help),
                title: const Text('Centre d\'aide'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showNotImplemented('Centre d\'aide'),
              ),
              ListTile(
                leading: const Icon(Icons.contact_support),
                title: const Text('Nous contacter'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showNotImplemented('Contact'),
              ),
              ListTile(
                leading: const Icon(Icons.description),
                title: const Text('Conditions d\'utilisation'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showNotImplemented('CGU'),
              ),
              ListTile(
                leading: const Icon(Icons.privacy_tip),
                title: const Text('Politique de confidentialité'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showNotImplemented('Confidentialité'),
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('Version de l\'app'),
                subtitle: const Text('1.0.0'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        ...children,
      ],
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Choisir la langue'),
        children: [
          SimpleDialogOption(
            onPressed: () {
              setState(() => _selectedLanguage = 'fr');
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Radio<String>(
                  value: 'fr',
                  groupValue: _selectedLanguage,
                  onChanged: null,
                ),
                const Text('Français'),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              setState(() => _selectedLanguage = 'en');
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Radio<String>(
                  value: 'en',
                  groupValue: _selectedLanguage,
                  onChanged: null,
                ),
                const Text('English'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showCurrencyDialog() {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Choisir la devise'),
        children: [
          SimpleDialogOption(
            onPressed: () {
              setState(() => _selectedCurrency = 'XOF');
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Radio<String>(
                  value: 'XOF',
                  groupValue: _selectedCurrency,
                  onChanged: null,
                ),
                const Text('FCFA (XOF)'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer le compte'),
        content: const Text(
          'Cette action est irréversible. Toutes vos données seront supprimées définitivement.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              _showNotImplemented('Suppression de compte');
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
  }

  void _showNotImplemented(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$feature - Fonctionnalité en développement')),
    );
  }

  String _getLanguageLabel(String code) {
    switch (code) {
      case 'fr': return 'Français';
      case 'en': return 'English';
      default: return code;
    }
  }

  String _getCurrencyLabel(String code) {
    switch (code) {
      case 'XOF': return 'FCFA (XOF)';
      default: return code;
    }
  }
}