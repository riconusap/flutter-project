import 'package:flutter/material.dart';
import 'package:projectflutter/login_page.dart';

import 'CsPage.dart';
import 'CustPage.dart';
import 'TekPage.dart';
import 'modul/CustPage_add_complaint.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App Name',
        home: LoginUI(),
        routes: <String, WidgetBuilder>{
          '/CsPage': (BuildContext context) => new CsPage(),
          '/TekPage': (BuildContext context) => new TekPage(),
          '/CustPage': (BuildContext context) => new CustPage(),
          '/logout': (BuildContext context) => new LoginUI(),
          '/addData': (BuildContext context) => new AddComplaint(),
        });
  }
}
