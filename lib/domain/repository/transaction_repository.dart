import 'package:dartz/dartz.dart';
import 'package:flutter_financial/common/failure.dart';
import 'package:flutter_financial/domain/enitity/transaction.dart';

abstract class TransactionRepository {
  Future<Either<Failure,Transaction>> saveTransactionToLocalDatabase();
  Future<Either<Failure, Transaction>> getTransactionFromLocalDatabase();
}