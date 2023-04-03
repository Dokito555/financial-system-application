import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_financial/core/utility/constants.dart';
import 'package:flutter_financial/data/model/invoice_model.dart';
import 'package:injectable/injectable.dart';

abstract class FirebaseFirestoreTransactionRemoteDataSource {
  Future<void> addTransaction(InvoiceModel invoice);
  Future<List<InvoiceModel>> fetchTransactions();
  Future<List<InvoiceModel>> fetchTodayTransactions();
  Future<List<InvoiceModel>> fetchMonthlyTransactions();
  Future<List<InvoiceModel>> fetchYearlyTransactions();
}

@prod
@LazySingleton(as: FirebaseFirestoreTransactionRemoteDataSource)
class FirebaseFirestoreTransactionRemoteDataSourceImpl extends FirebaseFirestoreTransactionRemoteDataSource {

  final FirebaseFirestore db;
  final FirebaseAuth firebaseAuth;
  final DateTime lastMonth = DateTime(DateTime.now().year, DateTime.now().month - 1, DateTime.now().day);
  final DateTime yesterday = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 1);
  final DateTime yearlyDate = DateTime(DateTime.now().year - 1, DateTime.now().month, DateTime.now().day);

  FirebaseFirestoreTransactionRemoteDataSourceImpl({
    required this.db,
    required this.firebaseAuth
  });

  User? get currentUser => firebaseAuth.currentUser;
  
  @override
  Future<void> addTransaction(InvoiceModel invoice) async {
    await db.collection(firestoreUsers)
    .doc(currentUser!.uid)
    .collection(firestoreTransaction)
    .doc(invoice.id)
    .set(invoice.toJson());
  }
  
  @override
  Future<List<InvoiceModel>> fetchTransactions() async {
    final snapshot = await db.collection(firestoreUsers)
    .doc(currentUser!.uid)
    .collection(firestoreTransaction)
    .orderBy('created', descending: true)
    .get();
    final data = snapshot.docs.map((e) => InvoiceModel.fromFirestore(e)).toList();
    return data;
  }
  
  @override
  Future<List<InvoiceModel>> fetchTodayTransactions() async {
    print(yesterday);
    final snapshot = await db.collection(firestoreUsers)
    .doc(currentUser!.uid)
    .collection(firestoreTransaction)
    .where('created', isGreaterThanOrEqualTo: yesterday.toString())
    .orderBy('created', descending: true)
    .get();
    final data = snapshot.docs.map((e) => InvoiceModel.fromFirestore(e)).toList();
    return data;
  }
  
  @override
  Future<List<InvoiceModel>> fetchMonthlyTransactions() async {
    final snapshot = await db.collection(firestoreUsers)
    .doc(currentUser!.uid)
    .collection(firestoreTransaction)
    .where('created', isGreaterThanOrEqualTo: lastMonth.toString())
    .orderBy('created', descending: true)
    .get();
    final data = snapshot.docs.map((e) => InvoiceModel.fromFirestore(e)).toList();
    return data;
  }
  
  @override
  Future<List<InvoiceModel>> fetchYearlyTransactions() async {
    final snapshot = await db.collection(firestoreUsers)
    .doc(currentUser!.uid)
    .collection(firestoreTransaction)
    .where('created', isGreaterThan: yearlyDate.toString())
    .orderBy('created', descending: true)
    .get();
    final data = snapshot.docs.map((e) => InvoiceModel.fromFirestore(e)).toList();
    return data;
  }

}