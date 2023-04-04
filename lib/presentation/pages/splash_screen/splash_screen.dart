import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_financial/presentation/pages/dashboard/home_page.dart';
import 'package:flutter_financial/presentation/pages/signIn/signin_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
        () => Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => FirebaseAuth.instance.currentUser == null ? const SignInPage() : const HomePage()
        )
      )
    );
    print('Splash!');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child:  Image.asset('images/IDNBS.png')
    );
  }
}
