import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustHistori extends StatefulWidget {
  _CustHistori createState() => _CustHistori();
}

class _CustHistori extends State<CustHistori> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Color(0xff86C6F4)),
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, '/CustPage'),
            ),
            backgroundColor: Color(0xff139487),
            elevation: 0,
            title: Text(
              "Histori Laporan",
            )),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
              child: Stack(
            children: <Widget>[
              SizedBox(height: 30),
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color(0xff139487),
                      Color(0xff86C6F4),
                    ])),
              )
            ],
          )),
        ));
  }
}
