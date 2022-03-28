import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:velocity_x/velocity_x.dart';

import 'checkFace.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<QRViewExample> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool proceed = false;
  var result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  void initState() {
    // TODO: implement initState
    proceed = false;
    super.initState();
  }

  checkFace() {
    controller?.dispose();
    Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) =>
              CheckFace(name: result[0], uid: result[1]),
        )).then((value) => reassemble());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: "Scan QR".text.make(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            20.heightBox,
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 20,
                height: MediaQuery.of(context).size.width - 20,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: _onQRViewCreated,
                  ),
                ),
              ).expand(),
            ),
            10.heightBox,
            if ((result != null))
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    Center(
                            child: Text('UID: ${result[0]!}',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)))
                        .p(10),
                    Center(
                        child: Text(
                      'Name: ${result[1]}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    )).p(10),
                  ],
                ),
              ),
            50.heightBox,
            if (result != null)
              InkWell(
                onTap: () {
                  checkFace();
                },
                child: const Icon(
                  Icons.arrow_circle_right,
                  size: 60,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      result = scanData.code?.split("|");
      try {
        if (result[1] != null) setState(() {});
      } catch (e) {
        result = null;
        // TODO
        VxToast.show(context, msg: "scan a valid qr code");
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
