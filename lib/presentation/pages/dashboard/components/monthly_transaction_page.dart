import 'package:flutter/material.dart';
import 'package:flutter_financial/presentation/provider/firestore_transaction_notifier.dart';
import 'package:provider/provider.dart';

import '../../../../core/utility/state_enum.dart';
import '../../transaction/components/transaction_card.dart';

class MonthlyTransactionPage extends StatefulWidget {
  const MonthlyTransactionPage({super.key});

  @override
  State<MonthlyTransactionPage> createState() => _MonthlyTransactionPageState();
}

class _MonthlyTransactionPageState extends State<MonthlyTransactionPage> {

  final _scrollController = ScrollController();

  @override
    void initState() {
      super.initState();
      Future.microtask(() =>
          Provider.of<FirestoreTransactionNotifier>(context, listen: false)
          .getMonthlyTransaction()
      );
    }

  @override
  Widget build(BuildContext context) {
    return Consumer<FirestoreTransactionNotifier>(
      builder: (context, data, child) {
        final status = data.geTransactionStatus;
        if (status == Status.Loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (status == Status.Error) {
          return Center(child: Text(data.message));
        }
        if (status == Status.Empty || data.monthlyTransaction.isEmpty) {
          return const Center(child: Text('Empty Data'));
        }
        if (status == Status.Success) {
          return ListView.builder(
            padding: const EdgeInsets.only(left: 10, right: 10),
            shrinkWrap: true,
            // physics: const NeverScrollableScrollPhysics(),
            itemCount: data.monthlyTransaction.length,
            itemBuilder: (context, index) {
              final invoice = data.monthlyTransaction[index];
              return TransactionCard(invoice: invoice);
            },
          );
        }
        return Center(child: Text('Something\'s wrong please try again'));
      },
    );
  }
}
