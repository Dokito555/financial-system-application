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

  late Status _status;
  Status get status => _status;

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
    _status = Status.Loading;
    notifyListeners();
    final result = await firestoreCreateInvoice.execute(invoice);
    result.fold(
      (failure) {
        _status = Status.Error;
        _message = failure.message;
        notifyListeners();
      },
      (result) {
        _status = Status.Success;
        _message = 'Added';
        notifyListeners();
      }
    );
  }

  Future<void> deleteInvoice({
    required String id
  }) async {
    _status = Status.Loading;
    notifyListeners();
    final result = await firestoreDeleteInvoice.execute(id);
    result.fold(
      (failure) {
        _status = Status.Error;
        _message = failure.message;
        notifyListeners();
      },
      (result) {
        _status = Status.Success;
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
    _status = Status.Loading;
    notifyListeners();
    final result = await firestoreGetInvoiceDetail.execute(invoiceNumber);
    result.fold(
      (failure) {
        _status = Status.Error;
        _message = failure.message;
        notifyListeners();
      }, 
      (result) {
        _invoice = result;
        _status = Status.Success;
        _message = 'Completed';
        notifyListeners();
      }
    );
  }
  
}