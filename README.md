# Gloss Market

Une marketplace dédiée aux gloss développée avec Flutter. Application 100% front-end prête pour l'intégration Firebase.

## 🚀 Démarrage rapide

### Prérequis
- Flutter SDK 3.6.0+
- Dart SDK

### Installation
1. Cloner le projet
2. Installer les dépendances :
   ```bash
   flutter pub get
   ```
3. Générer les fichiers Freezed/JSON :
   ```bash
   dart run build_runner build
   ```
4. Lancer l'application :
   ```bash
   flutter run
   ```

## 🏗️ Architecture

### Structure du projet
```
lib/
├── app/                    # Configuration de l'app, routing, providers
├── core/                   # Utilitaires, widgets communs, constantes
├── domain/                 # Entités, repositories, use cases (Clean Architecture)
├── data/                   # Implémentations des repositories (stubs)
├── features/              # Fonctionnalités organisées par feature
│   ├── auth/
│   ├── home/
│   ├── catalog/
│   ├── product/
│   ├── cart/
│   ├── checkout/
│   ├── orders/
│   ├── profile/
│   └── settings/
└── l10n/                  # Internationalisation (fr/en)
```

### Technologies utilisées
- **Flutter & Dart** - Framework et langage principal
- **Riverpod** - Gestion d'état réactive
- **GoRouter** - Navigation déclarative
- **Freezed** - Modèles immutables et sérialisation
- **Intl** - Internationalisation et formatage
- **Material 3** - Design system

### Patterns architecturaux
- **Clean Architecture** - Séparation des couches
- **Repository Pattern** - Abstraction des données
- **Provider Pattern** - Injection de dépendance avec Riverpod

## 📱 Fonctionnalités implémentées

### ✅ Core Features (UI uniquement)
- **Onboarding** - 3 écrans de présentation
- **Authentification** - Connexion/inscription avec sélection de rôle
- **Navigation** - Bottom navigation avec 4 onglets
- **Catalogue** - Recherche, filtres, tri (UI)
- **Détail produit** - Variantes couleurs, avis, contact vendeur
- **Panier & Checkout** - Processus de commande en 3 étapes
- **Profil utilisateur** - Gestion du compte et paramètres

### 🎨 Design System
- **Thème Material 3** avec palette rose/glamour
- **Mode sombre** automatique
- **Typographie** - Poppins (titres) + Inter (texte)
- **Composants réutilisables** - Widgets personnalisés
- **États vides** - Gestion gracieuse des contenus vides
- **Shimmer loading** - Indicateurs de chargement

### 🌍 Internationalisation
- **Français (fr_SN)** - Langue principale
- **Anglais (en)** - Langue secondaire
- **RTL Ready** - Préparé pour les langues RTL

## 🔧 Configuration

### Mode Démo
Le mode démo est contrôlé par `AppConstants.demoMode` (défaut: `false`).

Pour l'activer :
```dart
// lib/core/constants/app_constants.dart
static const bool demoMode = true;
```

### Thème et couleurs
Les couleurs peuvent être personnalisées dans `lib/theme.dart` :
- Primary: Rose glamour (#E91E63)
- Secondary: Rose clair (#FF6B9D) 
- Tertiary: Or premium (#D4AF37)

## 🔌 Intégration Firebase

### Points d'ancrage préparés
1. **Repositories** - Interfaces définies dans `domain/repositories/`
2. **Providers** - Injection centralisée dans `app/providers.dart`
3. **Entities** - Modèles avec sérialisation JSON

### Pour brancher Firebase :
1. Configurer Firebase dans le projet
2. Remplacer les implémentations stub (`data/repositories/*_impl.dart`)
3. Ajouter les dépendances Firebase au `pubspec.yaml`
4. Implémenter `*FirebaseRepository` étendant les interfaces existantes

### Services Firebase recommandés :
- **Authentication** - Gestion des utilisateurs
- **Firestore** - Base de données NoSQL
- **Cloud Functions** - Logic métier backend
- **Storage** - Images et fichiers

## 💳 Paiements & Livraison

### Prestataires de paiement (UI)
- Wave
- Orange Money  
- Free Money
- PayDunya

### Prestataires de livraison (UI)
- Yobantel
- ColisExpress
- Retrait en boutique

## 🧪 Tests

### Tests widgets implémentés
```bash
flutter test
```

1. **États vides** - Affichage correct quand pas de données
2. **Panier** - Badge de comptage mis à jour
3. **Timeline commande** - Affichage des 4 étapes

## 📋 TODO pour production

### Backend requis
- [ ] Implémentations Firebase des repositories
- [ ] Authentification réelle (Google, WhatsApp)
- [ ] Upload et gestion des images
- [ ] Notifications push
- [ ] Intégration paiements réels
- [ ] API de suivi livraison

### Optimisations
- [ ] Cache des images
- [ ] Pagination infinie
- [ ] Recherche en temps réel
- [ ] Analytics et crash reporting
- [ ] Tests d'intégration

### Déploiement
- [ ] Configuration CI/CD
- [ ] Génération des APK/IPA
- [ ] Publication sur les stores
- [ ] Monitoring et logs

## 👥 Rôles utilisateurs

### Acheteuse
- Navigation et recherche produits
- Gestion panier et commandes
- Avis et favoris
- Suivi livraisons

### Vendeuse  
- Gestion catalogue produits
- Traitement des commandes
- Abonnements premium
- Publicités sponsorisées

### Fondatrice (Admin)
- Toutes fonctionnalités vendeuse
- Attribution emplacements premium
- Gestion globale plateforme

## 📞 Support

Pour toute question sur l'architecture ou l'implémentation :
- Consulter la documentation dans `/docs`
- Vérifier les commentaires dans le code
- Analyser les interfaces dans `/domain`

## 📄 License

Propriété de Gloss Market - Tous droits réservés.