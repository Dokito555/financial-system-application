import 'package:dartz/dartz.dart';
import 'package:flutter_financial/core/error/failure.dart';
import 'package:flutter_financial/domain/repository/firestore_invoice_repository.dart';
import 'package:injectable/injectable.dart';

@prod
@lazySingleton
@injectable
class FirestoreDeleteInvoice {

  final FirestoreInvoiceRepository repository;

  FirestoreDeleteInvoice({
    required this.repository
  });

  Future<Either<Failure, void>> execute(String id) async {
    return await repository.deleteInvoice(id);
  }

}