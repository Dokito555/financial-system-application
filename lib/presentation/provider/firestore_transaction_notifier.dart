import 'package:flutter/material.dart';
import 'package:flutter_financial/core/utility/state_enum.dart';
import 'package:flutter_financial/data/model/invoice_model.dart';
import 'package:flutter_financial/domain/usecases/firestore_transaction/add_transaction.dart';
import 'package:flutter_financial/domain/usecases/firestore_transaction/get_monthlyTransaction.dart';
import 'package:flutter_financial/domain/usecases/firestore_transaction/get_todaysTransaction.dart';
import 'package:flutter_financial/domain/usecases/firestore_transaction/get_transactions.dart';
import 'package:flutter_financial/domain/usecases/firestore_transaction/get_yearlyTransaction.dart';
import 'package:flutter_financial/presentation/pages/dashboard/components/total_nominal.dart';
import 'package:injectable/injectable.dart';

@injectable
class FirestoreTransactionNotifier extends ChangeNotifier {

  FirestoreAddTransaction firestoreAddTransaction;
  FirestoreGetTransactions firestoreGetTransactions;
  FirestoreGetTodaysTransactions firestoreGetTodaysTransactions;
  FirestoreGetMonthlyTransactions firestoreGetMonthlyTransactions;
  FirestoreGetYearlyTransactions firestoreGetYearlyTransactions;

  FirestoreTransactionNotifier({
    required this.firestoreAddTransaction,
    required this.firestoreGetTransactions,
    required this.firestoreGetTodaysTransactions,
    required this.firestoreGetMonthlyTransactions,
    required this.firestoreGetYearlyTransactions
  });

  late Status _addTransactionStatus;
  Status get addTransactionStatus => _addTransactionStatus;

  Status _getTransactionsStatus = Status.Empty;
  Status get geTransactionStatus => _getTransactionsStatus;

  List<InvoiceModel> _transactions = [];
  List<InvoiceModel> get transactions => _transactions;

  Status _getTodaysTransactionStatus = Status.Empty;
  Status get getTodaysTransactionStatus => _getTodaysTransactionStatus;

  List<InvoiceModel> _todaysTransaction = [];
  List<InvoiceModel> get todaysTransaction => _todaysTransaction;

  Status _getMonthlyTransactionStatus = Status.Empty;
  Status get geMonthlyTransactionStatus => _getMonthlyTransactionStatus;

  List<InvoiceModel> _monthlyTransaction = [];
  List<InvoiceModel> get monthlyTransaction => _monthlyTransaction;

  Status _getYearlyTransactionStatus = Status.Empty;
  Status get getYearlyTransactionStatus => _getYearlyTransactionStatus;

  List<InvoiceModel> _yearlyTransaction = [];
  List<InvoiceModel> get yearlyTransaction => _yearlyTransaction;

  String _message = "";
  String get message => _message;

  late int _todayTransactionTotal;
  int get todayTransactionTotal => _todayTransactionTotal;

  int _totalNominal = 0;
  int get totalNominal => _totalNominal;

  Status _getTotalNominalStatus = Status.Empty;
  Status get getTotalNominalStatus => _getTotalNominalStatus;

  int _allTimeTransaction = 0;
  int get allTimeTransaction => _allTimeTransaction;

  int _todaysTransactionLength = 0;
  int get todaysTransactionLength => _todaysTransactionLength;

  int _monthlyTransactionLenght = 0;
  int get monthlyTransactionLenght => _monthlyTransactionLenght;

  int _yearlyTransactionLenght = 0;
  int get yearlyTransactionLenght => _yearlyTransactionLenght;


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
    if (_transactions.isEmpty) {
      _getTransactionsStatus = Status.Empty;
      _message = 'Empty Data';
      notifyListeners();
    }
  }

  Future<void> getTotalNominal() async {
    _getTotalNominalStatus = Status.Loading;
    notifyListeners();
    final result = await firestoreGetTransactions.execute();
    result.fold(
        (failure) {
        _getTotalNominalStatus = Status.Error;
        _message = failure.message;
        notifyListeners();
      }, 
        (result) {
          _transactions = result;
          for (var i = 0; i < _transactions.length; i++) {
            _totalNominal += _transactions[i].total;
          }
          _getTotalNominalStatus = Status.Success;
          _message = 'Completed';
          notifyListeners();
        }
    );
  }

  Future<void> getTodaysTransaction() async {
    _getTodaysTransactionStatus = Status.Loading;
    notifyListeners();
    final result = await firestoreGetTodaysTransactions.execute();
    result.fold(
        (failure) {
          _getTodaysTransactionStatus = Status.Error;
          _message = failure.message;
          notifyListeners();
        }, 
        (result) {
          _todaysTransaction = result;
          _todaysTransactionLength = result.length;
          _getTodaysTransactionStatus = Status.Success;
          _message = 'Completed';
          notifyListeners();
      }
    );
    if (_todaysTransaction.isEmpty) {
      _getTodaysTransactionStatus == Status.Empty;
      _message = 'Empty Data';
      notifyListeners();
    }
  }

  Future<void> getMonthlyTransaction() async {
    _getMonthlyTransactionStatus = Status.Loading;
    notifyListeners();
    final result = await firestoreGetMonthlyTransactions.execute();
    result.fold(
        (failure) {
          _getMonthlyTransactionStatus = Status.Error;
          _message = failure.message;
          notifyListeners();
        }, 
        (result) {
          _monthlyTransaction = result;
          _monthlyTransactionLenght = result.length;
          _getMonthlyTransactionStatus = Status.Success;
          _message = 'Completed';
          notifyListeners();
      }
    );
    if (_monthlyTransaction.isEmpty) {
      _getMonthlyTransactionStatus = Status.Empty;
     _message = 'Empty Data';
    notifyListeners();
    } 
  }

  Future<void> getYearlyTransaction() async {
    _getYearlyTransactionStatus = Status.Loading;
    notifyListeners();
    final result = await firestoreGetYearlyTransactions.execute();
    result.fold(
        (failure) {
          _getYearlyTransactionStatus = Status.Error;
          _message = failure.message;
          notifyListeners();
        }, 
        (result) {
          _yearlyTransaction = result;
          _yearlyTransactionLenght = result.length;
          
          _getYearlyTransactionStatus = Status.Success;
          _message = 'Completed';
          notifyListeners();
      }
    );
    if (_yearlyTransaction.isEmpty) {
      _getYearlyTransactionStatus = Status.Empty;
      _message = 'Empty Data';
       notifyListeners();
    }
  }

}