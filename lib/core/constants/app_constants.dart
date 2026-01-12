class AppConstants {
  // App Configuration
  static const String appName = 'Gloss Market';
  static const String appVersion = '1.0.0';
  
  // Demo Mode (désactivé par défaut)
  static const bool demoMode = false;
  
  // Currency
  static const String currencyCode = 'XOF';
  static const String currencySymbol = 'FCFA';
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxCompareProducts = 3;
  
  // Image dimensions
  static const double productImageRatio = 1.0;
  static const double vendorAvatarSize = 40.0;
  
  // Animation durations
  static const Duration shortDuration = Duration(milliseconds: 300);
  static const Duration mediumDuration = Duration(milliseconds: 600);
  
  // Delivery providers
  static const List<String> deliveryProviders = [
    'Yobantel',
    'ColisExpress',
    'Retrait en boutique'
  ];
  
  // Payment providers  
  static const List<String> paymentProviders = [
    'Wave',
    'Orange Money',
    'Free Money',
    'PayDunya'
  ];
  
  // WhatsApp
  static const String whatsappBaseUrl = 'https://wa.me';
}