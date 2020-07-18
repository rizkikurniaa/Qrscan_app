import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String data = "QR Code data";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("QR Scan")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                data,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              RaisedButton(
                child: Text("Scan QR"),
                onPressed: () {
                  scanQR();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void scanQR() async {
    bool result = await Permission.camera.shouldShowRequestRationale;
    PermissionStatus status = PermissionStatus.undetermined;

    if (!result) status = await Permission.camera.request();

    if (result || status.isGranted) {
      String scanResult = await scan();
      setState(() {
        data = scanResult;
      });
    }
  }
}
