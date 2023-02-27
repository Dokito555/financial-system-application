import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_financial/core/usecase/usecase.dart';
import 'package:flutter_financial/domain/repository/firebase_auth_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failure.dart';

@prod
@lazySingleton
@injectable
class FirebaseAuthSignUp extends UsecaseTwoParams<Future<Either<Failure, UserCredential>>, String, String> {

  final FirebaseAuthRepository repository;

  FirebaseAuthSignUp({
    required this.repository
  });
  
  @override
  Future<Either<Failure, UserCredential>> execute(String paramsOne, String paramsTwo) async {
    return await repository.authSignUpEmailPassword(paramsOne, paramsTwo);
  }

}