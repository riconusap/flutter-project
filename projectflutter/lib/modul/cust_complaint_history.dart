import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustHistori extends StatefulWidget {
  _CustHistori createState() => _CustHistori();
}

class _CustHistori extends State<CustHistori> {
  TextEditingController email = new TextEditingController();
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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 20),
                      Container(
                        height: 155,
                        width: 340,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromARGB(255, 255, 255, 255),
                                  Color(0xff86C6F4),
                                ])),
                        child: Row(
                          children: [
                            SizedBox(width: 15),
                            Image.asset(
                              'assets/image/test.png',
                              height: 100,
                              width: 120,
                              fit: BoxFit.fitWidth,
                            ),
                            SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 9),
                                Text(
                                  'No : 12333992137',
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(height: 9),
                                Text(
                                  'Genting Bocor 1',
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(height: 9),
                                Text('CS : Karina'),
                                SizedBox(height: 9),
                                Text(
                                  'Teknisi : Badang',
                                  textAlign: TextAlign.left,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(
                                      'On Progress',
                                      textAlign: TextAlign.start,
                                    ),
                                    TextButton(
                                        onPressed: () {},
                                        child: Text('Follow Up'))
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        height: 136,
                        width: 340,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                              Color.fromARGB(255, 255, 255, 255),
                              Color(0xff86C6F4),
                            ])),
                      ),
                      SizedBox(height: 30),
                      Container(
                        height: 136,
                        width: 340,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                              Color.fromARGB(255, 255, 255, 255),
                              Color(0xff86C6F4),
                            ])),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
        ));
  }
}
