import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  int id;
  String title;
  String nominal;
  bool isPemasukan;
  DateTime currentDate;
  String description;

  Transaction({
    required this.id,
    required this.title,
    required this.nominal,
    required this.isPemasukan,
    required this.currentDate,
    required this.description
  });

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