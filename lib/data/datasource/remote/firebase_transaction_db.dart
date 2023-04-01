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
  final DateTime todaysDate = DateTime(DateTime.now().day);
  final DateTime tomorrowsDate = DateTime.now().add(const Duration(days:1));
  final DateTime monthlyDate = DateTime(DateTime.now().month);
  final DateTime yearlyDate = DateTime(DateTime.now().year);

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
    final snapshot = await db.collection(firestoreUsers)
    .doc(currentUser!.uid)
    .collection(firestoreTransaction)
    .where('created', isGreaterThan: todaysDate, isLessThan: tomorrowsDate)
    .get();
    final data = snapshot.docs.map((e) => InvoiceModel.fromFirestore(e)).toList();
    return data;
  }
  
  @override
  Future<List<InvoiceModel>> fetchMonthlyTransactions() async {
    final snapshot = await db.collection(firestoreUsers)
    .doc(currentUser!.uid)
    .collection(firestoreTransaction)
    .where('created', isGreaterThan: monthlyDate, isLessThan: tomorrowsDate)
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
    .where('created', isGreaterThan: yearlyDate, isLessThan: tomorrowsDate)
    .orderBy('created', descending: true)
    .get();
    final data = snapshot.docs.map((e) => InvoiceModel.fromFirestore(e)).toList();
    return data;
  }

}