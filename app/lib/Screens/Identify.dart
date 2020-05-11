import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:facial_recognition/Screens/Loading.dart';
import 'package:facial_recognition/Screens/ResultNegative.dart';
import 'package:facial_recognition/Screens/ResultPositive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shadow/shadow.dart';

import '../helpers.dart';
import '../data/strings.dart';

class Identify extends StatefulWidget {
  @override
  _IdentifyState createState() => _IdentifyState();
}

class _IdentifyState extends State<Identify> {
  @override
  void initState() {
    super.initState();
    // 1
    availableCameras().then((availableCameras) {
      cameras = availableCameras;
      if (cameras.length > 0) {
        setState(() {
          // 2
          cameraId = 0;
        });

        _initCameraController(cameras[cameraId]).then((void v) {});
      } else {
        print("No camera available");
      }
    }).catchError((err) {
      // 3
      print('Error: $err.code\nError Message: $err.message');
    });
  }

  bool patientStatus = true;
  String name;
  String caseId;
  bool isLoading = true;
  Future<List<dynamic>> _checkPatient() async {
    final imageData = Helpers.imageToBase64String(imageLocation);
    final myDio = Dio();
    final response = await myDio.get('${Strings.baseApiUrl}/check_patient',
        queryParameters: {'image': imageData, 'tolerance': 0.5});
    final data = jsonDecode(response.data);

    final Map<String, dynamic> patientData = jsonDecode(data[0]);

    bool isPositive = patientData['isPositive'];

    if (data != null) {
      setState(() {
        isLoading = false;
      });
    }
    setState(() {
      patientStatus = isPositive;
      name = data["name"];
      caseId = data["caseId"];
    });

    return data;
  }

  void _onCapturePressed(context) async {
    try {
      // 1
      final path = join(
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}.png',
      );
      // 2
      await controller.takePicture(path);
      // 3

      var imageFile = new File(path);
      setState(() {
        imageLocation = imageFile;
      });
    } catch (e) {
      print(e);
    }
  }

  Future _initCameraController(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }

    // 3
    controller = CameraController(cameraDescription, ResolutionPreset.high);

    // If the controller is updated then update the UI.
    // 4
    controller.addListener(() {
      // 5
      if (mounted) {
        setState(() {});
      }

      if (controller.value.hasError) {
        print('Camera error ${controller.value.errorDescription}');
      }
    });

    // 6
    try {
      await controller.initialize();
    } on CameraException catch (e) {
      print(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'Loading',
        style: TextStyle(
          color: Colors.black,
          fontSize: 30.0,
          fontWeight: FontWeight.w900,
        ),
      );
    }

    return AspectRatio(
      aspectRatio: controller.value.aspectRatio * 4,
      child: CameraPreview(controller),
    );
  }

  CameraController controller;
  String imagePath;
  List cameras;
  int cameraId;

  File imageLocation;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_back),
          backgroundColor: Color.fromRGBO(0, 31, 70, 1),
          title: Center(
            child: Text(
              "Add Sample",
              style: GoogleFonts.aBeeZee(
                color: Colors.white,
                fontSize: 22.0,
              ),
            ),
          ),
          actions: <Widget>[
            Icon(Icons.settings),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 1,
                    color: Color.fromRGBO(14, 34, 71, 1),
                  ),
                  Stack(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40.0),
                        child: Container(
                          color: Color.fromRGBO(14, 34, 71, 1),
                          height: MediaQuery.of(context).size.height * 0.6,
                          width: MediaQuery.of(context).size.width * 1,
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.03),
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(200.0),
                              child: Container(
                                color: Colors.white,
                                height:
                                    MediaQuery.of(context).size.height * 0.45,
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: imageLocation == null
                                    ? _cameraPreviewWidget()
                                    : FittedBox(
                                        fit: BoxFit.fill,
                                        child: Image.file(imageLocation),
                                      ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _onCapturePressed(context);
                            },
                            child: Shadow(
                              offset: Offset(0, 5),
                              child: Image(
                                height:
                                    MediaQuery.of(context).size.height * 0.13,
                                width: MediaQuery.of(context).size.width * 0.15,
                                image: AssetImage("assets/shutter.png"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => patientStatus == true
                            ? ResultPositive(name, caseId)
                            : ResultNegative()),
                  );
                },
                child: GestureDetector(
                  onTap: () {
                    if (imageLocation == null) {
                      Alert(
                        context: context,
                        type: AlertType.error,
                        title: "Error !",
                        desc: "Please Capture image",
                        buttons: [
                          DialogButton(
                            child: Text(
                              "Okay",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () => Navigator.pop(context),
                            width: 120,
                          )
                        ],
                      ).show();
                    } else {
                      _checkPatient();
                      if (isLoading == true) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Loading(),
                          ),
                        );
                      }
                    }
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width * 0.85,
                      color: Color.fromRGBO(14, 34, 71, 1),
                      child: Center(
                        child: Text(
                          "Identify",
                          style: GoogleFonts.aBeeZee(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
