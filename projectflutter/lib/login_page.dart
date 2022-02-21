import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:projectflutter/CustPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginUI extends StatefulWidget {
  @override
  _LoginUI createState() => _LoginUI();
}

enum LoginStatus { notSignIn, signIn }

class _LoginUI extends State<LoginUI> {
  TextEditingController email = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  String msg = "";
  String _id_user = "";
  bool newuser = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check_if_already_login();
  }

  void check_if_already_login() async {
    SharedPreferences logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => CustPage()));
    }
  }

  // Future<void> getValidationLogin() async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   String cekEmail = sharedPreferences.getString('email').toString();
  //   if (cekEmail != null) {
  //     Navigator.of(context)
  //         .push(MaterialPageRoute(builder: (context) => CustPage()));
  //   } else {
  //     Navigator.pushReplacementNamed(context, '/logout');
  //   }
  // }

  LoginStatus _loginStatus = LoginStatus.notSignIn;

  Future<List?> _login() async {
    SharedPreferences logindata = await SharedPreferences.getInstance();
    final response = await http.post(
        Uri.parse("https://sdarrahman.000webhostapp.com/login.php"),
        body: {
          "email": email.text,
          "password": pass.text,
        });
    // ignore: avoid_print
    print(response.body);
    var user = json.decode(response.body);

    // Future<void> setValidationLogin() async {
    //   final jembatan = await SharedPreferences.getInstance();
    //   if (jembatan.containsKey('email')) {
    //     jembatan.clear();
    //   }
    //   final finalemail = user["email"][0].toString();
    //   jembatan.setString('email', finalemail);
    //   setState(() {});
    // }

    if (user.length == 0) {
      setState(() {
        msg = "Login Failed";
      });
    } else {
      logindata.setBool('login', false);
      logindata.setString('email', email.text);
      String id_user = user[0]['id_user'].toString();
      if (user[0]["level"] == "cs") {
        setState(() {
          _loginStatus = LoginStatus.signIn;
          Navigator.pushReplacementNamed(context, '/CsPage');
        });
      } else if (user[0]["level"] == "customer") {
        setState(() {
          _loginStatus = LoginStatus.signIn;
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CustPage()));
          // setValidationLogin();
        });
      } else if (user[0]["level"] == "teknisi") {
        setState(() {
          Navigator.pushReplacementNamed(context, '/TekPage');
        });
      } else {
        setState(() {
          msg = "";
        });
      }
      setState(() {
        id_user = user[0]['id_user'];
      });
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    // getValidationLogin();
    // print("test");
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
            child: Stack(children: <Widget>[
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
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 120),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Image.asset('assets/image/logo.png'),
                  SizedBox(height: 50),
                  Container(
                    alignment: Alignment.center,
                    width: 360,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(0, 2))
                        ]),
                    height: 60,
                    child: TextField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.black38),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(14),
                          prefixIcon: Icon(
                            Icons.email_rounded,
                            color: Color(0xff139487),
                          )),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.center,
                    width: 360,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(0, 2))
                        ]),
                    height: 60,
                    child: TextField(
                      controller: pass,
                      obscureText: true,
                      style: TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.black38),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(14),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color(0xff139487),
                          )),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    msg,
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      _login();
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xff139487),
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    child: const Text(
                      'Login',
                    ),
                  ),
                ],
              ),
            ),
          )
        ])),
      ),
    );
  }
}
