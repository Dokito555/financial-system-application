import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_financial/core/utility/constants.dart';
import 'package:flutter_financial/data/model/invoice_model.dart';
import 'package:injectable/injectable.dart';

abstract class FirebaseFirestoreTransactionRemoteDataSource {
  Future<void> addTransaction(InvoiceModel invoice);
  Future<List<InvoiceModel>> fetchTransactions();
}

@prod
@LazySingleton(as: FirebaseFirestoreTransactionRemoteDataSource)
class FirebaseFirestoreTransactionRemoteDataSourceImpl extends FirebaseFirestoreTransactionRemoteDataSource {

  final FirebaseFirestore db;

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

}