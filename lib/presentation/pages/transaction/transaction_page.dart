import 'package:flutter/material.dart';
import 'package:flutter_financial/presentation/pages/transaction/components/transaction_card.dart';
import 'package:flutter_financial/presentation/provider/firestore_transaction_notifier.dart';
import 'package:provider/provider.dart';

import '../../../core/utility/constants.dart';
import '../../../core/utility/state_enum.dart';
import '../../components/custom_drawer.dart';
import '../invoice/components/invoice_card.dart';
import '../../components/logout_button.dart';
import '../../provider/firestore_invoice_notifier.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {

  @override
    void initState() {
      super.initState();
      Future.microtask(() =>
          Provider.of<FirestoreTransactionNotifier>(context, listen: false)
              .getTransactions());
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
            'Transaksi',
            style: TextStyle(color: Colors.black),
          ),
          actions: const <Widget>[
            
          ],
        ),
        body: Consumer<FirestoreTransactionNotifier>(
          builder: (context, data, child) {
            final status = data.geTransactionStatus;
            if (status == Status.Loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (status == Status.Error) {
              return Center(child: Text(data.message));
            }
            if (status == Status.Empty) {
              return const Center(child: Text('Empty Data'));
            }
            if (status == Status.Success) {
              return Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.transactions.length,
                    itemBuilder: (context, index) {
                      final invoice = data.transactions[index];
                      return TransactionCard(invoice: invoice);
                    },
                  ),
                ),
              );
            }
            return Center(child: Text('Something\'s wrong please try again'));
          },
        ),
        drawer: const CustomDrawer());
  }
}