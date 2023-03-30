import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invoice_model.g.dart';

@JsonSerializable()
class InvoiceModel extends Equatable{
  final String id;
  final String invoiceNumber;
  final String paymentNumber;
  final String paymentMethod;
  final String name;
  final String? email;
  int? phoneNumber;
  final String? address;
  final DateTime created;
  final DateTime startDate;
  final DateTime expiryDate;
  final String? description;
  int nominal;
  int quantity;
  int total;

  InvoiceModel({
    required this.id,
    required this.invoiceNumber,
    required this.paymentNumber,
    required this.paymentMethod,
    required this.name,
    this.email = "",
    this.phoneNumber,
    this.address = "",
    required this.created,
    required this.startDate,
    required this.expiryDate,
    this.description = "",
    required this.nominal,
    this.quantity = 1,
    required this.total
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) => _$InvoiceModelFromJson(json);

  factory InvoiceModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return InvoiceModel(
      id: snapshot['id'] as String,
      invoiceNumber: snapshot['invoiceNumber'] as String,
      paymentNumber: snapshot['paymentNumber'] as String,
      paymentMethod: snapshot['paymentMethod'] as String,
      name: snapshot['name'] as String,
      email: snapshot['email'] as String? ?? "",
      phoneNumber: snapshot['phoneNumber'] as int?,
      address: snapshot['address'] as String? ?? "",
      created: DateTime.parse(snapshot['created'] as String),
      startDate: DateTime.parse(snapshot['startDate'] as String),
      expiryDate: DateTime.parse(snapshot['expiryDate'] as String),
      description: snapshot['description'] as String? ?? "",
      nominal: snapshot['nominal'] as int,
      quantity: snapshot['quantity'] as int? ?? 1,
      total: snapshot['total'] as int,
    );
  }
  Map<String, dynamic> toJson() => _$InvoiceModelToJson(this);
  
  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    invoiceNumber,
    paymentNumber,
    paymentMethod,
    name,
    email,
    phoneNumber,
    address,
    created,
    startDate,
    expiryDate,
    description,
    nominal,
    quantity,
    total
  ];
}