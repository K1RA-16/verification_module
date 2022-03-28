import 'dart:convert';

import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:verification_module/pages/verify.dart';

import '../apiAccess/firebaseLogApis.dart';
import '../apiAccess/postApis.dart';

String selectedLocation = "select branch";
List<DropdownMenuItem<String>> dropdownItems = [];

class HomePage extends StatefulWidget {
  static const platform =
      const MethodChannel("com.example.dayalbaghidregistration/getBitmap");
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState
    loading = false;
    //  getPhoneData();

    super.initState();
  }

  Future<PermissionStatus> _getCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      final result = await Permission.camera.request();
      return result;
    } else {
      return status;
    }
  }

  checkPermission() async {
    var status = await _getCameraPermission();
    if (status.isGranted) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const QRViewExample(),
      ));
    }
  }

  list() async {
    print(selectedLocation);
    setState(() {
      loading = true;
    });
    Navigator.pushNamed(context, "/verify");

    setState(() {
      loading = false;
    });
  }

  logout() async {
    EncryptedSharedPreferences encryptedSharedPreferences =
        EncryptedSharedPreferences();
    await encryptedSharedPreferences.setString("token", " ");

    Navigator.pushNamedAndRemoveUntil(context, "/login", (r) => false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "Home",
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
          actions: [
            InkWell(
                onTap: () {
                  logout();
                },
                child: Icon(Icons.logout).pOnly(right: 20)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Container(
              child: SingleChildScrollView(
            child: Column(
              children: [
                const HeightBox(20),
                InkWell(
                  onTap: () => {
                    list(),
                    // if (selectedLocation != "select branch" && !loading)
                    //   {}
                    // else
                    //   {VxToast.show(context, msg: "please select a branch")}
                  },
                  child: Card(
                    borderOnForeground: true,
                    elevation: 8,
                    margin: EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.blueGrey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.verified),
                        10.widthBox,
                        Center(
                          child: Text("Verify through face",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 19)),
                        ),
                      ],
                    ).p(20),
                  ),
                ),
                const HeightBox(10),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
