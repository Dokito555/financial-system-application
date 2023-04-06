import 'package:flutter/material.dart';
import 'package:flutter_financial/core/utility/state_enum.dart';
import 'package:flutter_financial/presentation/pages/transaction/components/transaction_card.dart';
import 'package:flutter_financial/presentation/provider/firestore_transaction_notifier.dart';
import 'package:provider/provider.dart';


class TodaysTransactionPage extends StatefulWidget {
  const TodaysTransactionPage({super.key});

  @override
  State<TodaysTransactionPage> createState() => _TodaysTransactionPageState();
}

class _TodaysTransactionPageState extends State<TodaysTransactionPage> {
  
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Consumer<FirestoreTransactionNotifier>(
      builder: (context, data, child) {
        final status = data.getTodaysTransactionStatus;
        if (status == Status.Loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (status == Status.Error) {
          return Center(child: Text(data.message));
        }
        if (status == Status.Empty || data.todaysTransaction.isEmpty) {
          return const Center(child: Text('Empty Data'));
        }
        if (status == Status.Success) {
          return ListView.builder(
            padding: const EdgeInsets.only(left: 10, right: 10),
            shrinkWrap: true,
            // physics: const NeverScrollableScrollPhysics(),
            itemCount: data.todaysTransaction.length,
            itemBuilder: (context, index) {
              final invoice = data.todaysTransaction[index];
              return TransactionCard(invoice: invoice);
            },
          );
        }
        return const Center(child: Text('Something\'s wrong please try again'));
      },
    );
  }
}