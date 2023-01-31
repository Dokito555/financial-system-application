import 'package:equatable/equatable.dart';

class Transaction extends Equatable {

  Transaction({
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
  
  @override
  // TODO: implement props
  List<Object?> get props => [
    title,
    nominal,
    isPemasukan,
    currentDate,
    description
  ];

}