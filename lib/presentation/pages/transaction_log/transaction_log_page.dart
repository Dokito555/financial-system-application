import 'package:flutter/material.dart';
import 'package:flutter_financial/core/utility/constants.dart';
import 'package:flutter_financial/core/utility/state_enum.dart';
import 'package:flutter_financial/presentation/components/custom_drawer.dart';
import 'package:flutter_financial/presentation/pages/transaction_log/components/transaction_log_card.dart';
import 'package:flutter_financial/presentation/provider/firestore_transaction_log_notifier.dart';
import 'package:provider/provider.dart';

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
        body: Consumer<FirestoreTransactionLogNotifier>(
          builder: (context, data, child) {
            final status = data.getTransactionLogStatus;
            if (status == Status.Loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (status == Status.Error) {
              return Center(child: Text(data.message));
            }
            if (status == Status.Empty || data.transactionsLog.isEmpty) {
              return const Center(child: Text('Empty Data'));
            }
            if (status == Status.Success) {
              return Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.transactionsLog.length,
                    itemBuilder: (context, index) {
                      final invoice = data.transactionsLog[index];
                      return TransactionLogCard(invoice: invoice);
                    },
                  ),
                ),
              );
            }
            return const Center(child: Text('Something\'s wrong please try again'));
          },
        ),
        drawer: const CustomDrawer());
  }
}

