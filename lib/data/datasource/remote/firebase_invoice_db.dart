import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_financial/core/utility/constants.dart';
import 'package:flutter_financial/data/model/invoice_model.dart';
import 'package:injectable/injectable.dart';

abstract class FirebaseFirestoreInvoiceDatabaseRemoteDataSource {
  Future<void> createInvoice(InvoiceModel invoice);
  Future<void> deleteInvoice(String id);
  Future<List<InvoiceModel>> fetchInvoices();
  Future<InvoiceModel> fetchInvoiceDetail(String invoiceNumber);
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
    await db.collection(firestoreInvoice).doc().set(invoice.toJson());
  }

  @override
  Future<void> deleteInvoice(String id) async { 
    await db.collection(firestoreInvoice).doc(id).delete();
  }
  
  @override
  Future<List<InvoiceModel>> fetchInvoices() async {
    final snapshot = await db.collection(firestoreInvoice).get();
    print(snapshot);
    final data = snapshot.docs.map((e) => InvoiceModel.fromFirestore(e)).toList();
    print(data);
    return data;
  }
  
  @override
  Future<InvoiceModel> fetchInvoiceDetail(String invoiceNumber) async {
    final snapshot = await db.collection(firestoreInvoice).where("InvoiceNumber", isEqualTo: invoiceNumber).get();
    print(snapshot);
    final data = snapshot.docs.map((e) => InvoiceModel.fromFirestore(e)).single;
    print(data);
    return data;
  }

}