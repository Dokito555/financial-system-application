import 'package:flutter/material.dart';

class TransactionLogPage extends StatefulWidget {
  const TransactionLogPage({super.key});

  @override
  State<TransactionLogPage> createState() => _TransactionLogPageState();
}

class _TransactionLogPageState extends State<TransactionLogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
          ),
          child: Text('Financial App'),
        ),
      ),
    );
  }
}