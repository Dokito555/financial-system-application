import 'package:dartz/dartz.dart';
import 'package:flutter_financial/core/error/failure.dart';
import 'package:flutter_financial/core/usecase/usecase.dart';
import 'package:flutter_financial/domain/repository/firebase_auth_repository.dart';
import 'package:injectable/injectable.dart';

@prod
@lazySingleton
@injectable
class FirebaseAuthResetPassword extends Usecase<Future<Either<Failure, void>>, String> {

  final FirebaseAuthRepository repository;

  FirebaseAuthResetPassword({
    required this.repository
  });
  
  @override
  Future<Either<Failure, void>> execute(String params) async {
    return await repository.resetPassword(params);
  }

}