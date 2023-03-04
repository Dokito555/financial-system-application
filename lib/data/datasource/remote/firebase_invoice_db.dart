import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_financial/core/utility/constants.dart';
import 'package:flutter_financial/data/model/invoice_model.dart';
import 'package:injectable/injectable.dart';

abstract class FirebaseFirestoreInvoiceDatabaseRemoteDataSource {
  Future<void> createInvoice(InvoiceModel invoice);
  
}

@prod
@LazySingleton(as: FirebaseFirestoreInvoiceDatabaseRemoteDataSource)
class FirebaseFirestoreInvoiceDatabaseRemoteDataSourceImpl extends FirebaseFirestoreInvoiceDatabaseRemoteDataSource {

  final FirebaseFirestore db;

  FirebaseFirestoreInvoiceDatabaseRemoteDataSourceImpl({
    required this.db
  });

  @override
  Future<void> createInvoice(InvoiceModel invoice) async {
    db.collection(firestoreInvoice).doc().set(invoice.toJson());
    print('CREATE INVOICE IN FIRESTORE ======> ${db.collection(firestoreInvoice).doc().set(invoice.toJson())}');
  }

}