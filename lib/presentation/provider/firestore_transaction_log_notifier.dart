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

  late Status _status;
  Status get status => _status;

  List<InvoiceModel> _transactionsLog = [];
  List<InvoiceModel> get transactionsLog => _transactionsLog;

  String _message = "";
  String get message => _message;

  Future<void> addTransactionLog({
    required InvoiceModel invoice
  }) async {
    _status = Status.Loading;
    notifyListeners();
    final result = await firestoreAddTransactionLog.execute(invoice);
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

  Future<void> getTransactionsLog() async {
    _status = Status.Loading;
    notifyListeners();
    final result = await firestoreGetTransactionsLog.execute();
    result.fold(
        (failure) {
        _status = Status.Error;
        _message = failure.message;
        notifyListeners();
      }, 
        (result) {
          _transactionsLog = result;
          _status = Status.Success;
          _message = 'Completed';
          notifyListeners();
        }
    );
  }

}