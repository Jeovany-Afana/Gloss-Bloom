# Gloss Market - Architecture

## Vue d'ensemble
Application Flutter marketplace dédiée aux gloss avec architecture Clean Architecture, 100% front-end prête pour l'intégration Firebase.

## Architecture technique

### Structure du projet
```
lib/
├── app/                    # Configuration app, routing, providers  
├── core/                   # Utilitaires, widgets communs
├── domain/                 # Entités, repositories (Clean Architecture)
├── data/                   # Implémentations repositories (stubs)
├── features/              # Fonctionnalités par feature
└── l10n/                  # Internationalisation fr/en
```

### Technologies
- **Flutter & Dart** - Framework principal
- **Riverpod** - State management 
- **GoRouter** - Navigation déclarative
- **Material 3** - Design system avec thème rose glamour
- **Intl** - Internationalisation et formatage XOF

## Fonctionnalités implémentées (UI)

### Core
- ✅ **Onboarding** - 3 écrans présentation
- ✅ **Auth** - Connexion/inscription + sélection rôle
- ✅ **Navigation** - Bottom navigation 4 onglets
- ✅ **Thème** - Mode sombre/clair avec palette rose

### Parcours utilisateur
- ✅ **Catalogue** - Recherche, filtres, tri (UI)
- ✅ **Détail produit** - Variantes couleurs, contact WhatsApp
- ✅ **Panier & Checkout** - 3 étapes (adresse, livraison, paiement) 
- ✅ **Profil** - Gestion compte et paramètres
- ✅ **Commandes** - Timeline de suivi (UI)

### Composants réutilisables
- ✅ **EmptyState** - États vides gracieux
- ✅ **ShimmerLoading** - Indicateurs de chargement
- ✅ **ColorSwatch** - Sélecteur de couleurs hex
- ✅ **PriceTag** - Formatage prix XOF
- ✅ **RatingStars** - Système de notation

## Architecture données

### Entités principales
- `User` - Utilisateurs (acheteurs/vendeurs)
- `Product` - Produits avec variantes
- `CartItem` - Éléments du panier
- `Order` - Commandes avec timeline
- `Vendor` - Profils vendeurs

### Repositories (interfaces)
- `AuthRepository` - Authentification
- `CatalogRepository` - Produits et recherche
- `CartRepository` - Gestion panier
- `OrderRepository` - Commandes
- `PaymentRepository` - Paiements (Wave, Orange Money...)
- `DeliveryRepository` - Livraison (Yobantel, ColisExpress...)

### Implémentations stub
Tous les repositories retournent des états vides ou des simulations pour démonstration.

## Intégration Firebase prévue

### Points d'ancrage
1. **Interfaces définies** - Contracts dans `domain/repositories/`
2. **Injection centralisée** - Providers Riverpod dans `app/providers.dart`  
3. **Modèles préparés** - Entités avec sérialisation JSON

### Services recommandés
- **Authentication** - Gestion utilisateurs
- **Firestore** - Base données NoSQL
- **Storage** - Images produits  
- **Cloud Functions** - Logic métier

## Paiements & Livraison

### Prestataires paiement (UI)
- Wave, Orange Money, Free Money, PayDunya

### Prestataires livraison (UI)  
- Yobantel, ColisExpress, Retrait boutique

## Internationalisation
- **Français (fr_SN)** - Langue principale
- **Anglais (en)** - Langue secondaire
- **RTL Ready** - Préparé pour langues RTL

## Mode démo
Contrôlé par `AppConstants.demoMode` (false par défaut).
Quand activé : génère des placeholders programmatiques sans données métier.

## Compilation

### Démarrage rapide
```bash
flutter pub get
flutter run
```

### Avec Freezed (optionnel)
```bash
dart run build_runner build
```

## Tests
3 tests widget implémentés :
1. États vides
2. Badge panier  
3. Timeline commande

## Prochaines étapes
1. Intégrer Firebase (remplacer stubs)
2. Ajouter données réelles
3. Implémenter paiements/livraison
4. Tests d'intégration