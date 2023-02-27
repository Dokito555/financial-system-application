// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_financial/core/routes/page_router.dart';
import 'package:flutter_financial/injection.dart';
import 'package:flutter_financial/presentation/provider/firebase_auth_notifier.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';
import 'core/routes/route_paths.dart';
import 'core/utility/constants.dart';
import 'firebase_options.dart';
import 'package:flutter_financial/injection.dart' as di;

Future<void> main() async {

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  // initialize dependency injection
  await di.configureDependencies(
    env: Environment.prod
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => sl<FirebaseAuthNotifier>(),
        )
      ],
      child: const MyApp(),
    )
  );

  FlutterNativeSplash.remove();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late StreamSubscription<User?> user;

  @override
  void initState() {
    super.initState();
    // Checking User
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        if (kDebugMode) {
          print('User is currently signed out!');
        }
      } else {
        if (kDebugMode) {
          print('User is signed in!');
        }
      }
    });
  }
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: applicationName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: FirebaseAuth.instance.currentUser == null ? AppRoutePaths.signInPageRoute : AppRoutePaths.homeRoute,
      navigatorObservers: [routeObserver],
      onGenerateRoute: PageRouter.generateRoute,
    );
  }

  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }
}
