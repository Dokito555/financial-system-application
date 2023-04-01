import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_financial/core/error/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_financial/data/datasource/remote/firebase_auth.dart';
import 'package:flutter_financial/data/model/user_model.dart';
import 'package:flutter_financial/domain/repository/firebase_auth_repository.dart';
import 'package:injectable/injectable.dart';

@prod
@LazySingleton(as: FirebaseAuthRepository)
class FirebaseAuthRepositoryImpl extends FirebaseAuthRepository {

  final FirebaseAuthenticationRemoteDataSource remoteDataSource;

  FirebaseAuthRepositoryImpl({
    required this.remoteDataSource
  });

  @override
  Future<Either<Failure, UserCredential>> authSignInEmailPassword(String email, String password) async {
    try {
      final result = await remoteDataSource.authSignInEmailPassword(email, password);
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
      final result = await remoteDataSource.authSignOut();
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
      final result = await remoteDataSource.authSignUpEmailPassword(email, password);
      return Right(result);
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to network'));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(String email) async {
   try {
    final result = await remoteDataSource.resetPassword(email);
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
  Future<Either<Failure, void>> userFirestore(UserModel user) async {
    try {
    final result = await remoteDataSource.userFirestore(user);
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
  Future<Either<Failure, UserModel>> getUser() async {
    try {
    final result = await remoteDataSource.getUser();
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