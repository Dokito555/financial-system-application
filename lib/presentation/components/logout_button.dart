import 'package:flutter/material.dart';
import 'package:flutter_financial/presentation/components/show_toast.dart';
import 'package:provider/provider.dart';

import '../../core/routes/route_paths.dart';
import '../../core/utility/state_enum.dart';
import '../provider/firebase_auth_notifier.dart';

  class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {

    var authNotifier = Provider.of<FirebaseAuthNotifier>(context, listen: false);

    Future<void> logout() async {

      await authNotifier.authSignOut();

      if (authNotifier.signOutStatus == Status.Error) {
        ShowToast.toast(authNotifier.message);
      } else if (authNotifier.signOutStatus == Status.Success) {
        ShowToast.toast(authNotifier.message);
        Navigator.pushReplacementNamed(context, AppRoutePaths.signInPageRoute);
      } else {
        ShowToast.toast(authNotifier.message);
      }
    }

    return IconButton(
      onPressed: () async {
        logout();
      }, 
      icon: const Icon(Icons.logout)
    );
  }
}