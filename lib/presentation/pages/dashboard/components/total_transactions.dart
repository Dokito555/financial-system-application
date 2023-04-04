import 'package:flutter/material.dart';
import 'package:flutter_financial/core/utility/constants.dart';
import 'package:flutter_financial/core/utility/state_enum.dart';
import 'package:flutter_financial/presentation/provider/firestore_transaction_notifier.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TotalTransactions extends StatefulWidget {
  const TotalTransactions({
    Key? key,
  }) : super(key: key);

  @override
  State<TotalTransactions> createState() => _TotalTransactionsState();
}

class _TotalTransactionsState extends State<TotalTransactions> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<FirestoreTransactionNotifier>(context, listen: false)
      ..getTransactions()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FirestoreTransactionNotifier>(
      builder: (context, data, child) {
        final status = data.getTotalNominalStatus;
        if (status == Status.Loading) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: AppColorConstants.lightPinkColor,
            ),
            padding: const EdgeInsets.all(10),
            width: 100,
            height: 100,
            child: const Center(child: CircularProgressIndicator())
          );
        }
        if (status == Status.Error) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: AppColorConstants.lightPinkColor,
            ),
            padding: const EdgeInsets.all(10),
            width: 160,
            height: 100,
            child: Center(child: Text(data.message))
          );
        }
        if (status == Status.Empty || status == Status.Success) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: AppColorConstants.lightPinkColor,
            ),
            padding: const EdgeInsets.all(10),
            width: 160,
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Total Transactions', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                const SizedBox(height: 10),
                Text(
                  data.allTimeTransaction.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ],
            )
          );
        }
        return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: AppColorConstants.lightPurpleColor,
            ),
            padding: const EdgeInsets.all(10),
            width: 100,
            height: 100,
            child: const Center(child: Text('Something\'s wrong please try again '))
          );
      },
    );
  }
}