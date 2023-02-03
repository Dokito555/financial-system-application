// import 'package:flutter_financial/data/model/transaction_model.dart';
// import 'package:hive/hive.dart';
// import 'package:sqflite/sqflite.dart';

// class DatabaseHelper {

//     static DatabaseHelper?  _databaseHelper;
//   DatabaseHelper._instance() {
//     _databaseHelper = this;
//   }

//   factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

//   static Database? _database;

//   Future<Database?> get database async {
//     _database ??= await _initDb();
//     return _database;
//   }

//   static const String _tbTransaction = 'transaction';

//   Future<Database> _initDb() async {
//     final path = await getDatabasesPath();
//     final databasePath = '$path/finance.db';

//     var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
//     return db;
//   }

//   //boolean is not a supported SQLite type. use INTEGER and 0 and 1 values.
//   //DateTime is not a supported SQLite type. Personally I store them as int (millisSinceEpoch) or string (iso8601)
//   void _onCreate(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE  $_tbTransaction (
//         id INTEGER PRIMARY KEY,
//         title TEXT,
//         nominal TEXT,
//         isPemasukan INTEGER,
//         currentDate TEXT,
//         description TEXT
//       );
//     ''');
//   }

//   Future<int> insertTransaction(TransactionModel transaction) async {
//     final db = await database;
//     return await db!.insert(_tbTransaction, transaction.toJson());
//   }

//   Future<Map<String, dynamic>?> getTransactionById(int id) async {
//     final db = await database;
//     final result = await db!.query(
//       _tbTransaction,
//       where: 'id == ?',
//       whereArgs: [id]
//     );

//     if (result.isNotEmpty) {
//       return result.first;
//     } else {
//       return null;
//     }
//   }

//   Future<List<Map<String, dynamic>>> getTransactionList() async {
//     final db = await database;
//     final List<Map<String, dynamic>> results = await db!.query(_tbTransaction);

//     return results;
//   }

// }

