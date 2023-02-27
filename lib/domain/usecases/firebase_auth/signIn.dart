import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_financial/core/usecase/usecase.dart';
import 'package:flutter_financial/domain/repository/firebase_auth_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failure.dart';

@prod
@lazySingleton
@injectable
class FirebaseAuthSignIn extends UsecaseTwoParams<Future<Either<Failure, UserCredential>>, String, String> {

  final FirebaseAuthRepository repository;

  FirebaseAuthSignIn({
    required this.repository
  });

  @override
  Future<Either<Failure, UserCredential>> execute(String paramsOne, String paramsTwo) {
    return repository.authSignInEmailPassword(paramsOne, paramsTwo);
  }

}