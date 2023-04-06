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
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text('Tentang Aplikasi', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Text('Aplikasi Sistem Keuangan adalah suatu perangkat lunak yang dirancang untuk membantu pengelolaan keuangan suatu organisasi atau individu. Aplikasi ini dapat digunakan untuk memantau, mengelola, dan melaporkan aktivitas keuangan, seperti pencatatan pendapatan, hutang, piutang, serta pelaporan keuangan lainnya.'),
                SizedBox(height: 10,),
                Text('Aplikasi Sistem Keuangan ini menyediakan fitur-fitur yang memungkinkan pengguna untuk melakukan berbagai tugas keuangan, seperti pencatatan transaksi harian, pengaturan anggaran, perencanaan keuangan, analisis keuangan, dan penyusunan laporan keuangan. ')
              ],
            ),
          )
        ),
      ),
      drawer: const CustomDrawer(),
    );
  }
}