import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_financial/presentation/components/custom_drawer.dart';
import 'package:flutter_financial/presentation/pages/invoice_form/components/invoice_text_form_field.dart';

import '../../../core/utility/constants.dart';
import 'components/create_invoice_button.dart';

class InvoiceFormPage extends StatefulWidget {
  const InvoiceFormPage({super.key});

  @override
  State<InvoiceFormPage> createState() => _InvoiceFormPageState();
}

class _InvoiceFormPageState extends State<InvoiceFormPage> {
  final GlobalKey<FormState> _addPointKey = GlobalKey<FormState>();
  List<String> paymentMethods = <String>["CLOSE", "OPEN"];

  String _paymentMethodValue = "CLOSE";

  TextEditingController invoiceNumberController = TextEditingController();
  TextEditingController paymentNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController nominalController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController totalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColorConstants.fillColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xff777474)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Form Tagihan', style: TextStyle(color: Colors.black),),
        actions: const <Widget>[
          
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Form(
            key: _addPointKey,
            child: ListView(
              children: <Widget>[
                Center(
                  child: Column(
                    children: [
                      _invoiceForm(context),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      drawer: const CustomDrawer(),
    );
  }

  Widget _invoiceForm(BuildContext context) {
    return Column(
      children: [
        InvoiceTextFormField(
            controller: invoiceNumberController,
            isValidate: true,
            text: "Invoice Number"),
        InvoiceTextFormField(
            controller: paymentNumberController,
            isValidate: true,
            text: "Payment Number"),
        DropdownButton(
          items: paymentMethods.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              _paymentMethodValue = value!;
            });
          },
          value: _paymentMethodValue,
        ),
        const SizedBox(height: 10),
        InvoiceTextFormField(
            controller: nameController, isValidate: true, text: "Name"),
        InvoiceTextFormField(
            controller: emailController,
            isValidate: false,
            text: "Email",
            keyboardType: TextInputType.emailAddress),
        InvoiceTextFormField(
            controller: phoneNumberController,
            isValidate: false,
            text: "Phone Number",
            keyboardType: TextInputType.phone),
        InvoiceTextFormField(
            controller: addressController, isValidate: false, text: "Address"),
        const SizedBox(height: 10),
        TextFormField(
            controller: startDateController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Start Date',
              suffixIcon: Icon(Icons.calendar_month_outlined)
            ),
            autofocus: false,
            validator: (value) {
              if (value!.isEmpty) {
                return "Date must not be empty";
              }
              return null;
            },
            onTap: () async {
              DateTime? pickDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101));

              if (pickDate != null) {
                setState(() {
                  startDateController.text =
                      formatDate(pickDate, [yyyy, '-', mm, '-', dd]);
                });
              }
            }),
        const SizedBox(height: 10),
        TextFormField(
          controller: expiryDateController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Expiry Date',
            suffixIcon: Icon(Icons.calendar_month_outlined)
          ),
          autofocus: false,
          validator: (value) {
            if (value!.isEmpty) {
              return "Date must not be empty";
            }
            return null;
          },
          onTap: () async {
            DateTime? pickDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101));

            if (pickDate != null) {
              setState(() {
                expiryDateController.text =
                    formatDate(pickDate, [yyyy, '-', mm, '-', dd]);
              });
            }
          },
        ),
        //
        const SizedBox(height: 10),
        InvoiceTextFormField(
            controller: descriptionController,
            isValidate: false,
            text: "Description"),
        InvoiceTextFormField(
            controller: nominalController,
            isValidate: true,
            text: "Nominal",
            keyboardType: TextInputType.number),
        InvoiceTextFormField(
            controller: quantityController,
            isValidate: true,
            text: "Quantity",
            keyboardType: TextInputType.number),
        InvoiceTextFormField(
            controller: totalController,
            isValidate: true,
            text: "Total",
            keyboardType: TextInputType.number),
        CreateInvoiceButton(
            addPointKey: _addPointKey,
            invoiceNumberController: invoiceNumberController,
            paymentNumberController: paymentNumberController,
            paymentMethodValue: _paymentMethodValue,
            nameController: nameController,
            emailController: emailController,
            phoneNumberController: phoneNumberController,
            addressController: addressController,
            createdDateController: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
            startDateController: startDateController,
            expiryDateController: expiryDateController,
            descriptionController: descriptionController,
            nominalController: nominalController,
            quanityController: quantityController,
            totalController: totalController)
      ],
    );
  }
}
