import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_financial/core/utility/constants.dart';
import 'package:flutter_financial/data/model/invoice_model.dart';

abstract class FirebaseFirestoreTransactionLogRemoteDataSource {
  Future<void> addTransactionLog(InvoiceModel invoice);
  Future<List<InvoiceModel>> fetchTransactionsLog();
}

class FirebaseFirestoreTransactionLogRemoteDataSourceImpl extends FirebaseFirestoreTransactionLogRemoteDataSource {

  final FirebaseFirestore db;

  FirebaseFirestoreTransactionLogRemoteDataSourceImpl({
    required this.db
  });

  @override
  Future<void> addTransactionLog(InvoiceModel invoice) async {
    await db.collection(firestoreTransacitonLog).doc().set(invoice.toJson());
  }

  @override
  Future<List<InvoiceModel>> fetchTransactionsLog() async {
    final snapshot = await db.collection(firestoreTransacitonLog).get();
    print(snapshot);
    final data = snapshot.docs.map((e) => InvoiceModel.fromFirestore(e)).toList();
    print(data);
    return data;
  }

}