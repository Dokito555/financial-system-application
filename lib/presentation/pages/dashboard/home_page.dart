import 'package:flutter/material.dart';
import 'package:flutter_financial/presentation/components/loading.dart';
import 'package:flutter_financial/presentation/components/show_toast.dart';
import 'package:flutter_financial/presentation/provider/firebase_auth_notifier.dart';
import 'package:flutter_financial/presentation/provider/firestore_invoice_notifier.dart';
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
          _logoutButton(context),
          // Consumer<FirestoreInvoiceNotifier>(
          //   builder:(context, value, child) {
          //     if (value.status == Status.Success) {
          //       return ListView.builder(
          //         shrinkWrap: true,
          //         itemCount: value.invoices.length,
          //         itemBuilder: (context, index) {
          //           return Column(
          //             children: [
          //               ListTile(
          //                 title: Text('${value.invoices[index].invoiceNumber}'),
          //               )
          //             ],
          //           );
          //         },
          //       );
          //     } else {
          //       throw Exception();
          //     }
          //   },
          // )
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
            // DrawerHeader(
            //   child: Center(
            //     child: Image.asset('images/IDNBS.svg', width: 110, height: 51),
            //   ),
            // ),
            ListTile(
              leading: Text('Dashboard')
            ),
            ListTile(
              // leading: Image.asset('images/info_l.svg'),
              title: const Center(
                child: Text('Informasi'),
              ),
              onTap: () {
                Navigator.pushNamed(context, AppRoutePaths.invoiceFormRoute);
              },
            ),
            ListTile(
              // leading: Image.asset('images/settings_l.svg'),
              title: const Center(
                child: Text('Pengaturan'),
              ),
              onTap: () {
                Navigator.pushNamed(context, AppRoutePaths.invoiceFormRoute);
              },
            ),
            ListTile(
              // leading: Image.asset('images/dashboard_l.svg'),
              title: const Center(
                child: Text('Dashboard'),
              ),
              onTap: () {
                Navigator.pushNamed(context, AppRoutePaths.invoiceFormRoute);
              },
            ),
            ListTile(
              leading: Text('Tagihan')
            ),
            ListTile(
              // leading: Image.asset('images/add_invoice_l.svg'),
              title: const Center(
                child: Text('Buat Tagihan'),
              ),
              onTap: () {
                Navigator.pushNamed(context, AppRoutePaths.invoiceFormRoute);
              },
            ),
            ListTile(
              // leading: Image.asset('images/invoice_l.svg'),
              title: const Center(
                child: Text('Tagihan'),
              ),
              onTap: () {
                Navigator.pushNamed(context, AppRoutePaths.invoiceFormRoute);
              },
            ),
            ListTile(
              leading: Text('Transaksi')
            ),
            ListTile(
              // leading: Image.asset('images/transaction_l.svg'),
              title: const Center(
                child: Text('Transaksi'),
              ),
              onTap: () {
                Navigator.pushNamed(context, AppRoutePaths.invoiceFormRoute);
              },
            ),
            ListTile(
              // leading: Image.asset('images/log_t_l.svg'),
              title: const Center(
                child: Text('Log Transaksi'),
              ),
              onTap: () {
                Navigator.pushNamed(context, AppRoutePaths.invoiceFormRoute);
              },
            ),
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