import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustPage extends StatefulWidget {
  @override
  _CustPage createState() => _CustPage();
}

enum LoginStatus { notSignIn, signIn }

class _CustPage extends State<CustPage> {
  LoginStatus _loginStatus = LoginStatus.signIn;

  _logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      // preferences.setInt("value", null);
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
      Navigator.pushReplacementNamed(context, '/logout');
    });
  }

  addData() {
    setState(() {
      Navigator.pushReplacementNamed(context, '/addData');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Color(0xff86C6F4),
                    Color(0xff139487),
                  ])),
              child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 120),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 10),
                      Image.asset('assets/image/logo.png'),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          addData();
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff139487),
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 20),
                            textStyle: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        child: const Text(
                          'Buat Laporan',
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff139487),
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 20),
                            textStyle: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        child: const Text(
                          'Cek Laporan',
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          _logout();
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff139487),
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 20),
                            textStyle: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        child: const Text(
                          'Logout',
                        ),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    ));
  }
}
