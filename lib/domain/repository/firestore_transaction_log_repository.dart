import 'package:dartz/dartz.dart';
import 'package:flutter_financial/core/error/failure.dart';
import 'package:flutter_financial/data/model/invoice_model.dart';

abstract class FirestoreTransactionLogRepository {
  Future<Either<Failure, void>> addTransactionLog(InvoiceModel invoice);
  Future<Either<Failure, List<InvoiceModel>>> fetchTransactionsLogs();
  Future<Either<Failure, List<InvoiceModel>>> fetchFailedTransactionLog();
  Future<Either<Failure, List<InvoiceModel>>> fetchSuccessfulTransactionLog();
}