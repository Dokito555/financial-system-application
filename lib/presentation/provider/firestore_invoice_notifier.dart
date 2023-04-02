import 'package:flutter/material.dart';
import 'package:flutter_financial/data/model/invoice_model.dart';
import 'package:flutter_financial/domain/usecases/firestore_invoice/create_invoice.dart';
import 'package:flutter_financial/domain/usecases/firestore_invoice/delete_invoice.dart';
import 'package:flutter_financial/domain/usecases/firestore_invoice/get_invoice.dart';
import 'package:flutter_financial/domain/usecases/firestore_invoice/get_invoice_detail.dart';
import 'package:injectable/injectable.dart';

import '../../core/utility/state_enum.dart';

@injectable
class FirestoreInvoiceNotifier extends ChangeNotifier {

  FirestoreCreateInvoice firestoreCreateInvoice;
  FirestoreDeleteInvoice firestoreDeleteInvoice;
  FirestoreGetInvoices firestoreGetInvoices;
  FirestoreGetInvoiceDetail firestoreGetInvoiceDetail;

  FirestoreInvoiceNotifier({
    required this.firestoreCreateInvoice,
    required this.firestoreDeleteInvoice,
    required this.firestoreGetInvoices,
    required this.firestoreGetInvoiceDetail
  });

  Status _createInvoiceStatus = Status.Empty;
  Status get createInvoiceStatus => _createInvoiceStatus;

  late Status _deleteInvoiceStatus;
  Status get deleteInvoiceStatus => _deleteInvoiceStatus;


  late Status _getInvoiceDetailStatus;
  Status get getInvoiceDetailStatus => _getInvoiceDetailStatus;

  Status _invoicesStatus = Status.Empty;
  Status get invoicesStatus => _invoicesStatus;

  var _invoices = <InvoiceModel>[];
  List<InvoiceModel> get invoices => _invoices;

  late InvoiceModel _invoice;
  InvoiceModel get invoice => _invoice;

  String _message = '';
  String get message => _message;

  Future<void> createInvoice({
    required InvoiceModel invoice
  }) async {
    _createInvoiceStatus = Status.Loading;
    notifyListeners();
    final result = await firestoreCreateInvoice.execute(invoice);
    result.fold(
      (failure) {
        _createInvoiceStatus = Status.Error;
        _message = failure.message;
        notifyListeners();
      },
      (result) {
        _createInvoiceStatus = Status.Success;
        _message = 'Added';
        notifyListeners();
      }
    );
  }

  Future<void> deleteInvoice({
    required String id
  }) async {
    _deleteInvoiceStatus = Status.Loading;
    notifyListeners();
    final result = await firestoreDeleteInvoice.execute(id);
    result.fold(
      (failure) {
        _deleteInvoiceStatus = Status.Error;
        _message = failure.message;
        notifyListeners();
      },
      (result) {
        _deleteInvoiceStatus = Status.Success;
        _message = 'Completed';
        notifyListeners();
      }
    );
  }

  Future<void> getInvoices() async {
    _invoicesStatus = Status.Loading;
    notifyListeners();

    final result = await firestoreGetInvoices.execute();
    result.fold(
      (failure) {
        _invoicesStatus = Status.Error;
        _message = failure.message;
        notifyListeners();
      }, 
      (result) {
        _invoicesStatus = Status.Success;
        _invoices = result;
        _message = 'Completed';
        notifyListeners();
      }
    );
  }

  Future<void> getInvoiceDetail({
    required String invoiceNumber
  }) async {
    _getInvoiceDetailStatus = Status.Loading;
    notifyListeners();
    final result = await firestoreGetInvoiceDetail.execute(invoiceNumber);
    result.fold(
      (failure) {
        _getInvoiceDetailStatus = Status.Error;
        _message = failure.message;
        notifyListeners();
      }, 
      (result) {
        _invoice = result;
        _getInvoiceDetailStatus = Status.Success;
        _message = 'Completed';
        notifyListeners();
      }
    );
  }
  
}