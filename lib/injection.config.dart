// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'data/datasource/remote/firebase_auth.dart' as _i4;
import 'data/datasource/remote/firebase_invoice_db.dart' as _i6;
import 'data/datasource/remote/firebase_transaction_db.dart' as _i7;
import 'data/datasource/remote/firebase_transaction_log_db.dart' as _i14;
import 'data/repository/firebase_auth_repository_impl.dart' as _i16;
import 'data/repository/firestore_invoice_repository_impl.dart' as _i9;
import 'data/repository/firestore_transaction_log_repository_impl.dart' as _i13;
import 'data/repository/firestore_transaction_repository_impl.dart' as _i11;
import 'domain/repository/firebase_auth_repository.dart' as _i15;
import 'domain/repository/firestore_invoice_repository.dart' as _i8;
import 'domain/repository/firestore_transaction_log_repository.dart' as _i12;
import 'domain/repository/firestore_transaction_repository.dart' as _i10;
import 'domain/usecases/firebase_auth/reset_password.dart' as _i17;
import 'domain/usecases/firebase_auth/signIn.dart' as _i18;
import 'domain/usecases/firebase_auth/signOut.dart' as _i19;
import 'domain/usecases/firebase_auth/signUp.dart' as _i20;
import 'domain/usecases/firestore_invoice/create_invoice.dart' as _i23;
import 'domain/usecases/firestore_invoice/delete_invoice.dart' as _i24;
import 'domain/usecases/firestore_invoice/get_invoice.dart' as _i26;
import 'domain/usecases/firestore_invoice/get_invoice_detail.dart' as _i25;
import 'domain/usecases/firestore_transaction/add_transaction.dart' as _i21;
import 'domain/usecases/firestore_transaction/get_transactions.dart' as _i27;
import 'domain/usecases/firestore_transaction_log/add_transaction_log.dart'
    as _i22;
import 'domain/usecases/firestore_transaction_log/get_transaction_log.dart'
    as _i28;
import 'presentation/provider/firebase_auth_notifier.dart' as _i32;
import 'presentation/provider/firestore_invoice_notifier.dart' as _i29;
import 'presentation/provider/firestore_transaction_log_notifier.dart' as _i30;
import 'presentation/provider/firestore_transaction_notifier.dart' as _i31;
import 'register_module.dart' as _i33;

