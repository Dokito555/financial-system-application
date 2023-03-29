import 'package:flutter/material.dart';
import 'package:flutter_financial/core/utility/constants.dart';
import 'package:flutter_financial/data/model/invoice_model.dart';

class DataCard extends StatelessWidget {

  final InvoiceModel invoice;

  const DataCard({required this.invoice});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListTile(
            leading: Column(
              children: [
                Text(invoice.name),
                Text(invoice.paymentNumber),
                Text(invoice.startDate.toString())
              ],
            ),
            trailing: Center(
              child: Text(invoice.total.toString()),
            ),
          ),
          const Divider(color: AppColorConstants.lightBlueColor, height: 0.5, thickness: 0.5,)
        ],
      )
    );
  }
}