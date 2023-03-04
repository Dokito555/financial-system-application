import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_financial/presentation/components/loading.dart';
import 'package:flutter_financial/presentation/components/show_toast.dart';
import 'package:flutter_financial/presentation/provider/firestore_invoice_notifier.dart';
import 'package:provider/provider.dart';

import '../../../core/utility/state_enum.dart';
import '../../../data/model/invoice_model.dart';

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
  TextEditingController createdDateController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController nominalController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController totalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Form(
            key: _addPointKey,
            child: ListView(
              children: <Widget>[
                Center(
                  child: Column(
                    children: [
                      _header(context),
                      _invoiceForm(context),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: const Text(
          'Finance App',
          style: TextStyle(
              color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 30),
        ));
  }

  Widget _invoiceForm(BuildContext context) {
    return Column(
      children: [
        _invoiceNumberField(
          invoiceNumberController: invoiceNumberController,
        ),
        const SizedBox(height: 10),
        _paymentNumberField(
          paymentNumberController: paymentNumberController,
        ),
        const SizedBox(height: 10),
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
        _nameField(
          nameController: nameController,
        ),
        const SizedBox(height: 10),
        _emailField(
          emailController: emailController,
        ),
        const SizedBox(height: 10),
        _phoneNumberField(
          phoneNumberController: phoneNumberController,
        ),
        const SizedBox(height: 10),
        _addressField(
          addressController: addressController,
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: createdDateController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'createdDate',
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
                createdDateController.text =
                    formatDate(pickDate, [yyyy, '-', mm, '-', dd]);
              });
            }
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
            controller: startDateController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Start Date',
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
                expiryDateController.text = formatDate(pickDate, [yyyy, '-', mm, '-', dd]);
              });
            }
          },
        ),
        //
        const SizedBox(height: 10),
        _descripionField(
          descriptionController: descriptionController,
        ),
        const SizedBox(height: 10),
        _nominalField(
          nominalController: nominalController,
        ),
        const SizedBox(height: 10),
        _quantityField(
          quantityController: quantityController,
        ),
        const SizedBox(height: 10),
        _totalField(
          totalController: totalController,
        ),
        const SizedBox(height: 10),
        _buttonCreateInvoice(addPointKey: _addPointKey, invoiceNumberController: invoiceNumberController, paymentNumberController: paymentNumberController, paymentMethodValue: _paymentMethodValue, nameController: nameController, createdDateController: createdDateController, startDateController: startDateController, expiryDateController: expiryDateController, nominalController: nominalController, totalController: totalController)
      ],
    );
  }
}

class _buttonCreateInvoice extends StatelessWidget {
  const _buttonCreateInvoice({
    Key? key,
    required GlobalKey<FormState> addPointKey,
    required this.invoiceNumberController,
    required this.paymentNumberController,
    required String paymentMethodValue,
    required this.nameController,
    required this.createdDateController,
    required this.startDateController,
    required this.expiryDateController,
    required this.nominalController,
    required this.totalController,
  }) : _addPointKey = addPointKey, _paymentMethodValue = paymentMethodValue, super(key: key);

  final GlobalKey<FormState> _addPointKey;
  final TextEditingController invoiceNumberController;
  final TextEditingController paymentNumberController;
  final String _paymentMethodValue;
  final TextEditingController nameController;
  final TextEditingController createdDateController;
  final TextEditingController startDateController;
  final TextEditingController expiryDateController;
  final TextEditingController nominalController;
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
          child: const Text('Login'),
          onPressed: () async {
            if (!_addPointKey.currentState!.validate()) {
              return;
            }

            final InvoiceModel invoice = InvoiceModel(
              invoiceNumber: invoiceNumberController.text.trim(),
              paymentNumber: paymentNumberController.text.trim(),
              paymentMethod: _paymentMethodValue,
              name: nameController.text.trim(),
              created: DateTime.parse(createdDateController.text),
              startDate: DateTime.parse(startDateController.text),
              expiryDate: DateTime.parse(expiryDateController.text),
              nominal: nominalController.text.trim(),
              total: totalController.text.trim()
            );
            
            createInvoice(invoice);
          },
        ));
  }
}

class _totalField extends StatelessWidget {
  const _totalField({
    Key? key,
    required this.totalController,
  }) : super(key: key);

  final TextEditingController totalController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: totalController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Input Total',
        labelText: 'Total',
      ),
      autofocus: false,
      validator: (value) {
        if (value!.isEmpty) {
          return "Total must not be empty";
        }
        return null;
      },
    );
  }
}

class _quantityField extends StatelessWidget {
  const _quantityField({
    Key? key,
    required this.quantityController,
  }) : super(key: key);

  final TextEditingController quantityController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: quantityController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Input Quantity',
        labelText: 'Quanity',
      ),
      autofocus: false,
      validator: (value) {
        if (value!.isEmpty) {
          return "Quantity must not be empty";
        }
        return null;
      },
    );
  }
}

class _nominalField extends StatelessWidget {
  const _nominalField({
    Key? key,
    required this.nominalController,
  }) : super(key: key);

  final TextEditingController nominalController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nominalController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Input Nominal',
        labelText: 'Nominal',
      ),
      autofocus: false,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nominal must not be empty";
        }
        return null;
      },
    );
  }
}

class _descripionField extends StatelessWidget {
  const _descripionField({
    Key? key,
    required this.descriptionController,
  }) : super(key: key);

  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: descriptionController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Input Description',
        labelText: 'Description',
      ),
      autofocus: false,
    );
  }
}

class _addressField extends StatelessWidget {
  const _addressField({
    Key? key,
    required this.addressController,
  }) : super(key: key);

  final TextEditingController addressController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: addressController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Input Address',
        labelText: 'Address',
      ),
      autofocus: false,
    );
  }
}

class _phoneNumberField extends StatelessWidget {
  const _phoneNumberField({
    Key? key,
    required this.phoneNumberController,
  }) : super(key: key);

  final TextEditingController phoneNumberController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: phoneNumberController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Input Phone Number',
        labelText: 'Phone Number',
      ),
      autofocus: false,
    );
  }
}

class _emailField extends StatelessWidget {
  const _emailField({
    Key? key,
    required this.emailController,
  }) : super(key: key);

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Input Email',
        labelText: 'Email',
      ),
      autofocus: false,
    );
  }
}

class _nameField extends StatelessWidget {
  const _nameField({
    Key? key,
    required this.nameController,
  }) : super(key: key);

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Input Name',
        labelText: 'Name',
      ),
      autofocus: false,
      validator: (value) {
        if (value!.isEmpty) {
          return "Name must not be empty";
        }
        return null;
      },
    );
  }
}

class _invoiceNumberField extends StatelessWidget {
  const _invoiceNumberField({
    Key? key,
    required this.invoiceNumberController,
  }) : super(key: key);

  final TextEditingController invoiceNumberController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: invoiceNumberController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Input Your Invoice Number',
        labelText: 'Invoice Number',
      ),
      autofocus: false,
      validator: (value) {
        if (value!.isEmpty) {
          return "Invoice Number must not be empty";
        }
        return null;
      },
    );
  }
}

class _paymentNumberField extends StatelessWidget {
  const _paymentNumberField({
    Key? key,
    required this.paymentNumberController,
  }) : super(key: key);

  final TextEditingController paymentNumberController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: paymentNumberController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Input Your payment Number',
        labelText: 'Payment Number',
      ),
      autofocus: false,
      validator: (value) {
        if (value!.isEmpty) {
          return "Payment Number must not be empty";
        }
        return null;
      },
    );
  }
}
