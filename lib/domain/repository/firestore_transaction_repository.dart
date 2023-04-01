import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../data/model/invoice_model.dart';

abstract class FirestoreTransacitonRepository {
  Future<Either<Failure, void>> addTransaction(InvoiceModel invoice);
  Future<Either<Failure, List<InvoiceModel>>> fetchTransactions();
  Future<Either<Failure, List<InvoiceModel>>> fethcTodayTransactions();
  Future<Either<Failure, List<InvoiceModel>>> fetchMonthlyTransactions();
  Future<Either<Failure, List<InvoiceModel>>> fetchYearlyTransactions();
}