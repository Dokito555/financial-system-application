import 'package:flutter_financial/common/exception.dart';
import 'package:flutter_financial/data/datasource/db/database_helper.dart';
import 'package:flutter_financial/data/model/transaction_model.dart';

abstract class TransactionLocalDatasource {
  Future<String> insertTransaction(TransactionModel transaction);
  Future<TransactionModel?> getTransactionById(int id);
  Future<List<TransactionModel>> getTransactionList();
}

class TransactionLocalDatasourceImpl implements TransactionLocalDatasource {

  final DatabaseHelper databaseHelper;

  TransactionLocalDatasourceImpl({required this.databaseHelper});
  
  @override
  Future<TransactionModel?> getTransactionById(int id) async {
    final result = await databaseHelper.getTransactionById(id);
    if (result != null) {
      print('getTransactionById success');
      return TransactionModel.fromJson(result);
    } else {
      print('getTransactionById failed');
      return null;
    }
  }
  
  @override
  Future<List<TransactionModel>> getTransactionList() async {
    final result = await databaseHelper.getTransactionList();
    return result.map((data) => TransactionModel.fromJson(data)).toList();
  }
  
  @override
  Future<String> insertTransaction(TransactionModel transaction) async{
    try {
      await databaseHelper.insertTransaction(transaction);
      print('Added Transaction to Local Database');
      return 'Added Transaction';
    } catch (e) {
      print('Failed to add Transaction to local');
      throw DatabaseException(e.toString());
    }
  }

}