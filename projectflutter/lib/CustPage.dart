import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

// String finalemail = "";

class CustPage extends StatefulWidget {
  @override
  _CustPage createState() => _CustPage();
}

enum LoginStatus { notSignIn, signIn }

class _CustPage extends State<CustPage> {
  LoginStatus _loginStatus = LoginStatus.signIn;
  String email = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }

  void initial() async {
    SharedPreferences logindata = await SharedPreferences.getInstance();

    setState(() {
      email = logindata.getString('email').toString();
    });
  }

  // Future getValidationLogin() async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   var obtainEmail = sharedPreferences.getString('email').toString();
  //   finalemail = obtainEmail;
  //   setState(() {
  //     finalemail = obtainEmail;
  //   });
  // }

  // Future<void> setValidationLogin() async {
  //   final jembatan = await SharedPreferences.getInstance();
  //   setState(() {});
  // }

  _logout() async {
    SharedPreferences logindata = await SharedPreferences.getInstance();
    logindata.setBool('login', true);
    // final jembatan = await SharedPreferences.getInstance();
    // finalemail = "";
    // jembatan.setString('email', finalemail);
    Navigator.pushReplacementNamed(context, '/logout');
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // setState(() {
    //   finalemail = "";
    //   _loginStatus = LoginStatus.notSignIn;

    // });
  }

  addData() {
    setState(() {
      Navigator.pushReplacementNamed(context, '/addData');
    });
  }

  checkHistory() {
    setState(() {
      Navigator.pushReplacementNamed(context, '/checkHistory');
    });
  }

  @override
  Widget build(BuildContext context) {
    print("object");
    // getValidationLogin();
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
                      Text('Hello $email'),
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
                        onPressed: () {
                          checkHistory();
                        },
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
