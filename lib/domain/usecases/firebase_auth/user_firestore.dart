import 'package:dartz/dartz.dart';
import 'package:flutter_financial/core/usecase/usecase.dart';
import 'package:flutter_financial/data/model/user_model.dart';
import 'package:flutter_financial/domain/repository/firebase_auth_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failure.dart';

@prod
@lazySingleton
@Injectable()
class FirebaseStoreUser extends Usecase<Future<Either<Failure, void>>, UserModel> {

  final FirebaseAuthRepository repository;

  FirebaseStoreUser({
    required this.repository
  });

  @override
  Future<Either<Failure, void>> execute(UserModel params) async {
    return await repository.userFirestore(params);
  }

}