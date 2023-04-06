import 'package:flutter/material.dart';
import 'package:flutter_financial/core/routes/route_paths.dart';
import 'package:flutter_financial/data/model/invoice_model.dart';
import 'package:intl/intl.dart';

class InvoiceCard extends StatelessWidget {
  final InvoiceModel invoice;

  const InvoiceCard({super.key, required this.invoice});

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
                    context, AppRoutePaths.invoiceDetailPageRoute,
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
