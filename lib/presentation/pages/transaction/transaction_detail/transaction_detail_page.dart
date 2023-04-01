import 'package:flutter/material.dart';

import '../../../../core/utility/constants.dart';
import '../../../../data/model/invoice_model.dart';

class TransactionDetailPage extends StatefulWidget {

  InvoiceModel invoice;
  
  TransactionDetailPage({super.key, required this.invoice});

  @override
  State<TransactionDetailPage> createState() => _TransactionDetailPageState();
}

class _TransactionDetailPageState extends State<TransactionDetailPage> {

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
              left: 10,
              right: 10,
              top: 10,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Tagihan Untuk'),
                  Text(invoice.name),
                  invoice.address != null
                      ? Text(invoice.address!)
                      : Text('Email ${invoice.email}'),
                  Text('Invoice Description : ${invoice.description}'),
                  const Text('Invoice Address Isn\t Available'),
                  Text('Invoice Date : ${invoice.startDate}'),
                  Text('Invoice Expiry Date : ${invoice.expiryDate}'),
                  Text('Invoice Quantity : ${invoice.quantity}'),
                  Text('Invoice Nominal : ${invoice.nominal}'),
                  Text('Invoice Total : ${invoice.total}'),
                ],
              ),
            ),
          ),
        ));
  }
}