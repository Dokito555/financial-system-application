import 'package:flutter/material.dart';
import 'package:flutter_financial/presentation/components/custom_drawer.dart';
import 'package:flutter_financial/presentation/components/logout_button.dart';
import 'package:flutter_financial/presentation/provider/firebase_auth_notifier.dart';
import 'package:provider/provider.dart';

import '../../../core/routes/route_paths.dart';
import '../../../core/utility/constants.dart';
import '../../../core/utility/state_enum.dart';
import '../../components/show_toast.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => 
      Provider.of<FirebaseAuthNotifier>(context, listen: false)..getUser()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColorConstants.fillColor,
      appBar: AppBar(
        title: const Text('Pengaturan', style: TextStyle(color: Colors.black),),
        iconTheme: const IconThemeData(color: Color(0xff777474)),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Consumer<FirebaseAuthNotifier>(
          builder: (context, data, child) {
          final status = data.getUserStatus;
          final user = data.userDetail;
          if (status == Status.Loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (status == Status.Error) {
            return Center(child: Text(data.message));
          }
          if (status == Status.Success) {
            return Container(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 10,
              ),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      Text(user.name),
                      _logoutButton(context)
                    ],
                  ),
                ),
              )
            );
          }
          return const Center(child: Text('Something\'s wrong please try again'));
          },
        ),
      ),
      drawer: const CustomDrawer(),
    );
  }

  Widget _logoutButton(BuildContext context) {

    var authNotifier = Provider.of<FirebaseAuthNotifier>(context);

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

    return authNotifier.signOutStatus == Status.Loading
    ? const Center(child: CircularProgressIndicator())
    : Container(
        width: MediaQuery. of(context).size.width,
        height: 50,
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: AppColorConstants.primaryColor
          ),
          child: const Text('Logout'),
          onPressed: () async {
            logout();
          },
       )
    );
  }
}