const String _prod = 'prod';

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.FirebaseAuth>(() => registerModule.firebaseAuth);
  gh.lazySingleton<_i4.FirebaseAuthenticationRemoteDataSource>(
    () => _i4.FirebaseAuthenticationRemoteDataSourceImpl(
        firebaseAuth: gh<_i3.FirebaseAuth>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i5.FirebaseFirestore>(
      () => registerModule.firebaseFirestore);
  gh.lazySingleton<_i6.FirebaseFirestoreInvoiceDatabaseRemoteDataSource>(
    () => _i6.FirebaseFirestoreInvoiceDatabaseRemoteDataSourceImpl(
        db: gh<_i5.FirebaseFirestore>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i7.FirebaseFirestoreTransactionRemoteDataSource>(
    () => _i7.FirebaseFirestoreTransactionRemoteDataSourceImpl(
        db: gh<_i5.FirebaseFirestore>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i8.FirestoreInvoiceRepository>(
    () => _i9.FirestoreInvoiceRepositoryImpl(
        remoteDataSource:
            gh<_i6.FirebaseFirestoreInvoiceDatabaseRemoteDataSource>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i10.FirestoreTransacitonRepository>(
    () => _i11.FirestoreTransactionRepositoryImpl(
        remoteDataSource:
            gh<_i7.FirebaseFirestoreTransactionRemoteDataSource>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i12.FirestoreTransactionLogRepository>(
    () => _i13.FirestoreTransactionLogRepositoryImpl(
        remoteDataSource:
            gh<_i14.FirebaseFirestoreTransactionLogRemoteDataSource>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i15.FirebaseAuthRepository>(
    () => _i16.FirebaseAuthRepositoryImpl(
        remoteDataSource: gh<_i4.FirebaseAuthenticationRemoteDataSource>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i17.FirebaseAuthResetPassword>(
    () => _i17.FirebaseAuthResetPassword(
        repository: gh<_i15.FirebaseAuthRepository>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i18.FirebaseAuthSignIn>(
    () =>
        _i18.FirebaseAuthSignIn(repository: gh<_i15.FirebaseAuthRepository>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i19.FirebaseAuthSignOut>(
    () =>
        _i19.FirebaseAuthSignOut(repository: gh<_i15.FirebaseAuthRepository>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i20.FirebaseAuthSignUp>(
    () =>
        _i20.FirebaseAuthSignUp(repository: gh<_i15.FirebaseAuthRepository>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i21.FirestoreAddTransaction>(
    () => _i21.FirestoreAddTransaction(
        repository: gh<_i10.FirestoreTransacitonRepository>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i22.FirestoreAddTransactionLog>(
    () => _i22.FirestoreAddTransactionLog(
        repository: gh<_i12.FirestoreTransactionLogRepository>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i23.FirestoreCreateInvoice>(
    () => _i23.FirestoreCreateInvoice(
        repository: gh<_i8.FirestoreInvoiceRepository>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i24.FirestoreDeleteInvoice>(
    () => _i24.FirestoreDeleteInvoice(
        repository: gh<_i8.FirestoreInvoiceRepository>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i25.FirestoreGetInvoiceDetail>(
    () => _i25.FirestoreGetInvoiceDetail(
        repository: gh<_i8.FirestoreInvoiceRepository>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i26.FirestoreGetInvoices>(
    () => _i26.FirestoreGetInvoices(
        repository: gh<_i8.FirestoreInvoiceRepository>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i27.FirestoreGetTransactions>(
    () => _i27.FirestoreGetTransactions(
        repository: gh<_i10.FirestoreTransacitonRepository>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i28.FirestoreGetTransactionsLog>(
    () => _i28.FirestoreGetTransactionsLog(
        repository: gh<_i12.FirestoreTransactionLogRepository>()),
    registerFor: {_prod},
  );
  gh.factory<_i29.FirestoreInvoiceNotifier>(() => _i29.FirestoreInvoiceNotifier(
        firestoreCreateInvoice: gh<_i23.FirestoreCreateInvoice>(),
        firestoreDeleteInvoice: gh<_i24.FirestoreDeleteInvoice>(),
        firestoreGetInvoices: gh<_i26.FirestoreGetInvoices>(),
        firestoreGetInvoiceDetail: gh<_i25.FirestoreGetInvoiceDetail>(),
      ));
  gh.factory<_i30.FirestoreTransactionLogNotifier>(
      () => _i30.FirestoreTransactionLogNotifier(
            firestoreAddTransactionLog: gh<_i22.FirestoreAddTransactionLog>(),
            firestoreGetTransactionsLog: gh<_i28.FirestoreGetTransactionsLog>(),
          ));
  gh.factory<_i31.FirestoreTransactionNotifier>(
      () => _i31.FirestoreTransactionNotifier(
            firestoreAddTransaction: gh<_i21.FirestoreAddTransaction>(),
            firestoreGetTransactions: gh<_i27.FirestoreGetTransactions>(),
          ));
  gh.factory<_i32.FirebaseAuthNotifier>(() => _i32.FirebaseAuthNotifier(
        firebaseAuthSignUp: gh<_i20.FirebaseAuthSignUp>(),
        firebaseAuthSignIn: gh<_i18.FirebaseAuthSignIn>(),
        firebaseAuthSignOut: gh<_i19.FirebaseAuthSignOut>(),
        firebaseAuthResetPassword: gh<_i17.FirebaseAuthResetPassword>(),
      ));
  return getIt;
}

class _$RegisterModule extends _i33.RegisterModule {}
