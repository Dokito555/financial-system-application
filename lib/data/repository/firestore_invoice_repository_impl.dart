import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_financial/data/datasource/remote/firebase_invoice_db.dart';
import 'package:flutter_financial/data/model/invoice_model.dart';
import 'package:flutter_financial/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_financial/domain/repository/firestore_invoice_repository.dart';
import 'package:injectable/injectable.dart';

@prod
@LazySingleton(as: FirestoreInvoiceRepository)
class FirestoreInvoiceRepositoryImpl extends FirestoreInvoiceRepository {

  final FirebaseFirestoreInvoiceDatabaseRemoteDataSource remoteDataSource;

  FirestoreInvoiceRepositoryImpl({
    required this.remoteDataSource
  });

  @override
  Future<Either<Failure, void>> createInvoice(InvoiceModel invoice) async {
    try {
      final result = await remoteDataSource.createInvoice(invoice);
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
  
}