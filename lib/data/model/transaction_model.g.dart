// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
      id: json['id'] as int,
      title: json['title'] as String,
      nominal: json['nominal'] as String,
      isPemasukan: json['isPemasukan'] as bool,
      currentDate: DateTime.parse(json['currentDate'] as String),
      description: json['description'] as String,
    );

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'nominal': instance.nominal,
      'isPemasukan': instance.isPemasukan,
      'currentDate': instance.currentDate.toIso8601String(),
      'description': instance.description,
    };
