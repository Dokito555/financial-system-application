import 'package:hive/hive.dart';

part 'transaction_hive_model.g.dart';

@HiveType(typeId: 0)
class TransactionHiveModel extends HiveObject {

  static const String boxKey = 'transaction';

  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String nominal;

  @HiveField(3)
  bool isPemasukan;

  @HiveField(4)
  DateTime currentDate;

  @HiveField(5)
  String description;

  TransactionHiveModel({
    required this.id,
    required this.title,
    required this.nominal,
    required this.isPemasukan,
    required this.currentDate,
    required this.description
  });

}