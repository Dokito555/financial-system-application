
import 'package:json_annotation/json_annotation.dart';

part 'transaction_model.g.dart';

@JsonSerializable()
class TransactionModel {

  TransactionModel({
    required this.id,
    required this.title,
    required this.nominal,
    required this.isPemasukan,
    required this.currentDate,
    required this.description
  });

  int id;
  String title;
  String nominal;
  bool isPemasukan;
  String currentDate;
  String description;

  factory TransactionModel.fromJson(Map<String, dynamic> json) => _$TransactionModelFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);

}