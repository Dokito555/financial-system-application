import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/routes/route_paths.dart';
import '../../../../data/model/invoice_model.dart';

class TransactionCard extends StatelessWidget {

  final InvoiceModel invoice;

  const TransactionCard({required this.invoice});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
        ),
        color: Colors.white,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                    context, AppRoutePaths.transactionDetailPageRoute,
                    arguments: invoice);
              },
              child: ListTile(
                  title: Text(invoice.name),
                  subtitle: Text('No. Pembayaran ${invoice.paymentNumber}'),
                  trailing: Text(
                    NumberFormat.compactCurrency(
                            decimalDigits: 2, locale: "en_US", symbol: "IDR ")
                        .format(invoice.total),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )),
            ),
            const Divider(
              indent: 10,
              endIndent: 10,
            )
          ],
        ));
  }
}