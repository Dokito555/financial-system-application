import 'package:flutter/material.dart';

import '../../components/custom_drawer.dart';
import '../../components/logout_button.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({super.key});

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finance'),
        actions: const <Widget>[
          LogoutButton()
          // Consumer<FirestoreInvoiceNotifier>(
          //   builder:(context, value, child) {
          //     if (value.status == Status.Success) {
          //       return ListView.builder(
          //         shrinkWrap: true,
          //         itemCount: value.invoices.length,
          //         itemBuilder: (context, index) {
          //           return Column(
          //             children: [
          //               ListTile(
          //                 title: Text('${value.invoices[index].invoiceNumber}'),
          //               )
          //             ],
          //           );
          //         },
          //       );
          //     } else {
          //       throw Exception();
          //     }
          //   },
          // )
        ],
      ),
      drawer: const CustomDrawer()
    );
  }
}