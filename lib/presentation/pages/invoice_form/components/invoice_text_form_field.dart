import 'package:flutter/material.dart';

class InvoiceTextFormField extends StatelessWidget {
  
  InvoiceTextFormField({
    required this.controller,
    required this.isValidate,
    required this.text,
    this.keyboardType
  });

  final TextEditingController controller;
  final bool isValidate;
  final String text;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          keyboardType: keyboardType,
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input $text',
            labelText: text,
          ),
          autofocus: false,
          validator: (value) {
            isValidate
            ? value!.isEmpty
              ? "$text must not be empty"
              : null
            : null;
          },
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}