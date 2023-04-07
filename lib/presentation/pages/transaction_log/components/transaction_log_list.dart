import 'package:flutter/material.dart';
import 'package:flutter_financial/presentation/pages/transaction_log/components/transaction_log_card.dart';
import 'package:provider/provider.dart';

import '../../../../core/utility/state_enum.dart';
import '../../../provider/firestore_transaction_log_notifier.dart';

class TransactionLogList extends StatefulWidget {
  const TransactionLogList({
    Key? key,
  }) : super(key: key);

  @override
  State<TransactionLogList> createState() => _TransactionLogListState();
}

class _TransactionLogListState extends State<TransactionLogList> {

  @override
  Widget build(BuildContext context) {
    return Consumer<FirestoreTransactionLogNotifier>(
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
        return Center(child: Text('Something\'s wrong please try again'));
      },
    );
  }
}