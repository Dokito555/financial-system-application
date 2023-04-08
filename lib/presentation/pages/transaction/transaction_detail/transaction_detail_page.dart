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
                        const Text(
                          'Tagihan Untuk',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          '${invoice.name}',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                        Text(
                          '${invoice.email}',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        Text(
                          '${invoice.address}',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text('Invoice Date :',
                                style: const TextStyle(
                                    color: AppColorConstants.primaryColor)),
                            SizedBox(
                              width: 60,
                            ),
                            Text('${invoice.startDate}')
                          ],
                        ),
                        Row(
                          children: [
                            Text('Payment Method :',
                                style: const TextStyle(
                                    color: AppColorConstants.primaryColor)),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              '${invoice.paymentMethod}',
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text('Due Date :',
                                style: const TextStyle(
                                    color: AppColorConstants.primaryColor)),
                            SizedBox(
                              width: 80,
                            ),
                            Text('${invoice.expiryDate}')
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text('Sub Total'),
                            SizedBox(
                              width: 60,
                            ),
                            Text('${invoice.nominal}')
                          ],
                        ),
                        Row(
                          children: [
                            Text('Total'),
                            SizedBox(
                              width: 90,
                            ),
                            Text(
                              '${invoice.total}',
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
