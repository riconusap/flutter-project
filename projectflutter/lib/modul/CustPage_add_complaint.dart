import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http_parser/http_parser.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:projectflutter/config.dart';
import 'package:projectflutter/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AddComplaint extends StatefulWidget {
  _AddData createState() => _AddData();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  // ..customAnimation = CustomAnimation();
}

class _AddData extends State<AddComplaint> {
  List<Asset> images = [];
  Dio dio = Dio();
  TextEditingController namalaporan = new TextEditingController();
  String email = "";
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
    //EasyLoading.showSuccess('Use in initState');
  }

  get_email_user() async {
    SharedPreferences logindata = await SharedPreferences.getInstance();
    setState(() {
      email = logindata.getString('email')!;
    });
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 7,
      mainAxisSpacing: 7,
      padding: EdgeInsets.all(14),
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        materialOptions: MaterialOptions(
          actionBarColor: "#219F94",
          actionBarTitle: "Pilih Foto",
          statusBarColor: "#219F94",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
    });
  }

  _saveImage() async {
    int count = 0;
    get_email_user();
    var response = await http.post(
        Uri.parse("https://sdarrahman.000webhostapp.com/upload_complaint.php"),
        body: {
          "complaint_detail": namalaporan.text,
          "email": email,
        });
    print(response.body);
    if (images != null) {
      for (var i = 0; i < images.length; i++) {
        ByteData byteData = await images[i].getByteData();
        List<int> imageData = byteData.buffer.asUint8List();
        MultipartFile multipartFile = MultipartFile.fromBytes(imageData,
            filename: images[i].name, contentType: MediaType('image', 'jpg'));
        FormData formData =
            FormData.fromMap({"image": multipartFile, "email": email});
        EasyLoading.show(status: 'Uploading... $count');
        var response = await dio.post(
          UPLOAD_IMAGE,
          data: formData,
        );
        if (response.statusCode == 200) {
          count++;
          print(response.data);
          EasyLoading.dismiss();
          EasyLoading.showSuccess('Success $count');
        }
        Navigator.pushReplacementNamed(context, '/checkHistory');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    get_email_user();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xff86C6F4)),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, '/CustPage'),
          ),
          backgroundColor: Color(0xff139487),
          elevation: 0,
          title: Text(
            "Add Data",
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
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
                        // controller: email,
                        controller: namalaporan,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                            hintText: 'Jenis Komplain',
                            hintStyle: TextStyle(color: Colors.black38),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(14),
                            prefixIcon: Icon(
                              Icons.build,
                              color: Color(0xff139487),
                            )),
                      ),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                        onPressed: () {
                          loadAssets();
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff139487),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 20),
                            fixedSize: const Size(360, 70),
                            textStyle: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.filter),
                            SizedBox(width: 10),
                            Text("Tambah Foto")
                          ],
                        )),
                    SizedBox(height: 30),
                    Expanded(
                      child: buildGridView(),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                        onPressed: () {
                          _saveImage();
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff139487),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 20),
                            fixedSize: const Size(360, 70),
                            textStyle: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.save),
                            SizedBox(width: 10),
                            Text("Submit")
                          ],
                        )),
                    SizedBox(height: 30),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
