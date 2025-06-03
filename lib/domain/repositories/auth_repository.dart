import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  User? get currentUser;

  Future<void> signUp({
    required String email,
    required String name,
    required String phone,
    required String password,
  });

  Future<void> signIn({required String email, required String password});

  Future<void> signOut();

  //TODO: check if you can input the old password and new password
  Future<void> changePassword({required String password});

  Future<void> sendPasswordResetEmail({required String email});

  Future<void> reloadUser();

  //Must be reauthenticated if you want to change the password
  Future<void> reauthenticateWithCredential({
    required String email,
    required String password,
  });
}
