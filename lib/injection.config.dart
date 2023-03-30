// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'data/datasource/remote/firebase_auth.dart' as _i14;
import 'data/datasource/remote/firebase_invoice_db.dart' as _i5;
import 'data/datasource/remote/firebase_transaction_db.dart' as _i6;
import 'data/datasource/remote/firebase_transaction_log_db.dart' as _i13;
import 'data/repository/firebase_auth_repository_impl.dart' as _i27;
import 'data/repository/firestore_invoice_repository_impl.dart' as _i8;
import 'data/repository/firestore_transaction_log_repository_impl.dart' as _i12;
import 'data/repository/firestore_transaction_repository_impl.dart' as _i10;
import 'domain/repository/firebase_auth_repository.dart' as _i26;
import 'domain/repository/firestore_invoice_repository.dart' as _i7;
import 'domain/repository/firestore_transaction_log_repository.dart' as _i11;
import 'domain/repository/firestore_transaction_repository.dart' as _i9;
import 'domain/usecases/firebase_auth/reset_password.dart' as _i28;
import 'domain/usecases/firebase_auth/signIn.dart' as _i29;
import 'domain/usecases/firebase_auth/signOut.dart' as _i30;
import 'domain/usecases/firebase_auth/signUp.dart' as _i31;
import 'domain/usecases/firebase_auth/user_firestore.dart' as _i32;
import 'domain/usecases/firestore_invoice/create_invoice.dart' as _i17;
import 'domain/usecases/firestore_invoice/delete_invoice.dart' as _i18;
import 'domain/usecases/firestore_invoice/get_invoice.dart' as _i20;
import 'domain/usecases/firestore_invoice/get_invoice_detail.dart' as _i19;
import 'domain/usecases/firestore_transaction/add_transaction.dart' as _i15;
import 'domain/usecases/firestore_transaction/get_transactions.dart' as _i21;
import 'domain/usecases/firestore_transaction_log/add_transaction_log.dart'
    as _i16;
import 'domain/usecases/firestore_transaction_log/get_transaction_log.dart'
    as _i22;
