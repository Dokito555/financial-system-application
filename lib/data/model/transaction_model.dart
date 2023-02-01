
import 'package:equatable/equatable.dart';
import 'package:flutter_financial/domain/enitity/transaction.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction_model.g.dart';

@JsonSerializable()
class TransactionModel extends Equatable{

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
  DateTime currentDate;
  String description;

  factory TransactionModel.fromJson(Map<String, dynamic> json) => _$TransactionModelFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);

  Transaction toEntity() {
    return Transaction(
      id: id, 
      title: title, 
      nominal: nominal, 
      isPemasukan: isPemasukan, 
      currentDate: currentDate, 
      description: description
    );
  }
  
  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    title,
    nominal,
    isPemasukan,
    currentDate,
    description
  ];

}

//flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs