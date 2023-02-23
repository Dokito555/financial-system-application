import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../common/state_enum.dart';

class AuthProvider extends ChangeNotifier {

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
      _status = Status.Loaded;
      notifyListeners();
      return _message = 'Sign In Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        _status = Status.Error;
        notifyListeners();
        return _message = 'No user found for that email';
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        _status = Status.Error;
        notifyListeners();
        return _message = 'Wrong password provided for that user';
      }
      print('Error --> $e');
      _status = Status.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    } catch (e) {
      print('Error --> $e');
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
      _status = Status.Loaded;
      notifyListeners();
      return _message = 'Sign up Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        _status = Status.Error;
        notifyListeners();
        return _message = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        _status = Status.Error;
         notifyListeners();
        return _message = 'he account already exists for that email';
      }
      print('Error --> $e');
      _status = Status.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    } catch (e) {
      print('Error --> $e');
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
      _status = Status.Loaded;
      notifyListeners();
      return _message = 'Sign out Success';
    } catch (e) {
      print('Error --> $e');
      _status = Status.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
  
}