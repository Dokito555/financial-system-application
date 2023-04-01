import 'package:flutter/material.dart';
import 'package:flutter_financial/domain/usecases/firestore_transaction_log/add_transaction_log.dart';
import 'package:flutter_financial/domain/usecases/firestore_transaction_log/get_transaction_log.dart';
import 'package:injectable/injectable.dart';

import '../../core/utility/state_enum.dart';
import '../../data/model/invoice_model.dart';

@injectable
class FirestoreTransactionLogNotifier extends ChangeNotifier {

  FirestoreAddTransactionLog firestoreAddTransactionLog;
  FirestoreGetTransactionsLog firestoreGetTransactionsLog;

  FirestoreTransactionLogNotifier({
    required this.firestoreAddTransactionLog,
    required this.firestoreGetTransactionsLog
  });

  late Status _addTransactionLogStatus;
  Status get addTransactionLogStatus => _addTransactionLogStatus;

  late Status _addFailedTransactionLogStatus;
  Status get addFailedTransactionLogStatus => _addFailedTransactionLogStatus;

  Status _getTransactionLogStatus = Status.Empty;
  Status get getTransactionLogStatus => _getTransactionLogStatus;

  List<InvoiceModel> _transactionsLog = [];
  List<InvoiceModel> get transactionsLog => _transactionsLog;

  String _message = "";
  String get message => _message;

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
          _getTransactionLogStatus = Status.Success;
          _message = 'Completed';
          notifyListeners();
        }
    );
  }

}