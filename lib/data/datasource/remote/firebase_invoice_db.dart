import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_financial/core/utility/constants.dart';
import 'package:flutter_financial/data/model/invoice_model.dart';
import 'package:injectable/injectable.dart';

abstract class FirebaseFirestoreInvoiceDatabaseRemoteDataSource {
  Future<void> createInvoice(InvoiceModel invoice);
  Future<void> deleteInvoice(String id);
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

    // ugly ass bulging code 🤮
    // Bad code need to fix this
    InvoiceModel invoiceRef = InvoiceModel(
      id: db.collection(firestoreInvoice).id,
      invoiceNumber: invoice.invoiceNumber, 
      paymentNumber: invoice.paymentNumber, 
      paymentMethod: invoice.paymentMethod, 
      name: invoice.name, 
      email: invoice.email,
      phoneNumber: invoice.phoneNumber,
      address: invoice.address,
      created: invoice.created, 
      startDate: invoice.startDate, 
      expiryDate: invoice.expiryDate, 
      description: invoice.description,
      nominal: invoice.nominal, 
      quantity: invoice.quantity,
      total: invoice.total
    );

    await db.collection(firestoreInvoice).doc().set(invoiceRef.toJson());
  }

  @override
  Future<void> deleteInvoice(String id) async {
    await db.collection(firestoreInvoice).doc(id).delete();
  }

}