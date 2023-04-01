import 'package:flutter/material.dart';
import 'package:flutter_financial/core/utility/constants.dart';
import 'package:intl/intl.dart';

import '../../../../core/routes/route_paths.dart';
import '../../../../data/model/invoice_model.dart';

class TransactionLogCard extends StatelessWidget {

  final InvoiceModel invoice;
  const TransactionLogCard({required this.invoice});

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
                  trailing: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 12,
                    children: [
                      Text(
                        NumberFormat.compactCurrency(
                                decimalDigits: 2, locale: "en_US", symbol: "IDR ")
                            .format(invoice.total),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(100)),
                          color: invoice.isSuccess == null ? Colors.grey : invoice.isSuccess! ? AppColorConstants.successGreen : AppColorConstants.failedRed,
                        ),
                        width: 10,
                        height: 10,
                      )
                    ]
                  )),
            ),
            Divider(
              indent: 10,
              endIndent: 10,
            )
          ],
        ));
  }
}