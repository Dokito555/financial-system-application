import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/utility/state_enum.dart';

class AuthService extends ChangeNotifier {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late Status _status;
  String _message = '';

  User? get currentUser => _firebaseAuth.currentUser;
  Status get status => _status;
  String get message => _message;
  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  Future<String> authSignInEmailPassword({
    required String email,
    required String password
  }) async {
    _status = Status.Loading;
    notifyListeners();
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email, 
        password: password
      );
      _status = Status.Success;
      notifyListeners();
      return _message = 'Sign In Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _status = Status.Error;
        notifyListeners();
        return _message = 'No user found for that email';
      } else if (e.code == 'wrong-password') {
        _status = Status.Error;
        notifyListeners();
        return _message = 'Wrong password provided for that user';
      }
      _status = Status.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    } catch (e) {
      _status = Status.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<String> createUserWithEmailPassword({
    required String email,
    required String password
  }) async {
    _status = Status.Loading;
    notifyListeners();
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
      _status = Status.Success;
      notifyListeners();
      return _message = 'Sign up Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _status = Status.Error;
        notifyListeners();
        return _message = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        _status = Status.Error;
         notifyListeners();
        return _message = 'The account already exists for that email';
      }
      _status = Status.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    } catch (e) {
      _status = Status.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<String> authLogout() async {
    _status = Status.Loading;
    notifyListeners();
    try {
      await _firebaseAuth.signOut();
      _status = Status.Success;
      notifyListeners();
      return _message = 'Sign out Success';
    } catch (e) {
      _status = Status.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<String> authResetPassword({
    required String email
  }) async {
    _status = Status.Loading;
    notifyListeners();
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      _status = Status.Success;
      notifyListeners();
      return _message = 'Please reset your password';
    } catch (e) {
      _status = Status.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
  
}