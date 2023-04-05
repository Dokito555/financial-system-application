import 'package:flutter/material.dart';
import 'package:flutter_financial/domain/usecases/firestore_transaction_log/add_transaction_log.dart';
import 'package:flutter_financial/domain/usecases/firestore_transaction_log/get_failed_transaction_log.dart';
import 'package:flutter_financial/domain/usecases/firestore_transaction_log/get_successful_transaction_log.dart';
import 'package:flutter_financial/domain/usecases/firestore_transaction_log/get_transaction_log.dart';
import 'package:flutter_financial/presentation/pages/transaction_log/components/failed_log.dart';
import 'package:flutter_financial/presentation/pages/transaction_log/components/successful_log.dart';
import 'package:injectable/injectable.dart';

import '../../core/utility/state_enum.dart';
import '../../data/model/invoice_model.dart';

@injectable
class FirestoreTransactionLogNotifier extends ChangeNotifier {

  FirestoreAddTransactionLog firestoreAddTransactionLog;
  FirestoreGetTransactionsLog firestoreGetTransactionsLog;
  FirestoreGetFailedTransactionsLog firestoreGetFailedTransactionsLog;
  FirestoreGetSuccessfulTransactionLog firestoreGetSuccessfulTransactionLog;

  FirestoreTransactionLogNotifier({
    required this.firestoreAddTransactionLog,
    required this.firestoreGetTransactionsLog,
    required this.firestoreGetFailedTransactionsLog,
    required this.firestoreGetSuccessfulTransactionLog
  });

  late Status _addTransactionLogStatus;
  Status get addTransactionLogStatus => _addTransactionLogStatus;

  late Status _addFailedTransactionLogStatus;
  Status get addFailedTransactionLogStatus => _addFailedTransactionLogStatus;

  Status _getTransactionLogStatus = Status.Empty;
  Status get getTransactionLogStatus => _getTransactionLogStatus;

  List<InvoiceModel> _transactionsLog = [];
  List<InvoiceModel> get transactionsLog => _transactionsLog;

  List<InvoiceModel> _failedTransactions = [];
  List<InvoiceModel> get failedTransactions => _failedTransactions;

  Status _failedTransactionsStatus = Status.Empty;
  Status get failedTransactionStatus => _failedTransactionsStatus;

  List<InvoiceModel> _successfulTransactions = [];
  List<InvoiceModel> get successfulTransactions => _successfulTransactions;

  Status _successTransactionsStatus = Status.Empty;
  Status get successTransactionStatus => _successTransactionsStatus;

  String _message = "";
  String get message => _message;

  int _totalTransactionLog = 0;
  int get totalTransactionLog => _totalTransactionLog;

  Status _totalTransactionLogStatus = Status.Empty;
  Status get totalTransactionLogStatus => _totalTransactionLogStatus;

  double _successfulPercentage = 0;
  double get successfulPercentage => _successfulPercentage;

  double _failedPercentage = 0;
  double get failedPercentage => _failedPercentage;

  Future<void> addTransactionLog({
    required InvoiceModel invoice
  }) async {
    _addTransactionLogStatus = Status.Loading;
    notifyListeners();
    final result = await firestoreAddTransactionLog.execute(invoice);
    result.fold(
      (failure) {
      _addTransactionLogStatus = Status.Error;
      _message = failure.message;
    },
      (result) {
        _addTransactionLogStatus = Status.Success;
        _message = 'Added';
        notifyListeners();
      }
    );
  }

  Future<void> getTransactionsLog() async {
    _getTransactionLogStatus = Status.Loading;
    _failedTransactionsStatus = Status.Loading;
    _successTransactionsStatus = Status.Loading;
    notifyListeners();
    final result = await firestoreGetTransactionsLog.execute();
    result.fold(
        (failure) {
        _getTransactionLogStatus = Status.Error;
        _message = failure.message;
        notifyListeners();
      }, 
        (result) {
          _transactionsLog = result;
          _totalTransactionLog = result.length;
          getFailedTransactionLog(_transactionsLog, _totalTransactionLog);
          getSuccessfulTransactionsLog(_transactionsLog, _totalTransactionLog);
          _totalTransactionLogStatus = Status.Success;
          _getTransactionLogStatus = Status.Success;
          _message = 'Completed';
          notifyListeners();
        }
    );
  }

  void getFailedTransactionLog(List<InvoiceModel> invoices, int long) async {
    if (invoices.isEmpty || long == 0) {
      _failedTransactions = [];
      _failedPercentage = 0;
      _failedTransactionsStatus = Status.Success;
      notifyListeners();
    }
    _failedTransactions = invoices.where((i) => i.isSuccess == false).toList();
    _failedPercentage = _failedTransactions.length / _totalTransactionLog * 100;
    _failedTransactionsStatus = Status.Success;
    notifyListeners();
  }

  void getSuccessfulTransactionsLog(List<InvoiceModel> invoices, int long) async {
    if (invoices.isEmpty || long == 0) {
      _successfulTransactions = [];
      _successfulPercentage = 0;
      _successTransactionsStatus = Status.Success;
      notifyListeners();
    }
    _successfulTransactions = invoices.where((i) => i.isSuccess == true).toList();
    _successfulPercentage = _successfulTransactions.length / _totalTransactionLog * 100;
    _successTransactionsStatus = Status.Success;
    notifyListeners();
  }
}