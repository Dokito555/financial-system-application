import 'package:flutter/material.dart';
import 'package:flutter_financial/data/model/invoice_model.dart';
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
    Future.microtask(
      () => Provider.of<FirestoreInvoiceNotifier>(context, listen: false).getInvoices()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Finance'),
          actions: const <Widget>[
            LogoutButton(),
          ],
        ),
        body:
          SingleChildScrollView(
            child: Column(
              children: [
                Consumer<FirestoreInvoiceNotifier>(
                  builder: (context, data, child) {
                    final status = data.invoicesStatus;
                    if (status == Status.Loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    else if (status == Status.Success) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.invoices.length,
                        itemBuilder: (context, index) {
                          final invoice = data.invoices[index];
                          return ListTile(
                            title: Text(invoice.invoiceNumber),
                          );
                        },
                      );
                    }
                    else {
                      return Text(data.message);
                    }
                  },
                )
              ],
            ),
          ),
        drawer: const CustomDrawer());
  }
}
