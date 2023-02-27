import 'package:fluttertoast/fluttertoast.dart';

class ShowToast {
  static toast(String toast) {
    return Fluttertoast.showToast(
      msg: toast,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
    );
  }
}