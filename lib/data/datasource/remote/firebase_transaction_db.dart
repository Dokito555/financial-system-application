import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_financial/core/utility/constants.dart';
import 'package:flutter_financial/data/model/invoice_model.dart';
import 'package:injectable/injectable.dart';

abstract class FirebaseFirestoreTransactionRemoteDataSource {
  Future<void> addTransaction(InvoiceModel invoice);
  Future<List<InvoiceModel>> fetchTransactions();
  Future<List<InvoiceModel>> fetchTodayTransactions();
  Future<List<InvoiceModel>> fetchWeeklyTransactions();
  Future<List<InvoiceModel>> fetchYearlyTransactions();
}

@prod
@LazySingleton(as: FirebaseFirestoreTransactionRemoteDataSource)
class FirebaseFirestoreTransactionRemoteDataSourceImpl extends FirebaseFirestoreTransactionRemoteDataSource {

  final FirebaseFirestore db;
  final DateTime todaysDate = DateTime(DateTime.now().day);
  final DateTime monthlyDate = DateTime(DateTime.now().month);
  final DateTime yearlyDate = DateTime(DateTime.now().year);

  FirebaseFirestoreTransactionRemoteDataSourceImpl({
    required this.db
  });
  
  @override
  Future<void> addTransaction(InvoiceModel invoice) async {
    await db.collection(firestoreTransaciton).doc().set(invoice.toJson());
  }
  
  @override
  Future<List<InvoiceModel>> fetchTransactions() async {
    final snapshot = await db.collection(firestoreTransaciton).get();
    print(snapshot);
    final data = snapshot.docs.map((e) => InvoiceModel.fromFirestore(e)).toList();
    return data;
  }
  
  @override
  Future<List<InvoiceModel>> fetchTodayTransactions() {
    // TODO: implement fetchTodayTransactions
    throw UnimplementedError();
  }
  
  @override
  Future<List<InvoiceModel>> fetchWeeklyTransactions() {
    // TODO: implement fetchWeeklyTransactions
    throw UnimplementedError();
  }
  
  @override
  Future<List<InvoiceModel>> fetchYearlyTransactions() {
    // TODO: implement fetchYearlyTransactions
    throw UnimplementedError();
  }

}