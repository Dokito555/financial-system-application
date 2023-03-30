import 'package:flutter/material.dart';
import 'package:flutter_financial/domain/usecases/firebase_auth/reset_password.dart';
import 'package:flutter_financial/domain/usecases/firebase_auth/signIn.dart';
import 'package:flutter_financial/domain/usecases/firebase_auth/signOut.dart';
import 'package:flutter_financial/domain/usecases/firebase_auth/signUp.dart';
import 'package:injectable/injectable.dart';

import '../../core/utility/state_enum.dart';

@injectable
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

  late Status _signUpStatus;
  Status get signUpStatus => _signUpStatus;

  late Status _signInStatus;
  Status get signInStatus => _signInStatus;

  late Status _signOutStatus;
  Status get signOutStatus => _signOutStatus;

  late Status _resetPasswordStatus;
  Status get resetPasswordStatus => _resetPasswordStatus;

  String _message = '';
  String get message => _message;

  Future<void> authSignUpEmailPassword({
    required String email,
    required String password 
  }) async {
    _signUpStatus = Status.Loading;
    notifyListeners();
    final result = await firebaseAuthSignUp.execute(email, password);
    result.fold(
      (failure) {
        _signUpStatus = Status.Error;
        _message = failure.message;
        notifyListeners();
      }, 
      (result) {
        _signUpStatus = Status.Success;
        _message = 'Sign up success';
        notifyListeners();
      }
    );
  }

  Future<void> authSignInEmailPassword({
    required String email,
    required String password
  }) async {
    _signInStatus = Status.Loading;
    notifyListeners();
    final result = await firebaseAuthSignIn.execute(email, password);
    result.fold(
      (failure) {
        _signInStatus = Status.Error;
        _message = failure.message;
        notifyListeners();
      }, 
      (result) {
        _signInStatus = Status.Success;
        _message = 'Sign in success';
        notifyListeners();
      }
    );
  }

  Future<void> authSignOut() async {
    _signOutStatus = Status.Loading;
    notifyListeners();
    final result = await firebaseAuthSignOut.execute();
    result.fold(
      (failure) {
        _signOutStatus = Status.Error;
        _message = failure.message;
        notifyListeners();
      }, 
      (result) {
        _signOutStatus = Status.Success;
        _message = 'Sign out success';
        notifyListeners();
      }
    );
  }

  Future<void> authResetPassword({
    required String email
  }) async {
    _resetPasswordStatus = Status.Loading;
    notifyListeners();
    final result = await firebaseAuthResetPassword.execute(email);
    result.fold(
      (failure) {
        _resetPasswordStatus = Status.Error;
        _message = failure.message;
        notifyListeners();
      }, 
      (result) {
        _resetPasswordStatus = Status.Success;
        _message = 'Please reset your password';
        notifyListeners();
      }
    );
  }

}