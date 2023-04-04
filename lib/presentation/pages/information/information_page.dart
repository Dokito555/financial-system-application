import 'package:flutter/material.dart';
import 'package:flutter_financial/core/utility/constants.dart';
import 'package:flutter_financial/presentation/components/custom_drawer.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColorConstants.fillColor,
      appBar: AppBar(
        title: const Text('Informasi', style: TextStyle(color: Colors.black),),
        iconTheme: const IconThemeData(color: Color(0xff777474)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: const <Widget>[
          
        ],
      ),
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
          ),
          child: const Text('Financial App'),
        ),
      ),
      drawer: const CustomDrawer(),
    );
  }
}