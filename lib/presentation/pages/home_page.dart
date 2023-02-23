import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../core/routes/route_paths.dart';
import '../../core/utility/state_enum.dart';
import '../provider/auth_service.dart';

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


    var authProvider = Provider.of<AuthService>(context, listen: false);

    void _onLoading() {
      showDialog(
        context: context, 
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      );
    }

    Future<void> _logout() async {

      _onLoading();

      await authProvider.authLogout();

      if (authProvider.status == Status.Error) {
        Fluttertoast.showToast(
          msg: authProvider.message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1
        );
        Navigator.pop(context);
      } else if (authProvider.status == Status.Success) {
        Fluttertoast.showToast(
          msg: authProvider.message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1
        );
        Navigator.pushReplacementNamed(context, AppRoutePaths.signInPageRoute);
      } else {
        Fluttertoast.showToast(
          msg: 'Something\'s wrong please wait',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1
        );
        Navigator.pop(context);
      }
    }

    return IconButton(
      onPressed: () async {
        _logout();
      }, 
      icon: const Icon(Icons.logout)
    );
  }
}