import 'package:dartz/dartz.dart';
import 'package:flutter_financial/core/error/failure.dart';
import 'package:flutter_financial/data/model/invoice_model.dart';
import 'package:flutter_financial/domain/repository/firestore_transaction_log_repository.dart';
import 'package:flutter_financial/domain/repository/firestore_transaction_repository.dart';
import 'package:flutter_financial/domain/usecases/firestore_transaction/get_transactions.dart';
import 'package:injectable/injectable.dart';

@prod
@lazySingleton
@Injectable()
class FirestoreGetFailedTransactionsLog {

  final FirestoreTransactionLogRepository repository;

  FirestoreGetFailedTransactionsLog({
    required this.repository
  });

  Future<Either<Failure, List<InvoiceModel>>> execute() async {
    return await repository.fetchFailedTransactionLog();
  }

}