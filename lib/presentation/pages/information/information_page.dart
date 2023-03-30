import 'package:flutter/material.dart';
import 'package:flutter_financial/presentation/components/custom_drawer.dart';
import 'package:flutter_financial/presentation/components/logout_button.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0x44000000),
        actions: const <Widget>[
          LogoutButton()
        ],
      ),
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
          ),
          child: Text('Financial App'),
        ),
      ),
      drawer: const CustomDrawer(),
    );
  }
}