import 'package:gloss_bloom/domain/entities/user.dart';

abstract class AuthRepository {
  Stream<User?> get currentUserStream;
  User? get currentUser;
  
  Future<User> signIn(String email, String password);
  Future<User> signUp(String email, String password, String displayName, UserRole role);
  Future<User> signInWithGoogle();
  Future<void> signOut();
  Future<void> sendPasswordResetEmail(String email);
  Future<void> updateProfile(String displayName, String? photoUrl);
}