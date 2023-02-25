import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_financial/core/usecase/usecase.dart';
import 'package:flutter_financial/domain/repository/firebase_auth_repository.dart';

import '../../../core/error/failure.dart';

class FirebaseAuthSignOut {

  final FirebaseAuthRepository repository;

  FirebaseAuthSignOut({
    required this.repository
  });

  Future<Either<Failure, void>> execute() async {
    return await repository.authSignOut();
  }

}