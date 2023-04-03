import 'package:flutter/material.dart';
import 'package:flutter_financial/core/routes/route_paths.dart';
import 'package:flutter_financial/core/utility/constants.dart';
import 'package:flutter_financial/data/model/invoice_model.dart';
import 'package:flutter_financial/presentation/pages/invoice/components/invoice_card.dart';
import 'package:flutter_financial/presentation/provider/firestore_transaction_log_notifier.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/utility/state_enum.dart';
import '../../components/custom_drawer.dart';
import '../../components/logout_button.dart';
import '../../provider/firestore_invoice_notifier.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({super.key});

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<FirestoreInvoiceNotifier>(context, listen: false)..getInvoices());
  }

  Future<void> checkTransaction(InvoiceModel invoice) async {

    var invoiceNotifier = Provider.of<FirestoreInvoiceNotifier>(context);
    var transactionLogNotifier = Provider.of<FirestoreTransactionLogNotifier>(context);

    final now = DateTime.now();
    if (invoice.expiryDate.isBefore(now)) {
      await invoiceNotifier.deleteInvoice(id: invoice.id);
      await transactionLogNotifier.addTransactionLog(invoice: InvoiceModel(id: invoice.id, invoiceNumber: invoice.invoiceNumber, paymentNumber: invoice.paymentNumber, paymentMethod: invoice.paymentMethod, name: invoice.name, created: invoice.created, startDate: invoice.startDate, expiryDate: invoice.expiryDate, nominal: invoice.nominal, total: invoice.total, isSuccess: false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: AppColorConstants.fillColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Color(0xff777474)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            'Tagihan',
            style: TextStyle(color: Colors.black),
          ),
          actions: const <Widget>[
            
          ],
        ),
        body: Consumer<FirestoreInvoiceNotifier>(
          builder: (context, data, child) {
            final status = data.invoicesStatus;
            if (status == Status.Loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (status == Status.Error) {
              return Center(child: Text(data.message));
            }
            if (status == Status.Empty || data.invoices.isEmpty) {
              return const Center(child: Text('Empty Data'));
            }
            if (status == Status.Success) {
              return Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.invoices.length,
                    itemBuilder: (context, index) {
                      final invoice = data.invoices[index];
                      checkTransaction(invoice);
                      return InvoiceCard(invoice: invoice);
                    },
                  ),
                ),
              );
            }
            return const Center(child: Text('Something\'s wrong please try again'));
          },
        ),
        drawer: const CustomDrawer());
  }
}
