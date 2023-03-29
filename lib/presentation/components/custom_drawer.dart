import 'package:flutter/material.dart';

import '../../core/routes/route_paths.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Center(
                child: Text('Financial Application'),
              ),
            ),
            const ListTile(
              leading: Text('Dashboard', style: TextStyle(fontWeight: FontWeight.bold),)
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Informasi'),
              onTap: () {
                Navigator.pushReplacementNamed(context, AppRoutePaths.informationPageRoute);
              },
            ),
            ListTile(
              leading: const Icon(Icons.hexagon_outlined),
              title: const Text('Pengaturan'),
              onTap: () {
                Navigator.pushReplacementNamed(context, AppRoutePaths.invoiceFormRoute);
              },
            ),
            ListTile(
              leading: const Icon(Icons.space_dashboard_outlined),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pushReplacementNamed(context, AppRoutePaths.homeRoute);
              },
            ),
            const ListTile(
              leading: Text('Tagihan', style: TextStyle(fontWeight: FontWeight.bold),)
            ),
            ListTile(
              leading: const Icon(Icons.file_upload_outlined),
              title:  const Text('Buat Tagihan'),
              onTap: () {
                Navigator.pushReplacementNamed(context, AppRoutePaths.invoiceFormRoute);
              },
            ),
            ListTile(
              leading: const Icon(Icons.email_outlined),
              title: const Text('Tagihan'),
              onTap: () {
                Navigator.pushReplacementNamed(context, AppRoutePaths.invoicePageRoute);
              },
            ),
            const ListTile(
              leading: Text('Transaksi', style: TextStyle(fontWeight: FontWeight.bold),)
            ),
            ListTile(
              leading: const Icon(Icons.file_copy_outlined),
              title: const Text('Transaksi'),
              onTap: () {
                Navigator.pushReplacementNamed(context, AppRoutePaths.transactionPageRoute);
              },
            ),
            ListTile(
              leading: const Icon(Icons.data_array),
              title: const Text('Log Transaksi'),
              onTap: () {
                Navigator.pushReplacementNamed(context, AppRoutePaths.transactionLogPageRoute);
              },
            ),
        ],
      ),
    );
  }
}