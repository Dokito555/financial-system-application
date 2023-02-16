import 'package:flutter/material.dart';

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
        title: Text('Finance'),
      ),
      drawer: Drawer(
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
      ),
    );
  }
}