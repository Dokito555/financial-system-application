import 'package:dartz/dartz.dart';
import 'package:flutter_financial/core/error/failure.dart';
import 'package:flutter_financial/domain/repository/firebase_auth_repository.dart';
import 'package:injectable/injectable.dart';

@prod
@lazySingleton
@injectable
class FirebaseAuthSignOut {

  final FirebaseAuthRepository repository;

  FirebaseAuthSignOut({
    required this.repository
  });

  Future<Either<Failure, void>> execute() async {
    return await repository.authSignOut();
  }

}