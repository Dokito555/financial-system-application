import 'package:flutter/material.dart';
import 'package:flutter_financial/presentation/components/loading.dart';
import 'package:flutter_financial/presentation/components/show_toast.dart';
import 'package:flutter_financial/presentation/provider/firebase_auth_notifier.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../../core/routes/route_paths.dart';
import '../../../core/utility/state_enum.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finance'),
        actions:  <Widget>[
          _logoutButton(context)
        ],
      ),
      drawer: _buildDrawer(context)
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return  Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Center(
                child: Text('Finance App')
              ),
            ),
            ListTile(
              title: const Text('Transaksi'),
              onTap: () {

              },
            ),
            ListTile(
              title: const Text('Tagihan'),
              onTap: () {

              },
            ),
            ListTile(
            title: const Text('Data Transaksi'),
            onTap: () {
              
            },
          )
        ],
      ),
    );
  }

  Widget _logoutButton(BuildContext context) {


    var authNotifier = Provider.of<FirebaseAuthNotifier>(context, listen: false);

    Future<void> logout() async {

      await authNotifier.authSignOut();

      if (authNotifier.status == Status.Error) {
        ShowToast.toast(authNotifier.message);
      } else if (authNotifier.status == Status.Success) {
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