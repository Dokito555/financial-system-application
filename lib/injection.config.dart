// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:flutter_financial/data/datasource/remote/firebase_auth.dart'
    as _i4;
import 'package:flutter_financial/data/datasource/remote/firebase_invoice_db.dart'
    as _i6;
import 'package:flutter_financial/data/repository/firebase_auth_repository_impl.dart'
    as _i10;
import 'package:flutter_financial/data/repository/firestore_invoice_repository_impl.dart'
    as _i8;
import 'package:flutter_financial/domain/repository/firebase_auth_repository.dart'
    as _i9;
import 'package:flutter_financial/domain/repository/firestore_invoice_repository.dart'
    as _i7;
import 'package:flutter_financial/domain/usecases/firebase_auth/reset_password.dart'
    as _i11;
import 'package:flutter_financial/domain/usecases/firebase_auth/signIn.dart'
    as _i12;
import 'package:flutter_financial/domain/usecases/firebase_auth/signOut.dart'
    as _i13;
import 'package:flutter_financial/domain/usecases/firebase_auth/signUp.dart'
    as _i14;
import 'package:flutter_financial/domain/usecases/firestore_invoice/create_invoice.dart'
    as _i15;
import 'package:flutter_financial/presentation/provider/firebase_auth_notifier.dart'
    as _i17;
import 'package:flutter_financial/presentation/provider/firestore_invoice_notifier.dart'
    as _i16;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'register_module.dart' as _i18;

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
      () => registerModule.firebaseFiresotre);
  gh.lazySingleton<_i6.FirebaseFirestoreInvoiceDatabaseRemoteDataSource>(
    () => _i6.FirebaseFirestoreInvoiceDatabaseRemoteDataSourceImpl(
        db: gh<_i5.FirebaseFirestore>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i7.FirestoreInvoiceRepository>(
    () => _i8.FirestoreInvoiceRepositoryImpl(
        remoteDataSource:
            gh<_i6.FirebaseFirestoreInvoiceDatabaseRemoteDataSource>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i9.FirebaseAuthRepository>(
    () => _i10.FirebaseAuthRepositoryImpl(
        remoteDataSource: gh<_i4.FirebaseAuthenticationRemoteDataSource>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i11.FirebaseAuthResetPassword>(
    () => _i11.FirebaseAuthResetPassword(
        repository: gh<_i9.FirebaseAuthRepository>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i12.FirebaseAuthSignIn>(
    () => _i12.FirebaseAuthSignIn(repository: gh<_i9.FirebaseAuthRepository>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i13.FirebaseAuthSignOut>(
    () =>
        _i13.FirebaseAuthSignOut(repository: gh<_i9.FirebaseAuthRepository>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i14.FirebaseAuthSignUp>(
    () => _i14.FirebaseAuthSignUp(repository: gh<_i9.FirebaseAuthRepository>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i15.FirestoreCreateInvoice>(
    () => _i15.FirestoreCreateInvoice(
        repository: gh<_i7.FirestoreInvoiceRepository>()),
    registerFor: {_prod},
  );
  gh.factory<_i16.FirestoreInvoiceNotifier>(() => _i16.FirestoreInvoiceNotifier(
      firestoreCreateInvoice: gh<_i15.FirestoreCreateInvoice>()));
  gh.factory<_i17.FirebaseAuthNotifier>(() => _i17.FirebaseAuthNotifier(
        firebaseAuthSignUp: gh<_i14.FirebaseAuthSignUp>(),
        firebaseAuthSignIn: gh<_i12.FirebaseAuthSignIn>(),
        firebaseAuthSignOut: gh<_i13.FirebaseAuthSignOut>(),
        firebaseAuthResetPassword: gh<_i11.FirebaseAuthResetPassword>(),
      ));
  return getIt;
}

class _$RegisterModule extends _i18.RegisterModule {}
