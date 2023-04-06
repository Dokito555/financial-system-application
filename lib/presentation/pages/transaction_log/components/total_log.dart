import 'package:flutter/material.dart';
import 'package:flutter_financial/presentation/provider/firestore_transaction_log_notifier.dart';
import 'package:provider/provider.dart';

import '../../../../core/utility/constants.dart';
import '../../../../core/utility/state_enum.dart';

class TotalTransactionLog extends StatefulWidget {
  const TotalTransactionLog({super.key});

  @override
  State<TotalTransactionLog> createState() => _TotalTransactionLogState();
}

class _TotalTransactionLogState extends State<TotalTransactionLog> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FirestoreTransactionLogNotifier>(
      builder: (context, data, child) {
        final status = data.getTransactionLogStatus;

        if (status == Status.Loading) {
          return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppColorConstants.lightPurpleColor,
              ),
              padding: const EdgeInsets.all(10),
              width: 116,
              height: 116,
              child: const Center(child: CircularProgressIndicator()));
        }
        if (status == Status.Error) {
          return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppColorConstants.lightPurpleColor,
              ),
              padding: const EdgeInsets.all(10),
              width: 116,
              height: 116,
              child: Center(child: Text(data.message)));
        }
        if (status == Status.Empty || status == Status.Success) {
          return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppColorConstants.lightPurpleColor,
              ),
              padding: const EdgeInsets.all(10),
              width: 116,
              height: 116,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Total Transactions',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                  const SizedBox(height: 10),
                  Text(data.totalTransactionLog.toString(), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
                ],
              ));
        }
        return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: AppColorConstants.lightPurpleColor,
            ),
            padding: const EdgeInsets.all(10),
            width: 116,
            height: 116,
            child: const Center(
                child: Text('Something\'s wrong please try again ')));
      },
    );
  }
}
