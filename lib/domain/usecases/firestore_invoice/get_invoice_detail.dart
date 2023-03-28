import 'package:dartz/dartz.dart';
import 'package:flutter_financial/data/model/invoice_model.dart';
import 'package:flutter_financial/domain/repository/firestore_invoice_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failure.dart';

@prod
@lazySingleton
@Injectable()
class FirestoreGetInvoiceDetail {

  final FirestoreInvoiceRepository repository;

  FirestoreGetInvoiceDetail({
    required this.repository
  });

  Future<Either<Failure, InvoiceModel>> execute(String invoiceNumber) async {
    return await repository.fetchInvoiceDetail(invoiceNumber);
  }

}