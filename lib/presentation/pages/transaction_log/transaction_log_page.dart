import 'package:flutter/material.dart';
import 'package:flutter_financial/core/utility/constants.dart';
import 'package:flutter_financial/core/utility/state_enum.dart';
import 'package:flutter_financial/presentation/components/custom_drawer.dart';
import 'package:flutter_financial/presentation/pages/transaction_log/components/transaction_log_card.dart';
import 'package:flutter_financial/presentation/provider/firestore_transaction_log_notifier.dart';
import 'package:provider/provider.dart';

import 'components/failed_log.dart';
import 'components/successful_log.dart';
import 'components/total_log.dart';
import 'components/transaction_log_list.dart';

class TransactionLogPage extends StatefulWidget {
  const TransactionLogPage({super.key});

  @override
  State<TransactionLogPage> createState() => _TransactionLogPageState();
}

class _TransactionLogPageState extends State<TransactionLogPage> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<FirestoreTransactionLogNotifier>(context, listen: false)
      ..getTransactionsLog()
    );
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
            'Log Transaksi',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                TotalTransactionLog(),  
                FailedTransactionsLog(),
                SuccessfulTransactionsLog(),
              ],
            ),
            SizedBox(height: 20),
            TransactionLogList(),
          ],
        ),
        drawer: const CustomDrawer());
  }
}

