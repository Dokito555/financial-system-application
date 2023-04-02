import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_financial/data/model/user_model.dart';
import 'package:flutter_financial/domain/usecases/firebase_auth/get_user.dart';
import 'package:flutter_financial/domain/usecases/firebase_auth/reset_password.dart';
import 'package:flutter_financial/domain/usecases/firebase_auth/signIn.dart';
import 'package:flutter_financial/domain/usecases/firebase_auth/signOut.dart';
import 'package:flutter_financial/domain/usecases/firebase_auth/signUp.dart';
import 'package:flutter_financial/domain/usecases/firebase_auth/user_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../core/utility/state_enum.dart';

@injectable
class FirebaseAuthNotifier extends ChangeNotifier {

  FirebaseAuthSignUp firebaseAuthSignUp;
  FirebaseAuthSignIn firebaseAuthSignIn;
  FirebaseAuthSignOut firebaseAuthSignOut;
  FirebaseAuthResetPassword firebaseAuthResetPassword;
  FirebaseStoreUser firebaseStoreUser;
  FirebaseGetUser firebaseGetUser;

  FirebaseAuthNotifier({
    required this.firebaseAuthSignUp,
    required this.firebaseAuthSignIn,
    required this.firebaseAuthSignOut,
    required this.firebaseAuthResetPassword,
    required this.firebaseStoreUser,
    required this.firebaseGetUser
  });

  Status _signUpStatus = Status.Empty;
  Status get signUpStatus => _signUpStatus;

  Status _signInStatus = Status.Empty;
  Status get signInStatus => _signInStatus;

  late Status _signOutStatus;
  Status get signOutStatus => _signOutStatus;

  late Status _resetPasswordStatus;
  Status get resetPasswordStatus => _resetPasswordStatus;

  late Status _storeUserStatus;
  Status get storeUserStatus => _storeUserStatus;

  late String _userUID;
  String get userUID => _userUID;

  late Status _getUserStatus;
  Status get getUserStatus => _getUserStatus;

  late UserModel _userDetail = UserModel(id: '', name: '', email: '', phoneNumber: '');
  UserModel get userDetail => _userDetail;

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
        _userUID = result.user!.uid;
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

  Future<void> storeUser({
    required UserModel user
  }) async {
    _storeUserStatus = Status.Loading;
    notifyListeners();
    final result = await firebaseStoreUser.execute(user);
    result.fold(
      (failure) {
        _storeUserStatus = Status.Error;
        _message = failure.message;
      }, 
      (result) {
        _storeUserStatus = Status.Success;
        _message = 'Success';
        notifyListeners();
      }
    );
  }

  Future<void> getUser() async {
    _getUserStatus = Status.Loading;
    notifyListeners();
    final result = await firebaseGetUser.execute();
    result.fold(
      (failure) {
        _getUserStatus = Status.Error;
        _message = failure.message;
      }, 
      (result) {
        _userDetail = result;
        _getUserStatus = Status.Success;
        _message = 'Success';
        notifyListeners();
      }
    );
  }

}