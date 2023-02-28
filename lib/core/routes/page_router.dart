import 'package:flutter/material.dart';
import 'package:flutter_financial/core/routes/route_paths.dart';
import 'package:flutter_financial/presentation/pages/dashboard/home_page.dart';
import 'package:flutter_financial/presentation/pages/signin_page.dart';
import 'package:flutter_financial/presentation/pages/signup_page.dart';

class PageRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutePaths.homeRoute:
        return MaterialPageRoute(builder: (_) => HomePage());
      case AppRoutePaths.signUpPageRoute:
        return MaterialPageRoute(builder: (_) => SignUpPage());
      case AppRoutePaths.signInPageRoute:
        return MaterialPageRoute(builder: (_) => SignInPage());
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