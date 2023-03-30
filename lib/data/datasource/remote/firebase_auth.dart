// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_financial/core/utility/constants.dart';
import 'package:injectable/injectable.dart';

import '../../model/user_model.dart';

abstract class FirebaseAuthenticationRemoteDataSource {
  Future<UserCredential> authSignInEmailPassword(String email, String password);
  Future<UserCredential> authSignUpEmailPassword(String email, String password);
  Future<void> resetPassword(String email);
  Future<void> authSignOut();
  Future<void> userFirestore(UserModel user);
}

@prod
@LazySingleton(as: FirebaseAuthenticationRemoteDataSource)
class FirebaseAuthenticationRemoteDataSourceImpl extends FirebaseAuthenticationRemoteDataSource {

  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore db;
  FirebaseAuthenticationRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.db
  });

  @override
  Future<UserCredential> authSignInEmailPassword(String email, String password) async {
    return await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> authSignOut() async {
    return await firebaseAuth.signOut();
  }

  @override
  Future<UserCredential> authSignUpEmailPassword(String email, String password) async {
   return await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> resetPassword(String email) async {
    return await firebaseAuth.sendPasswordResetEmail(email: email);
  }
  
  @override
  Future<void> userFirestore(UserModel user) async {
    await db.collection(firestoreUsers).doc(user.id).set(user.toJson());
  }

}