import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logica_entrata_merce/pages/login_page.dart';
import 'package:logica_entrata_merce/pages/warehouse_page.dart';
import 'package:logica_entrata_merce/pages/customer_page.dart';
import 'package:logica_entrata_merce/pages/truck_page.dart';
import 'package:logica_entrata_merce/pages/udc_page.dart';
import 'package:logica_entrata_merce/pages/article_page.dart';
import 'package:logica_entrata_merce/pages/new_article_page.dart';
import 'package:logica_entrata_merce/pages/qty_page.dart';
import 'package:logica_entrata_merce/pages/qty_editpage.dart';
import 'package:logica_entrata_merce/pages/position_page.dart';
import 'package:logica_entrata_merce/pages/resume_page.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Color(0xFF005DA7)));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LOGICA Dr.Vranjes Entrate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/warehouse', page: () => WarehousePage()),
        GetPage(name: '/customer', page: () => CustomerPage()),
        GetPage(name: '/truck', page: () => TruckPage()),
        GetPage(name: '/udc', page: () => UdcPage()),
        GetPage(name: '/article', page: () => ArticlePage()),
        GetPage(name: '/qty', page: () => QtyPage()),
        GetPage(name: '/qty_edit', page: () => QtyEditPage()),
        GetPage(name: '/position', page: () => PositionPage()),
        GetPage(name: '/resume', page: () => ResumePage()),
        GetPage(name: '/newarticle', page: () => NewArticlePage()),
      ],
    );
  }
}
