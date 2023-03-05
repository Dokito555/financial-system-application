import 'package:flutter/material.dart';
import 'package:flutter_financial/data/model/invoice_model.dart';
import 'package:flutter_financial/domain/usecases/firestore_invoice/create_invoice.dart';
import 'package:flutter_financial/domain/usecases/firestore_invoice/delete_invoice.dart';
import 'package:injectable/injectable.dart';

import '../../core/utility/state_enum.dart';

@injectable
class FirestoreInvoiceNotifier extends ChangeNotifier {

  FirestoreCreateInvoice firestoreCreateInvoice;
  FirestoreDeleteInvoice firestoreDeleteInvoice;

  FirestoreInvoiceNotifier({
    required this.firestoreCreateInvoice,
    required this.firestoreDeleteInvoice
  });

  late Status _status;
  Status get status => _status;

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
  
}