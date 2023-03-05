import 'package:dartz/dartz.dart';
import 'package:flutter_financial/data/model/invoice_model.dart';

import '../../core/error/failure.dart';

abstract class FirestoreInvoiceRepository {
  Future<Either<Failure, void>> createInvoice(InvoiceModel invoice);
  Future<Either<Failure, void>> deleteInvoice(String id);
}