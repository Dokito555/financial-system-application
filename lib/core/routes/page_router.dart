import 'package:flutter/material.dart';
import 'package:flutter_financial/core/routes/route_paths.dart';
import 'package:flutter_financial/presentation/pages/dashboard/home_page.dart';
import 'package:flutter_financial/presentation/pages/information/information_page.dart';
import 'package:flutter_financial/presentation/pages/invoice/invoice_page.dart';
import 'package:flutter_financial/presentation/pages/invoice_form/invoice_form_page.dart';
import 'package:flutter_financial/presentation/pages/signIn/signin_page.dart';
import 'package:flutter_financial/presentation/pages/signUp/signup_page.dart';
import 'package:flutter_financial/presentation/pages/splash_screen/splash_screen.dart';
import 'package:flutter_financial/presentation/pages/transaction/transaction_page.dart';
import 'package:flutter_financial/presentation/pages/transaction_log/transacction_log_page.dart';

class PageRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutePaths.homeRoute:
        return MaterialPageRoute(builder: (_) => HomePage());
      case AppRoutePaths.signUpPageRoute:
        return MaterialPageRoute(builder: (_) => SignUpPage());
      case AppRoutePaths.signInPageRoute:
        return MaterialPageRoute(builder: (_) => SignInPage());
      case AppRoutePaths.invoiceFormRoute:
        return MaterialPageRoute(builder: (_) => InvoiceFormPage());
      case AppRoutePaths.splashScreenPageRoute:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case AppRoutePaths.informationPageRoute:
        return MaterialPageRoute(builder: (_) => InformationPage());
      case AppRoutePaths.transactionPageRoute:
        return MaterialPageRoute(builder: (_) => TransactionPage());
      case AppRoutePaths.transactionLogPageRoute:
        return MaterialPageRoute(builder: (_) => TransactionLogPage());
      case AppRoutePaths.invoicePageRoute:
        return MaterialPageRoute(builder: (_) => InvoicePage());
      default:
        return MaterialPageRoute(builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        )
      );
    }
  }
}