import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

/// Callers can lookup localized strings with Lookup.of(context).
///
/// This is only a fallback lookup mechanism for development purposes.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('fr', 'SN'),
    Locale('en')
  ];

  // Common
  String get appName;
  String get ok;
  String get cancel;
  String get save;
  String get delete;
  String get edit;
  String get search;
  String get loading;
  String get retry;
  String get error;
  String get success;
  
  // Navigation
  String get home;
  String get catalog;
  String get cart;
  String get profile;
  String get orders;
  String get settings;
  
  // Auth
  String get signIn;
  String get signUp;
  String get signOut;
  String get email;
  String get password;
  String get confirmPassword;
  String get forgotPassword;
  String get createAccount;
  String get alreadyHaveAccount;
  String get dontHaveAccount;
  
  // Onboarding
  String get getStarted;
  String get skip;
  String get next;
  String get previous;
  
  // Products
  String get products;
  String get addToCart;
  String get outOfStock;
  String get inStock;
  String get price;
  String get rating;
  String get reviews;
  String get variants;
  String get colors;
  String get brand;
  String get finish;
  
  // Cart
  String get cartEmpty;
  String get cartTotal;
  String get checkout;
  String get quantity;
  String get remove;
  
  // Orders
  String get orderHistory;
  String get orderDetails;
  String get orderStatus;
  String get trackOrder;
  
  // General
  String get emptyState;
  String get noResults;
  String get tryAgain;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'fr': return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue on GitHub with a '
    'reproducible sample app and the gen-l10n configuration that was used.'
  );
}