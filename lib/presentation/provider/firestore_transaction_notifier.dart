import 'package:flutter/material.dart';
import 'package:flutter_financial/core/utility/state_enum.dart';
import 'package:flutter_financial/data/model/invoice_model.dart';
import 'package:flutter_financial/domain/usecases/firestore_transaction/add_transaction.dart';
import 'package:flutter_financial/domain/usecases/firestore_transaction/get_transactions.dart';
import 'package:injectable/injectable.dart';

@injectable
class FirestoreTransactionNotifier extends ChangeNotifier {

  FirestoreAddTransaction firestoreAddTransaction;
  FirestoreGetTransactions firestoreGetTransactions;

  FirestoreTransactionNotifier({
    required this.firestoreAddTransaction,
    required this.firestoreGetTransactions
  });

  late Status _status;
  Status get status => _status;

  List<InvoiceModel> _transactions = [];
  List<InvoiceModel> get transactions => _transactions;

  String _message = "";
  String get message => _message;

  Future<void> addTransaction({
    required InvoiceModel invoice
  }) async {
    _status = Status.Loading;
    notifyListeners();
    final result = await firestoreAddTransaction.execute(invoice);
    result.fold(
      (failure) {
      _status = Status.Error;
      _message = failure.message;
    },
      (result) {
        _status = Status.Success;
        _message = 'Added';
        notifyListeners();
      }
    );
  }

  Future<void> getTransactions() async {
    _status = Status.Loading;
    notifyListeners();
    final result = await firestoreGetTransactions.execute();
    result.fold(
        (failure) {
        _status = Status.Error;
        _message = failure.message;
        notifyListeners();
      }, 
        (result) {
          _transactions = result;
          _status = Status.Success;
          _message = 'Completed';
          notifyListeners();
        }
    );
  }

}