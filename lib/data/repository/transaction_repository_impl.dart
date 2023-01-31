import 'package:flutter_financial/domain/enitity/transaction.dart';
import 'package:flutter_financial/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_financial/domain/repository/transaction_repository.dart';

class TransactionRepositoryImpl extends TransactionRepository {
  
  @override
  Future<Either<Failure, Transaction>> getTransactionFromLocalDatabase() {
    // TODO: implement getTransactionFromLocalDatabase
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Transaction>> saveTransactionToLocalDatabase() {
    // TODO: implement saveTransactionToLocalDatabase
    throw UnimplementedError();
  }
  
}