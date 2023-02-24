import 'package:flutter/material.dart';

void onLoading(BuildContext context) {
  showDialog(
    context: context, 
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  );
}