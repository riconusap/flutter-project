import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CsPage extends StatefulWidget {
  @override
  _CsPage createState() => _CsPage();
}

class _CsPage extends State<CsPage> {
  String email = "";

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    SharedPreferences logindata = await SharedPreferences.getInstance();
    setState(() {
      email = logindata.getString('email')!;
    });
  }

  _logout() async {
    SharedPreferences logindata = await SharedPreferences.getInstance();
    logindata.setBool('login', true);
    Navigator.pushReplacementNamed(context, '/logout');
  }

  complaintProcess() {
    setState(() {
      Navigator.pushReplacementNamed(context, '/complaintProcess');
    });
  }

  checkHistory() {
    setState(() {
      Navigator.pushReplacementNamed(context, '/checkHistory');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 120),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Hello $email'),
                          SizedBox(height: 10),
                          Image.asset('assets/image/logo.png'),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              complaintProcess();
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
