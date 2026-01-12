import 'package:gloss_bloom/domain/entities/user.dart';
import 'package:gloss_bloom/domain/repositories/auth_repository.dart';
import 'package:gloss_bloom/core/constants/app_constants.dart';

class AuthRepositoryImpl implements AuthRepository {
  User? _currentUser;

  @override
  Stream<User?> get currentUserStream => Stream.value(_currentUser);

  @override
  User? get currentUser => _currentUser;

  @override
  Future<User> signIn(String email, String password) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));
    
    if (AppConstants.demoMode) {
      _currentUser = User(
        id: 'demo_user',
        role: UserRole.buyer,
        displayName: 'Demo User',
        email: email,
        createdAt: DateTime.now(),
      );
      return _currentUser!;
    }
    
    throw UnimplementedError('Sign in requires backend implementation');
  }

  @override
  Future<User> signUp(String email, String password, String displayName, UserRole role) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));
    
    if (AppConstants.demoMode) {
      _currentUser = User(
        id: 'demo_user',
        role: role,
        displayName: displayName,
        email: email,
        createdAt: DateTime.now(),
      );
      return _currentUser!;
    }
    
    throw UnimplementedError('Sign up requires backend implementation');
  }

  @override
  Future<User> signInWithGoogle() async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 2));
    
    if (AppConstants.demoMode) {
      _currentUser = const User(
        id: 'google_demo_user',
        role: UserRole.buyer,
        displayName: 'Google Demo User',
        email: 'demo@gmail.com',
      );
      return _currentUser!;
    }
    
    throw UnimplementedError('Google sign in requires backend implementation');
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = null;
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await Future.delayed(const Duration(seconds: 1));
    if (!AppConstants.demoMode) {
      throw UnimplementedError('Password reset requires backend implementation');
    }
  }

  @override
  Future<void> updateProfile(String displayName, String? photoUrl) async {
    await Future.delayed(const Duration(seconds: 1));
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(
        displayName: displayName,
        photoUrl: photoUrl,
      );
    }
  }
}