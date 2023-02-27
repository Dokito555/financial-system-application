// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:flutter_financial/data/datasource/remote/firebase_auth.dart'
    as _i4;
import 'package:flutter_financial/data/repository/firebase_auth_repository_impl.dart'
    as _i6;
import 'package:flutter_financial/domain/repository/firebase_auth_repository.dart'
    as _i5;
import 'package:flutter_financial/domain/usecases/firebase_auth/reset_password.dart'
    as _i7;
import 'package:flutter_financial/domain/usecases/firebase_auth/signIn.dart'
    as _i8;
import 'package:flutter_financial/domain/usecases/firebase_auth/signOut.dart'
    as _i9;
import 'package:flutter_financial/domain/usecases/firebase_auth/signUp.dart'
    as _i10;
import 'package:flutter_financial/presentation/provider/firebase_auth_notifier.dart'
    as _i11;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'register_module.dart' as _i12;

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
  gh.lazySingleton<_i5.FirebaseAuthRepository>(
    () => _i6.FirebaseAuthRepositoryImpl(
        remoteDataSource: gh<_i4.FirebaseAuthenticationRemoteDataSource>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i7.FirebaseAuthResetPassword>(
    () => _i7.FirebaseAuthResetPassword(
        repository: gh<_i5.FirebaseAuthRepository>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i8.FirebaseAuthSignIn>(
    () => _i8.FirebaseAuthSignIn(repository: gh<_i5.FirebaseAuthRepository>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i9.FirebaseAuthSignOut>(
    () => _i9.FirebaseAuthSignOut(repository: gh<_i5.FirebaseAuthRepository>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i10.FirebaseAuthSignUp>(
    () => _i10.FirebaseAuthSignUp(repository: gh<_i5.FirebaseAuthRepository>()),
    registerFor: {_prod},
  );
  gh.factory<_i11.FirebaseAuthNotifier>(() => _i11.FirebaseAuthNotifier(
        firebaseAuthSignUp: gh<_i10.FirebaseAuthSignUp>(),
        firebaseAuthSignIn: gh<_i8.FirebaseAuthSignIn>(),
        firebaseAuthSignOut: gh<_i9.FirebaseAuthSignOut>(),
        firebaseAuthResetPassword: gh<_i7.FirebaseAuthResetPassword>(),
      ));
  return getIt;
}

class _$RegisterModule extends _i12.RegisterModule {}