import 'presentation/provider/firebase_auth_notifier.dart' as _i33;
import 'presentation/provider/firestore_invoice_notifier.dart' as _i23;
import 'presentation/provider/firestore_transaction_log_notifier.dart' as _i24;
import 'presentation/provider/firestore_transaction_notifier.dart' as _i25;
import 'register_module.dart' as _i34;

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
  gh.lazySingleton<_i4.FirebaseFirestore>(
      () => registerModule.firebaseFirestore);
  gh.lazySingleton<_i5.FirebaseFirestoreInvoiceDatabaseRemoteDataSource>(
    () => _i5.FirebaseFirestoreInvoiceDatabaseRemoteDataSourceImpl(
      db: gh<_i4.FirebaseFirestore>(),
      firebaseAuth: gh<_i3.FirebaseAuth>(),
    ),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i6.FirebaseFirestoreTransactionRemoteDataSource>(
    () => _i6.FirebaseFirestoreTransactionRemoteDataSourceImpl(
        db: gh<_i4.FirebaseFirestore>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i7.FirestoreInvoiceRepository>(
    () => _i8.FirestoreInvoiceRepositoryImpl(
        remoteDataSource:
            gh<_i5.FirebaseFirestoreInvoiceDatabaseRemoteDataSource>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i9.FirestoreTransacitonRepository>(
    () => _i10.FirestoreTransactionRepositoryImpl(
        remoteDataSource:
            gh<_i6.FirebaseFirestoreTransactionRemoteDataSource>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i11.FirestoreTransactionLogRepository>(
    () => _i12.FirestoreTransactionLogRepositoryImpl(
        remoteDataSource:
            gh<_i13.FirebaseFirestoreTransactionLogRemoteDataSource>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i14.FirebaseAuthenticationRemoteDataSource>(
    () => _i14.FirebaseAuthenticationRemoteDataSourceImpl(
      firebaseAuth: gh<_i3.FirebaseAuth>(),
      db: gh<_i4.FirebaseFirestore>(),
    ),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i15.FirestoreAddTransaction>(
    () => _i15.FirestoreAddTransaction(
        repository: gh<_i9.FirestoreTransacitonRepository>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i16.FirestoreAddTransactionLog>(
    () => _i16.FirestoreAddTransactionLog(
        repository: gh<_i11.FirestoreTransactionLogRepository>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i17.FirestoreCreateInvoice>(
    () => _i17.FirestoreCreateInvoice(
        repository: gh<_i7.FirestoreInvoiceRepository>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i18.FirestoreDeleteInvoice>(
    () => _i18.FirestoreDeleteInvoice(
        repository: gh<_i7.FirestoreInvoiceRepository>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i19.FirestoreGetInvoiceDetail>(
    () => _i19.FirestoreGetInvoiceDetail(
        repository: gh<_i7.FirestoreInvoiceRepository>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i20.FirestoreGetInvoices>(
    () => _i20.FirestoreGetInvoices(
        repository: gh<_i7.FirestoreInvoiceRepository>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i21.FirestoreGetTransactions>(
    () => _i21.FirestoreGetTransactions(
        repository: gh<_i9.FirestoreTransacitonRepository>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i22.FirestoreGetTransactionsLog>(
    () => _i22.FirestoreGetTransactionsLog(
        repository: gh<_i11.FirestoreTransactionLogRepository>()),
    registerFor: {_prod},
  );
  gh.factory<_i23.FirestoreInvoiceNotifier>(() => _i23.FirestoreInvoiceNotifier(
        firestoreCreateInvoice: gh<_i17.FirestoreCreateInvoice>(),
        firestoreDeleteInvoice: gh<_i18.FirestoreDeleteInvoice>(),
        firestoreGetInvoices: gh<_i20.FirestoreGetInvoices>(),
        firestoreGetInvoiceDetail: gh<_i19.FirestoreGetInvoiceDetail>(),
      ));
  gh.factory<_i24.FirestoreTransactionLogNotifier>(
      () => _i24.FirestoreTransactionLogNotifier(
            firestoreAddTransactionLog: gh<_i16.FirestoreAddTransactionLog>(),
            firestoreGetTransactionsLog: gh<_i22.FirestoreGetTransactionsLog>(),
          ));
  gh.factory<_i25.FirestoreTransactionNotifier>(
      () => _i25.FirestoreTransactionNotifier(
            firestoreAddTransaction: gh<_i15.FirestoreAddTransaction>(),
            firestoreGetTransactions: gh<_i21.FirestoreGetTransactions>(),
          ));
  gh.lazySingleton<_i26.FirebaseAuthRepository>(
    () => _i27.FirebaseAuthRepositoryImpl(
        remoteDataSource: gh<_i14.FirebaseAuthenticationRemoteDataSource>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i28.FirebaseAuthResetPassword>(
    () => _i28.FirebaseAuthResetPassword(
        repository: gh<_i26.FirebaseAuthRepository>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i29.FirebaseAuthSignIn>(
    () =>
        _i29.FirebaseAuthSignIn(repository: gh<_i26.FirebaseAuthRepository>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i30.FirebaseAuthSignOut>(
    () =>
        _i30.FirebaseAuthSignOut(repository: gh<_i26.FirebaseAuthRepository>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i31.FirebaseAuthSignUp>(
    () =>
        _i31.FirebaseAuthSignUp(repository: gh<_i26.FirebaseAuthRepository>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i32.FirebaseStoreUser>(
    () => _i32.FirebaseStoreUser(repository: gh<_i26.FirebaseAuthRepository>()),
    registerFor: {_prod},
  );
  gh.factory<_i33.FirebaseAuthNotifier>(() => _i33.FirebaseAuthNotifier(
        firebaseAuthSignUp: gh<_i31.FirebaseAuthSignUp>(),
        firebaseAuthSignIn: gh<_i29.FirebaseAuthSignIn>(),
        firebaseAuthSignOut: gh<_i30.FirebaseAuthSignOut>(),
        firebaseAuthResetPassword: gh<_i28.FirebaseAuthResetPassword>(),
        firebaseStoreUser: gh<_i32.FirebaseStoreUser>(),
      ));
  return getIt;
}

class _$RegisterModule extends _i34.RegisterModule {}
