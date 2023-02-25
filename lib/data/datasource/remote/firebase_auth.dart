import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthenticationRemoteDataSource {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;

  Future<UserCredential> authSignInEmailPassword({
    required String email,
    required String password
  }) async {
    return await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> authSignUpEmailPassword({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> resetPassword({
    required String email,
  }) async {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> authSignOut() async {
    return await _firebaseAuth.signOut();
  }

}