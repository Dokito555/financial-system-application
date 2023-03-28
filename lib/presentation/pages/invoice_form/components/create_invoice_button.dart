import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utility/state_enum.dart';
import '../../../../data/model/invoice_model.dart';
import '../../../components/loading.dart';
import '../../../components/show_toast.dart';
import '../../../provider/firestore_invoice_notifier.dart';

class CreateInvoiceButton extends StatelessWidget {
  const CreateInvoiceButton({
    Key? key,
    required GlobalKey<FormState> addPointKey,
    required this.invoiceNumberController,
    required this.paymentNumberController,
    required String paymentMethodValue,
    required this.nameController,
    required this.emailController,
    required this.phoneNumberController,
    required this.addressController,
    required this.createdDateController,
    required this.startDateController,
    required this.expiryDateController,
    required this.descriptionController,
    required this.nominalController,
    required this.quanityController,
    required this.totalController,
  }) : _addPointKey = addPointKey, _paymentMethodValue = paymentMethodValue, super(key: key);

  final GlobalKey<FormState> _addPointKey;
  final TextEditingController invoiceNumberController;
  final TextEditingController paymentNumberController;
  final String _paymentMethodValue;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  final TextEditingController addressController;
  final DateTime createdDateController;
  final TextEditingController startDateController;
  final TextEditingController expiryDateController;
  final TextEditingController descriptionController;
  final TextEditingController nominalController;
  final TextEditingController quanityController;
  final TextEditingController totalController;

  @override
  Widget build(BuildContext context) {

    var invoiceNotifier = Provider.of<FirestoreInvoiceNotifier>(context, listen: false);

    Future<void> createInvoice(InvoiceModel invoice) async {
      onLoading;

      await invoiceNotifier.createInvoice(
        invoice: invoice
      );

      if (invoiceNotifier.status == Status.Error) {
        ShowToast.toast(invoiceNotifier.message);
      } else if (invoiceNotifier.status == Status.Success) {
        ShowToast.toast(invoiceNotifier.message);
      } else {
        ShowToast.toast(invoiceNotifier.message);
      }

    }

    return Container(
        height: 50,
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ElevatedButton(
          child: const Text('Create'),
          onPressed: () async {
            if (!_addPointKey.currentState!.validate()) {
              return;
            }

            InvoiceModel invoice = InvoiceModel(
              invoiceNumber: invoiceNumberController.text.trim(),
              paymentNumber: paymentNumberController.text.trim(),
              paymentMethod: _paymentMethodValue,
              name: nameController.text.trim(),
              email: emailController.text.trim(),
              phoneNumber: int.parse(phoneNumberController.text),
              address: addressController.text.trim(),
              created: createdDateController,
              startDate: DateTime.parse(startDateController.text),
              expiryDate: DateTime.parse(expiryDateController.text),
              nominal: int.parse(nominalController.text.trim()),
              quantity: int.parse(quanityController.text.trim()),
              total: int.parse(totalController.text.trim())
            );
            
            createInvoice(invoice);
          },
        ));
  }
}