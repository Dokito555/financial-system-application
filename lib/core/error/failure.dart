import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerException extends Failure {
  ServerException(super.message);
}

class ConnectionFailure extends Failure {
  ConnectionFailure(super.message);
}

class DatabaseFailure extends Failure {
  DatabaseFailure(super.message);
}

class FirebaseFailure extends Failure {
  FirebaseFailure(super.message);
}