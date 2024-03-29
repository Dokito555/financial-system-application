import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final FirebaseAuth firebaseAuth;
  FirebaseFirestoreInvoiceDatabaseRemoteDataSourceImpl({
    required this.db,
    required this.firebaseAuth
  });

   User? get currentUser => firebaseAuth.currentUser;

  @override
  Future<void> createInvoice(InvoiceModel invoice) async {
    await db.collection(firestoreUsers)
    .doc(currentUser!.uid)
    .collection(firestoreInvoice)
    .doc(invoice.id)
    .set(invoice.toJson());
  }

  @override
  Future<void> deleteInvoice(String id) async { 
    await db.collection(firestoreUsers)
    .doc(currentUser!.uid)
    .collection(firestoreInvoice)
    .doc(id)
    .delete();
  }
  
  @override
  Future<List<InvoiceModel>> fetchInvoices() async {
    final snapshot = await db.collection(firestoreUsers)
    .doc(currentUser!.uid)
    .collection(firestoreInvoice)
    .orderBy('created', descending: true)
    .get();
    final data = snapshot.docs.map((e) => InvoiceModel.fromFirestore(e)).toList();
    return data;
  }
  
  @override
  Future<InvoiceModel> fetchInvoiceDetail(String invoiceNumber) async {
    final snapshot = await db.collection(firestoreInvoice).where("InvoiceNumber", isEqualTo: invoiceNumber).get();
    final data = snapshot.docs.map((e) => InvoiceModel.fromFirestore(e)).single;
    return data;
  }

}