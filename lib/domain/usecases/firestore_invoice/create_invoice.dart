import 'package:dartz/dartz.dart';
import 'package:flutter_financial/core/error/failure.dart';
import 'package:flutter_financial/data/model/invoice_model.dart';
import 'package:flutter_financial/domain/repository/firestore_invoice_repository.dart';
import 'package:injectable/injectable.dart';

@prod
@lazySingleton
@injectable
class FirestoreCreateInvoice {

  final FirestoreInvoiceRepository repository;

  FirestoreCreateInvoice({
    required this.repository
  });

  Future<Either<Failure, void>> execute(InvoiceModel invoice) async {
    return await repository.createInvoice(invoice);
  }

}