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

  late Status _addTransactionStatus;
  Status get addTransactionStatus => _addTransactionStatus;

  late Status _getTransactionsStatus;
  Status get geTransactionStatus => _getTransactionsStatus;

  List<InvoiceModel> _transactions = [];
  List<InvoiceModel> get transactions => _transactions;

  String _message = "";
  String get message => _message;

  late int _todayTransactionTotal;
  int get todayTransactionTotal => _todayTransactionTotal;

  late int _totalNominal;
  int get totalNominal => _totalNominal;

  late int _allTimeTransaction;
  int get allTimeTransaction => _allTimeTransaction;

  Future<void> addTransaction({
    required InvoiceModel invoice
  }) async {
    _addTransactionStatus = Status.Loading;
    notifyListeners();
    final result = await firestoreAddTransaction.execute(invoice);
    result.fold(
      (failure) {
      _addTransactionStatus = Status.Error;
      _message = failure.message;
    },
      (result) {
        _addTransactionStatus = Status.Success;
        _message = 'Added';
        notifyListeners();
      }
    );
  }

  Future<void> getTransactions() async {
    _getTransactionsStatus = Status.Loading;
    notifyListeners();
    final result = await firestoreGetTransactions.execute();
    result.fold(
        (failure) {
        _getTransactionsStatus = Status.Error;
        _message = failure.message;
        notifyListeners();
      }, 
        (result) {
          _transactions = result;
          _allTimeTransaction = result.length;
          _getTransactionsStatus = Status.Success;
          _message = 'Completed';
          notifyListeners();
        }
    );
  }

  Future<void> getTotalNominal() async {
    _addTransactionStatus = Status.Loading;
    notifyListeners();
    final result = await firestoreGetTransactions.execute();
    result.fold(
        (failure) {
        _addTransactionStatus = Status.Error;
        _message = failure.message;
        notifyListeners();
      }, 
        (result) {
          _transactions = result;
          for (var i = 0; i < _transactions.length; i++) {
            _totalNominal += _transactions[i].nominal;
          }
          _message = 'Completed';
          notifyListeners();
        }
    );
  }

}