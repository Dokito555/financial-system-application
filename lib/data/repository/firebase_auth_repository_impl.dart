import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_financial/core/error/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_financial/data/datasource/remote/firebase_auth.dart';
import 'package:flutter_financial/domain/repository/firebase_auth_repository.dart';

class FirebaseAuthRepositoryImpl extends FirebaseAuthRepository {

  // Might look on this late, might occur an error
  late FirebaseAuthenticationRemoteDataSource _remoteDataSource;

  FirebaseAuthRepositoryImpl({
    required FirebaseAuthenticationRemoteDataSource firebaseAuthenticationRemoteDataSource
  }) {
    _remoteDataSource = firebaseAuthenticationRemoteDataSource;
  }

  @override
  Future<Either<Failure, UserCredential>> authSignInEmailPassword(String email, String password) async {
    try {
      final result = await _remoteDataSource.authSignInEmailPassword(email: email, password: password);
      return Right(result);
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to network'));
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('Failed with error code: ${e.code}');
        return Left(FirebaseFailure('Failed with error code: ${e.code}'));
      }
      if (e.code == 'user-not-found') {
        return Left(FirebaseFailure('No user found for that email'));
      }
      if (e.code == 'wrong-password') {
        return Left(FirebaseFailure('Wrong password provided for that user'));
      }
      return Left(FirebaseFailure('Failed with error code: ${e.code}'));
    }
  }

  @override
  Future<Either<Failure, void>> authSignOut() async {
    try {
      final result = await _remoteDataSource.authSignOut();
      return Right(result);
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to network'));
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('Failed with error code: ${e.code}');
      }
      return Left(FirebaseFailure('Failed with error code: ${e.code}'));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> authSignUpEmailPassword(String email, String password) async {
    try {
      final result = await _remoteDataSource.authSignInEmailPassword(email: email, password: password);
      return Right(result);
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to network'));
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('Failed with error code: ${e.code}');
        return Left(FirebaseFailure('Failed with error code: ${e.code}'));
      }
      if (e.code == 'weak-password') {
        return Left(FirebaseFailure('The password provided is too weak'));
      }
      if (e.code == 'email-already-in-use') {
        return Left(FirebaseFailure('The account already exists for that email'));
      }
      return Left(FirebaseFailure('Failed with error code: ${e.code}'));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(String email) async {
   try {
    final result = await _remoteDataSource.resetPassword(email: email);
    return Right(result);
   } on SocketException {
      return Left(ConnectionFailure('Failed to connect to network'));
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('Failed with error code: ${e.code}');
      }
      return Left(FirebaseFailure('Failed with error code: ${e.code}'));
    }
  }
  
}