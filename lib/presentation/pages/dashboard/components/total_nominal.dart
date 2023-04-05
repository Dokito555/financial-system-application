import 'package:flutter/material.dart';
import 'package:flutter_financial/presentation/provider/firestore_transaction_notifier.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../core/utility/constants.dart';
import '../../../../core/utility/state_enum.dart';

class TotalNominal extends StatefulWidget {
  const TotalNominal({
    Key? key,
  }) : super(key: key);

  @override
  State<TotalNominal> createState() => _TotalNominalState();
}

class _TotalNominalState extends State<TotalNominal> {

  @override
  Widget build(BuildContext context) {
    return Consumer<FirestoreTransactionNotifier>(
      builder: (context, data, child) {
        final status = data.getTotalNominalStatus;
        if (status == Status.Loading) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: AppColorConstants.lightPurpleColor,
            ),
            padding: const EdgeInsets.all(10),
            width: 160,
            height: 100,
            child: const Center(child: CircularProgressIndicator())
          );
        }
        if (status == Status.Error) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: AppColorConstants.lightPurpleColor,
            ),
            padding: const EdgeInsets.all(10),
            width: 150,
            height: 100,
            child: Center(child: Text(data.message))
          );
        }
        if (status == Status.Empty || status == Status.Success) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: AppColorConstants.lightPurpleColor,
            ),
            padding: const EdgeInsets.all(10),
            width: 160,
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Total Nominal', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                const SizedBox(height: 10),
                Text(
                  NumberFormat.compactCurrency(
                    decimalDigits: 2, locale: "en_US", symbol: "").format(data.totalNominal),
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
            width: 160,
            height: 100,
            child: const Center(child: Text('Something\'s wrong please try again '))
          );
      },
    );
  }
}