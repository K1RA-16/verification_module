// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:verification_module/apiAccess/postApis.dart';

class CheckFace extends StatefulWidget {
  final String uid;
  final String name;
  const CheckFace({
    Key? key,
    required this.uid,
    required this.name,
  }) : super(key: key);

  @override
  State<CheckFace> createState() => _CheckFaceState();
}

class _CheckFaceState extends State<CheckFace> {
  bool verified = false;
  String message = "";
  bool faceLoading = false;
  late bool result1;
  late bool result2;
  String faceImage = "";
  File? imageFile;
  @override
  void initState() {
    // TODO: implement initState
    verified = false;
    result1 = false;
    result2 = false;
    faceLoading = false;
    message = "Not verified";
    faceImage = "";
    super.initState();
  }

  check() async {
    // TODO: implement initState
    try {
      setState(() {
        message = "";
        result1 = false;
        result2 = false;
      });
      final ImagePicker _picker = ImagePicker();

      // Capture a photo
      var image = await _picker.getImage(
          source: ImageSource.camera,
          preferredCameraDevice: CameraDevice.rear,
          imageQuality: 85);
      Uint8List imagebytes = await image!.readAsBytes(); //convert to bytes
      faceImage = base64.encode(imagebytes); //convert bytes to base64 string
      //VxToast.show(context, msg: "please wait while we check the image");
      // Navigator.pop(context);
      // showDialog(
      //     context: context,
      //     builder: (BuildContext context) => _buildPopUpWait(context));

      setState(() {
        faceLoading = true;
        VxToast.show(context,
            msg: "please wait unitl we process the image", showTime: 2000);
      });
      //bool faceCorrect = false; //optional
      // bool faceCorrect = await PostApi().checkFace(
      //     "data:image/jpeg;base64,$faceImage",
      //     context,
      //     satsangiListData.satsangiList[index].uid);
      bool faceCorrect = true;
      var data = await PostApi().checkFace(widget.uid, faceImage);
      message = data["message"];
      print(data["result"]);
      if (data["result"])
        result1 = true;
      else
        result2 = true;
      setState(() {
        // faceCorrect = true; // optional
        faceLoading = false;
        verified = true;
      });
      //  faceapi not working

      // if (!faceCorrect) {
      //   VxToast.show(context, msg: "please capture image again");
      // }
      // if (image != null && faceCorrect) {
      //   imageFile = File(image.path);
      //   photoTaken = true;

      //   showDialog(
      //       context: context,
      //       builder: (BuildContext context) => _buildPopupImage(context));
      //   setState(() {});
      // }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: "Verify face".text.make(),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          20.heightBox,
          Card(
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                Center(
                        child: Text('UID: ${widget.uid}',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)))
                    .p(10),
                Center(
                    child: Text(
                  'Name: ${widget.name}',
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                )).p(10),
                Center(
                  child: Text(
                    '$message',
                    style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ).p(10),
              ],
            ),
          ).p(10),
          10.heightBox,
          if (result1) LottieBuilder.asset("assets/done.json"),
          if (result2) LottieBuilder.asset("assets/cancel.json"),
          10.heightBox,
          !verified
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () {
                    check();
                  },
                  child: "verify".text.bold.make())
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () {
                    check();
                  },
                  child: "verify again".text.bold.make())
        ]),
      ),
    );
  }
}
