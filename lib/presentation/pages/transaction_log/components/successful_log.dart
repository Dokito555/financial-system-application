import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utility/constants.dart';
import '../../../../core/utility/state_enum.dart';
import '../../../provider/firestore_transaction_log_notifier.dart';

class SuccessfulTransactionsLog extends StatefulWidget {
  const SuccessfulTransactionsLog({super.key});

  @override
  State<SuccessfulTransactionsLog> createState() =>
      _SuccessfulTransactionsLogState();
}

class _SuccessfulTransactionsLogState extends State<SuccessfulTransactionsLog> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FirestoreTransactionLogNotifier>(
      builder: (context, data, child) {
        final status = data.successTransactionStatus;
        if (status == Status.Loading) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: AppColorConstants.lightGreenColor,
            ),
              padding: const EdgeInsets.all(10),
              width: 116,
              height: 116,
              child: const Center(child: CircularProgressIndicator()
            ) 
          );
        }
        if (status == Status.Error) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: AppColorConstants.lightGreenColor,
            ),
              padding: const EdgeInsets.all(10),
              width: 116,
              height: 116,
              child: Center(child: Text(data.message)
            ) 
          );
        }
        if (status == Status.Success || status == Status.Empty) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: AppColorConstants.lightGreenColor,
            ),
            padding: const EdgeInsets.all(10),
            width: 116,
            height: 116,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Successful Transactions',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                const SizedBox(height: 10),
                data.successfulPercentage == double.nan 
                ? Text('0%', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
                : Text('${data.successfulPercentage.toInt()}%', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
              ],
            )
          );
        }
        return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: AppColorConstants.lightGreenColor,
            ),
            padding: const EdgeInsets.all(10),
            width: 116,
            height: 116,
            child: const Center(child: Text('Something\'s wrong please try again '))
          );
      },
    );
  }
}
