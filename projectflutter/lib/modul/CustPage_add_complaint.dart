import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:permission_handler/permission_handler.dart';

class AddComplaint extends StatefulWidget {
  _AddData createState() => _AddData();
}

class _AddData extends State<AddComplaint> {
  List<Asset> images = [];

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
          actionBarColor: "#0ff86C",
          actionBarTitle: "Example App",
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                          // loadAssets();
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
