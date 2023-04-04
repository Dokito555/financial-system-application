import 'package:flutter/material.dart';
import 'package:flutter_financial/presentation/components/custom_drawer.dart';
import 'package:flutter_financial/presentation/components/loading.dart';
import 'package:flutter_financial/presentation/components/logout_button.dart';
import 'package:flutter_financial/presentation/components/show_toast.dart';
import 'package:flutter_financial/presentation/pages/dashboard/components/all_time_transaction_page.dart';
import 'package:flutter_financial/presentation/pages/dashboard/components/monthly_transaction_page.dart';
import 'package:flutter_financial/presentation/pages/dashboard/components/todays_transaction_page.dart';
import 'package:flutter_financial/presentation/pages/dashboard/components/total_transactions.dart';
import 'package:flutter_financial/presentation/provider/firebase_auth_notifier.dart';
import 'package:flutter_financial/presentation/provider/firestore_invoice_notifier.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/routes/route_paths.dart';
import '../../../core/utility/constants.dart';
import '../../../core/utility/state_enum.dart';
import 'components/total_nominal.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {

    TabController _tabController = TabController(length: 3, vsync: this);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColorConstants.fillColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xff777474)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Dashboard', style: TextStyle(color: Colors.black),),
        actions: const <Widget>[
         
        ],
      ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 10, left: 20, right: 20),
            // child: SingleChildScrollView(
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      TotalNominal(),
                      TotalTransactions(),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Align(
                        alignment: Alignment.centerLeft,
                        child: TabBar(
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey,
                          isScrollable: true,
                          controller: _tabController,
                          dividerColor: Colors.transparent,
                          indicatorColor: Colors.transparent,
                          tabs: const [
                            Tab(text: 'All Time',),
                            Tab(text: 'Today'),
                            Tab(text: 'This Month'),
                          ],
                        ),
                      ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: TabBarView(
                      physics: const ScrollPhysics(),
                      controller: _tabController,
                      children: const <Widget>[
                        AllTimeTransactionPage(),
                        TodaysTransactionPage(),
                        MonthlyTransactionPage()
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
      // ),

      drawer: const CustomDrawer()
    );
  }
}