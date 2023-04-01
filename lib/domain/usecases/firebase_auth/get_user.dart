import 'package:dartz/dartz.dart';
import 'package:flutter_financial/data/model/user_model.dart';
import 'package:flutter_financial/domain/repository/firebase_auth_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failure.dart';

@prod
@lazySingleton
@injectable
class FirebaseGetUser {

  final FirebaseAuthRepository repository;

  FirebaseGetUser({
    required this.repository
  });

  Future<Either<Failure, UserModel>> execute() async {
    return await repository.getUser();
  }

}