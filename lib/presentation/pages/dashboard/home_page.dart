import 'package:flutter/material.dart';
import 'package:flutter_financial/presentation/components/custom_drawer.dart';
import 'package:flutter_financial/presentation/components/loading.dart';
import 'package:flutter_financial/presentation/components/logout_button.dart';
import 'package:flutter_financial/presentation/components/show_toast.dart';
import 'package:flutter_financial/presentation/provider/firebase_auth_notifier.dart';
import 'package:flutter_financial/presentation/provider/firestore_invoice_notifier.dart';
import 'package:flutter_svg/svg.dart';
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
        actions: const <Widget>[
          LogoutButton()
        ],
      ),
      drawer: const CustomDrawer()
    );
  }
}