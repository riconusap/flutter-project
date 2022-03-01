import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'complaint-api.dart';
import 'complaint.dart';

class CustHistori extends StatefulWidget {
  _CustHistori createState() => _CustHistori();
}

class _CustHistori extends State<CustHistori> {
  TextEditingController email = new TextEditingController();
  @override
  Widget build(BuildContext context) {
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
              "Histori Laporan",
            )),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Container(
            alignment: Alignment.topCenter,
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: FutureBuilder(
              future: fetchComplaints(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, index) {
                      Complaints complaints = snapshot.data[index];
                      return Container(
                          padding: EdgeInsets.only(bottom: 10.0),
                          alignment: Alignment.topCenter,
                          child: Stack(
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
                                    Image.network(
                                      'https://sdarrahman.000webhostapp.com/images/${complaints.image}',
                                      height: 100,
                                      width: 120,
                                      fit: BoxFit.fitWidth,
                                    ),
                                    SizedBox(width: 15),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(height: 9),
                                        Text(
                                          'No : ${complaints.idComplaint}',
                                          textAlign: TextAlign.left,
                                        ),
                                        SizedBox(height: 9),
                                        Text(
                                          '${complaints.complaintDetail}',
                                          textAlign: TextAlign.left,
                                        ),
                                        SizedBox(height: 9),
                                        Text('CS : ${complaints.handleByCsId}'),
                                        SizedBox(height: 9),
                                        Text(
                                          'Teknisi : ${complaints.handleByTekId}',
                                          textAlign: TextAlign.left,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Text(
                                              '${complaints.status}',
                                              textAlign: TextAlign.start,
                                            ),
                                            TextButton(
                                                onPressed: () {},
                                                child: Text('Follow Up'))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ));
                    },
                  );
                }
                return CircularProgressIndicator();
              },
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Color(0xff139487),
                  Color(0xff86C6F4),
                ])),
          ),
        ));
  }
}
