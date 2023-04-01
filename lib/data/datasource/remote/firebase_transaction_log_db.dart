import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_financial/core/utility/constants.dart';
import 'package:flutter_financial/data/model/invoice_model.dart';
import 'package:injectable/injectable.dart';

abstract class FirebaseFirestoreTransactionLogRemoteDataSource {
  Future<void> addTransactionLog(InvoiceModel invoice);
  Future<List<InvoiceModel>> fetchTransactionsLog();
}

@prod
@LazySingleton(as: FirebaseFirestoreTransactionLogRemoteDataSource)
class FirebaseFirestoreTransactionLogRemoteDataSourceImpl extends FirebaseFirestoreTransactionLogRemoteDataSource {

  final FirebaseFirestore db;
  final FirebaseAuth firebaseAuth;
  FirebaseFirestoreTransactionLogRemoteDataSourceImpl({
    required this.db,
    required this.firebaseAuth
  });

  User? get currentUser => firebaseAuth.currentUser;

  @override
  Future<void> addTransactionLog(InvoiceModel invoice) async {
    await db.collection(firestoreUsers)
    .doc(currentUser!.uid)
    .collection(firestoreTransacitonLog)
    .doc(invoice.id)
    .set(invoice.toJson());
  }

  @override
  Future<List<InvoiceModel>> fetchTransactionsLog() async {
    final snapshot = await db.collection(firestoreUsers)
    .doc(currentUser!.uid)
    .collection(firestoreTransacitonLog)
    .orderBy('created', descending: true)
    .get();
    final data = snapshot.docs.map((e) => InvoiceModel.fromFirestore(e)).toList();
    return data;
  }

}