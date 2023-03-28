import 'package:dartz/dartz.dart';
import 'package:flutter_financial/core/error/failure.dart';
import 'package:flutter_financial/data/model/invoice_model.dart';
import 'package:flutter_financial/domain/repository/firestore_transaction_log_repository.dart';
import 'package:injectable/injectable.dart';

@prod
@lazySingleton
@Injectable()
class FirestoreAddTransactionLog {

  FirestoreTransactionLogRepository repository;

  FirestoreAddTransactionLog({
    required this.repository
  });

  Future<Either<Failure, void>> execute(InvoiceModel invoice) async {
    return await repository.addTransactionLog(invoice);
  }

}