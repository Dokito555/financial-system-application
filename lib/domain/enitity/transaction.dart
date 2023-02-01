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
  DateTime currentDate;
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

//flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs