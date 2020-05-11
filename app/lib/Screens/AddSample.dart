import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:facial_recognition/Screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../data/strings.dart';
import '../helpers.dart';
import 'package:camera/camera.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:shadow/shadow.dart';

class AddSample extends StatefulWidget {
  @override
  _AddSampleState createState() => _AddSampleState();
}

class _AddSampleState extends State<AddSample> {
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

  CameraController controller;
  String imagePath;
  List cameras;
  int cameraId;

  File imageLocation;

  Widget _entryField(String title, TextEditingController txController,
      {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      color: Color.fromRGBO(86, 101, 120, 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.yellowAccent),
          ),
          // Maybe convert this into form later
          // It works for now
          TextField(
            style: new TextStyle(color: Colors.yellowAccent),
            obscureText: isPassword,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color.fromRGBO(86, 101, 120, 1),
                filled: true),
            controller: txController,
          )
        ],
      ),
    );
  }

  final caseIdController = TextEditingController();

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
                            //this container is a replacement for camera

                            child: Container(
                              color: Colors.white,
                              height: MediaQuery.of(context).size.height * 0.45,
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: imageLocation == null
                                  ? _cameraPreviewWidget()
                                  : FittedBox(
                                      fit: BoxFit.fill,
                                      child: Image.file(imageLocation),
                                    ),
                            ),
                          )),
                          GestureDetector(
                            onTap: () {
                              _onCapturePressed(context);
                            },
                            child: Shadow(
                              offset: Offset(0,5),
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.09,
                  ),
                  Text(
                    "Enter Case Id:",
                    style: GoogleFonts.aBeeZee(
                      color: Color.fromRGBO(14, 34, 71, 1),
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: _entryField("", caseIdController),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              GestureDetector(
                onTap: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    child: AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          CircularProgressIndicator(),
                        ],
                      ),
                    ),
                  );
                  final Map<String, dynamic> data = {
                    'caseId': caseIdController.value.text,
                    'image': imageLocation,
                  };

                  final int status = await _addPatient(data);

                  if (status != 201) {
                    Navigator.of(context).pop();
                    _showErrorDialog(context,
                        text: "There was a problem. PLease try again !");
                    return;
                  }
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                  showDialog(
                    context: context,
                    child: AlertDialog(
                      title: Text('Done !'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text('Patient Data Sucessfully added !'),
                        ],
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('Okay'),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          ),
                        )
                      ],
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.85,
                    color: Color.fromRGBO(14, 34, 71, 1),
                    child: Center(
                      child: Text(
                        "Save Data",
                        style: GoogleFonts.aBeeZee(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0),
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

  Future<int> _addPatient(Map<String, dynamic> data) async {
    final Dio myDio = Dio();
    final Response response = await myDio
        .post('${Strings.baseApiUrl}/add_patient', data: jsonEncode(data));
    return response.statusCode;
  }

  void _showErrorDialog(BuildContext context, {@required text}) {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text('Error ! Please try again'),
        content: Text(text),
        actions: <Widget>[
          FlatButton(
            child: Text("Okay"),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }
}
