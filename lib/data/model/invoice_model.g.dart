// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceModel _$InvoiceModelFromJson(Map<String, dynamic> json) => InvoiceModel(
      id: json['id'] as String,
      invoiceNumber: json['invoiceNumber'] as String,
      paymentNumber: json['paymentNumber'] as String,
      paymentMethod: json['paymentMethod'] as String,
      name: json['name'] as String,
      email: json['email'] as String? ?? "",
      phoneNumber: json['phoneNumber'] as int?,
      address: json['address'] as String? ?? "",
      created: DateTime.parse(json['created'] as String),
      startDate: DateTime.parse(json['startDate'] as String),
      expiryDate: DateTime.parse(json['expiryDate'] as String),
      description: json['description'] as String? ?? "",
      nominal: json['nominal'] as int,
      quantity: json['quantity'] as int? ?? 1,
      total: json['total'] as int,
      isSuccess: json['isSuccess'] as bool?,
    );

Map<String, dynamic> _$InvoiceModelToJson(InvoiceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'invoiceNumber': instance.invoiceNumber,
      'paymentNumber': instance.paymentNumber,
      'paymentMethod': instance.paymentMethod,
      'name': instance.name,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
      'created': instance.created.toIso8601String(),
      'startDate': instance.startDate.toIso8601String(),
      'expiryDate': instance.expiryDate.toIso8601String(),
      'description': instance.description,
      'nominal': instance.nominal,
      'quantity': instance.quantity,
      'total': instance.total,
      'isSuccess': instance.isSuccess,
    };
