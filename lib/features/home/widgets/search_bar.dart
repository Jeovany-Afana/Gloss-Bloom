import 'package:flutter/material.dart';
import 'package:gloss_bloom/l10n/app_localizations.dart';

class HomeSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSearch;

  const HomeSearchBar({
    super.key,
    required this.controller,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SearchBar(
      controller: controller,
      hintText: '${l10n.search} gloss, marques...',
      leading: const Icon(Icons.search),
      onSubmitted: onSearch,
      onTap: () {
        // Navigate to catalog with focus on search
        onSearch('');
      },
    );
  }
}