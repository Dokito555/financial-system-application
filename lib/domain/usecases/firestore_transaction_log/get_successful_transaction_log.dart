import 'package:dartz/dartz.dart';
import 'package:flutter_financial/data/model/invoice_model.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failure.dart';
import '../../repository/firestore_transaction_log_repository.dart';


@prod
@lazySingleton
@Injectable()
class FirestoreGetSuccessfulTransactionLog {

  final FirestoreTransactionLogRepository repository;

  FirestoreGetSuccessfulTransactionLog({
    required this.repository
  });

  Future<Either<Failure, List<InvoiceModel>>> execute() async {
    return await repository.fetchSuccessfulTransactionLog();
  }

}