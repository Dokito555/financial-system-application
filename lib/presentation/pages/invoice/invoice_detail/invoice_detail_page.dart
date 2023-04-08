import 'package:flutter/material.dart';
import 'package:flutter_financial/core/routes/route_paths.dart';
import 'package:flutter_financial/core/utility/constants.dart';
import 'package:flutter_financial/core/utility/state_enum.dart';
import 'package:flutter_financial/data/model/invoice_model.dart';
import 'package:flutter_financial/presentation/components/show_toast.dart';
import 'package:flutter_financial/presentation/provider/firestore_invoice_notifier.dart';
import 'package:flutter_financial/presentation/provider/firestore_transaction_log_notifier.dart';
import 'package:flutter_financial/presentation/provider/firestore_transaction_notifier.dart';
import 'package:provider/provider.dart';


class InvoiceDetailPage extends StatefulWidget {
  InvoiceModel invoice;

  InvoiceDetailPage({super.key, required this.invoice});

  @override
  State<InvoiceDetailPage> createState() => _InvoiceDetailPageState();
}

class _InvoiceDetailPageState extends State<InvoiceDetailPage> {
  @override
  Widget build(BuildContext context) {
    final invoice = widget.invoice;

    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: AppColorConstants.fillColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Color(0xff777474)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            'Invoice',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Tagihan Untuk', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                        SizedBox(height: 20,),
                        Text('${invoice.name}', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
                        Text('${invoice.email}', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),),
                        Text('${invoice.address}', style: TextStyle(color: Colors.grey),),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text('Invoice Date :', style: const TextStyle(color: AppColorConstants.primaryColor)),
                            SizedBox(width: 60,),
                            Text('${invoice.startDate}')
                          ],
                        ),
                        Row(
                          children: [
                            Text('Payment Method :', style: const TextStyle(color: AppColorConstants.primaryColor)),
                            SizedBox(width: 30,),
                            Text('${invoice.paymentMethod}',)
                          ],
                        ),
                        Row(
                          children: [
                            Text('Due Date :', style: const TextStyle(color: AppColorConstants.primaryColor)),
                            SizedBox(width: 80,),
                            Text('${invoice.expiryDate}')
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text('Sub Total'),
                            SizedBox(width: 60,),
                            Text('${invoice.nominal}')
                          ],
                        ),
                        Row(
                          children: [
                            Text('Total'),
                            SizedBox(width: 90,),
                            Text('${invoice.total}',)
                          ],
                        ),
                        SizedBox(height: 30),
                        _confirmTransaction(context, invoice)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget _confirmTransaction(BuildContext context, InvoiceModel invoice) {
    var transactionNotifier =
        Provider.of<FirestoreTransactionNotifier>(context, listen: false);
    var transactionLogNotifier =
        Provider.of<FirestoreTransactionLogNotifier>(context, listen: false);
    var invoiceNotifier =
        Provider.of<FirestoreInvoiceNotifier>(context, listen: false);

    Future<void> _confirm(InvoiceModel invoice) async {
      //add more property
      await transactionNotifier.addTransaction(
          invoice: InvoiceModel(
              id: invoice.id,
              invoiceNumber: invoice.invoiceNumber,
              paymentNumber: invoice.paymentNumber,
              paymentMethod: invoice.paymentMethod,
              name: invoice.name,
              created: invoice.created,
              startDate: invoice.startDate,
              expiryDate: invoice.expiryDate,
              nominal: invoice.nominal,
              total: invoice.total,
              isSuccess: true,
              email: invoice.email,
              phoneNumber: invoice.phoneNumber,
              address: invoice.address,
              description: invoice.description));
      await transactionLogNotifier.addTransactionLog(
          invoice: InvoiceModel(
              id: invoice.id,
              invoiceNumber: invoice.invoiceNumber,
              paymentNumber: invoice.paymentNumber,
              paymentMethod: invoice.paymentMethod,
              name: invoice.name,
              created: invoice.created,
              startDate: invoice.startDate,
              expiryDate: invoice.expiryDate,
              nominal: invoice.nominal,
              total: invoice.total,
              isSuccess: true,
              email: invoice.email,
              phoneNumber: invoice.phoneNumber,
              address: invoice.address,
              description: invoice.description));
      await invoiceNotifier.deleteInvoice(id: invoice.id);

      if (transactionNotifier.addTransactionStatus == Status.Error ||
          invoiceNotifier.deleteInvoiceStatus == Status.Error ||
          transactionLogNotifier.addTransactionLogStatus == Status.Error) {
        ShowToast.toast(transactionNotifier.message);
      } else if (transactionNotifier.addTransactionStatus == Status.Success &&
          invoiceNotifier.deleteInvoiceStatus == Status.Success &&
          transactionLogNotifier.addTransactionLogStatus == Status.Success) {
        ShowToast.toast(transactionNotifier.message);
        if (!context.mounted) return;
        Navigator.pushReplacementNamed(context, AppRoutePaths.invoicePageRoute);
      } else {
        ShowToast.toast(
            '${transactionNotifier.message} & ${invoiceNotifier.message}');
      }
    }

    return transactionNotifier.addTransactionStatus == Status.Success &&
            invoiceNotifier.deleteInvoiceStatus == Status.Success &&
            transactionLogNotifier.addTransactionLogStatus == Status.Success
        ? const Center(child: CircularProgressIndicator())
        : Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: AppColorConstants.primaryColor),
              child: const Text('Confirm Transaction'),
              onPressed: () async {
                _confirm(invoice);
              },
            ));
  }
}
