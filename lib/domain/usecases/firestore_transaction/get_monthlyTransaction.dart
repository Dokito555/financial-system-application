import 'package:dartz/dartz.dart';
import 'package:flutter_financial/data/model/invoice_model.dart';
import 'package:flutter_financial/domain/repository/firestore_transaction_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failure.dart';

@prod
@lazySingleton
@Injectable()
class FirestoreGetMonthlyTransactions {

  final FirestoreTransacitonRepository repository;

  FirestoreGetMonthlyTransactions({
    required this.repository
  });

  Future<Either<Failure, List<InvoiceModel>>> execute() async {
    return await repository.fetchMonthlyTransactions();
  }

}