import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_financial/data/datasource/remote/firebase_transaction.dart';
import 'package:flutter_financial/data/model/invoice_model.dart';
import 'package:flutter_financial/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_financial/domain/repository/firestore_transaction_repository.dart';
import 'package:injectable/injectable.dart';

@prod
@LazySingleton(as: FirestoreTransacitonRepository)
class FirestoreTransactionRepositoryImpl extends FirestoreTransacitonRepository {

  final FirebaseFirestoreTransactionRemoteDataSource remoteDataSource;

    FirestoreTransactionRepositoryImpl({
      required this.remoteDataSource
    });

  @override
  Future<Either<Failure, void>> addTransaction(InvoiceModel invoice) async {
   try {
      final result = await remoteDataSource.addTransaction(invoice);
      return Right(result);
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to network'));
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print('Failed with error code: ${e.code}');
      }
      return Left(FirebaseFailure('Failed with error code: ${e.code}'));
    }
  }

  @override
  Future<Either<Failure, List<InvoiceModel>>> fetchTransactions() async {
    try {
      final result = await remoteDataSource.fetchTransactions();
      return Right(result);
    }
    on SocketException {
      return Left(ConnectionFailure('Failed to connect to network'));
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print('Failed with error code ${e.code}');
      }
      return Left(FirebaseFailure('Failed with error code: ${e.code}'));
    }
  }

}