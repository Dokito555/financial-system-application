import 'package:flutter/material.dart';
import 'package:flutter_financial/presentation/pages/signUp/signup_page.dart';

const applicationName = "Finance App";
final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();
const firestoreInvoice = 'invoice';
const firestoreTransaciton = 'transaction';
const firestoreTransacitonLog = 'transactionLog';
const firestoreUsers = 'users';

class AppColorConstants {
  static const primaryColor = Color(0xff0249B8);
  static const fillColor = Color(0xffF8FAFB);
  static const lightPurpleColor = Color(0xffE0D9FF);
  static const lightPinkColor = Color(0xffFFC9DB);
  static const lightBlueColor = Color(0xffE0D9FF);
  static const pinkColor = Color(0xffFF77E1);
  static const purpleColor = Color(0xff855BEF);
  static const greenColor = Color(0xff34A853);
  static const lightGreyColor = Color(0xffF8FAFB);
}