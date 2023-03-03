import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invoice_model.g.dart';

@JsonSerializable()
class InvoiceModel extends Equatable{
  final String? id;
  final String invoiceNumber;
  final String paymentNumber;
  final String paymentMethod;
  final String name;
  final String? email;
  final String? phoneNumber;
  final String? address;
  final DateTime created;
  final DateTime startDate;
  final DateTime expiryDate;
  final String? description;
  final String nominal;
  int quantity;
  final String total;

  InvoiceModel({
    this.id,
    required this.invoiceNumber,
    required this.paymentNumber,
    required this.paymentMethod,
    required this.name,
    this.email = "",
    this.phoneNumber = "",
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

  // factory InvoiceModel.fromQueryDocumentSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> json) => _$InvoiceModelDocumentSnapshot(json);

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