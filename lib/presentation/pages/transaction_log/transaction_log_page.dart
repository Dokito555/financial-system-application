import 'package:flutter/material.dart';
import 'package:flutter_financial/presentation/components/custom_drawer.dart';
import 'package:flutter_financial/presentation/components/logout_button.dart';
import 'package:flutter_financial/presentation/pages/transaction_log/components/transaction_log_card.dart';
import 'package:provider/provider.dart';

import '../../../core/utility/constants.dart';
import '../../../core/utility/state_enum.dart';
import '../../provider/firestore_transaction_log_notifier.dart';
import '../invoice/components/invoice_card.dart';
import '../../provider/firestore_transaction_notifier.dart';

class TransactionLogPage extends StatefulWidget {
  const TransactionLogPage({super.key});

  @override
  State<TransactionLogPage> createState() => _TransactionLogPageState();
}

class _TransactionLogPageState extends State<TransactionLogPage> {

  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<FirestoreTransactionLogNotifier>(context, listen: false)
            .getTransactionsLog());
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
            'Transactions Log',
            style: TextStyle(color: Colors.black),
          ),
          actions: const <Widget>[
            LogoutButton(),
          ],
        ),
        body:
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
            child: Consumer<FirestoreTransactionLogNotifier>(
              builder: (context, data, child) {
                final status = data.getTransactionLogStatus;
                if (status == Status.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (status == Status.Success) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.transactionsLog.length,
                    itemBuilder: (context, index) {
                      final invoice = data.transactionsLog[index];
                      return TransactionLogCard(invoice: invoice);
                    },
                  );
                } else {
                  return Text(data.message);
                }
              },
            ),
                  ),
          ),
        drawer: const CustomDrawer());
  }
}