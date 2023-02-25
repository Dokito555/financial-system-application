import 'package:flutter/material.dart';
import 'package:flutter_financial/core/error/failure.dart';
import 'package:flutter_financial/core/usecase/usecase.dart';
import 'package:flutter_financial/domain/usecases/firebase_auth/reset_password.dart';
import 'package:flutter_financial/domain/usecases/firebase_auth/signIn.dart';
import 'package:flutter_financial/domain/usecases/firebase_auth/signOut.dart';
import 'package:flutter_financial/domain/usecases/firebase_auth/signUp.dart';

import '../../core/utility/state_enum.dart';

class FirebaseAuthNotifier extends ChangeNotifier {

  FirebaseAuthSignUp firebaseAuthSignUp;
  FirebaseAuthSignIn firebaseAuthSignIn;
  FirebaseAuthSignOut firebaseAuthSignOut;
  FirebaseAuthResetPassword firebaseAuthResetPassword;

  FirebaseAuthNotifier({
    required this.firebaseAuthSignUp,
    required this.firebaseAuthSignIn,
    required this.firebaseAuthSignOut,
    required this.firebaseAuthResetPassword
  });

  late Status _status;
  Status get status => _status;

  String _message = '';
  String get message => _message;

  Future<void> authSignUpEmailPassword({
    required String email,
    required String password 
  }) async {
    _status = Status.Loading;
    notifyListeners();
    final result = await firebaseAuthSignUp.execute(email, password);
    result.fold(
      (failure) {
        _status = Status.Error;
        _message = failure.message;
        notifyListeners();
      }, 
      (result) {
        _status = Status.Loading;
        _message = 'Sign up success';
        notifyListeners();
      }
    );
  }

  Future<void> authSignInEmailPassword({
    required String email,
    required String password
  }) async {
    _status = Status.Loading;
    notifyListeners();
    final result = await firebaseAuthSignIn.execute(email, password);
    result.fold(
      (failure) {
        _status = Status.Error;
        _message = failure.message;
        notifyListeners();
      }, 
      (result) {
        _status = Status.Loading;
        _message = 'Sign in success';
        notifyListeners();
      }
    );
  }

  Future<void> authSignOut() async {
    _status = Status.Loading;
    notifyListeners();
    final result = await firebaseAuthSignOut.execute();
    result.fold(
      (failure) {
        _status = Status.Error;
        _message = failure.message;
        notifyListeners();
      }, 
      (result) {
        _status = Status.Loading;
        _message = 'Sign out success';
        notifyListeners();
      }
    );
  }

  Future<void> authResetPassword({
    required String email
  }) async {
    _status = Status.Loading;
    notifyListeners();
    final result = await firebaseAuthResetPassword.execute(email);
    result.fold(
      (failure) {
        _status = Status.Error;
        _message = failure.message;
        notifyListeners();
      }, 
      (result) {
        _status = Status.Loading;
        _message = 'Please reset your password';
        notifyListeners();
      }
    );
  }

}