import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_financial/data/model/user_model.dart';
import 'package:injectable/injectable.dart';
import '../../core/error/failure.dart';

abstract class FirebaseAuthRepository {
  Future<Either<Failure, UserCredential>> authSignInEmailPassword(String email, String password);
  Future<Either<Failure, UserCredential>> authSignUpEmailPassword(String email, String password);
  Future<Either<Failure, void>> resetPassword(String email);
  Future<Either<Failure, void>> authSignOut();
  Future<Either<Failure, void>> userFirestore(UserModel user);
  Future<Either<Failure, UserModel>> getUser();
}