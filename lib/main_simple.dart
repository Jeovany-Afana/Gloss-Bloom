import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gloss_bloom/theme.dart';
import 'package:gloss_bloom/features/onboarding/screens/onboarding_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: GlossMarketSimpleApp(),
    ),
  );
}

class GlossMarketSimpleApp extends StatelessWidget {
  const GlossMarketSimpleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gloss Market',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const OnboardingScreen(),
    );
  }
}