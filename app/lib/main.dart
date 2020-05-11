import 'package:facial_recognition/Screens/AddSample.dart';
import 'package:facial_recognition/Screens/HomePage.dart';
import 'package:facial_recognition/Screens/Loading.dart';
import 'package:facial_recognition/Screens/login.dart';
import 'package:facial_recognition/Screens/register.dart';
import 'package:flutter/material.dart';



main()
{
  runApp(FacialRecognition());
}

class FacialRecognition extends StatefulWidget {
  @override
  _FacialRecognitionState createState() => _FacialRecognitionState();
}

class _FacialRecognitionState extends State<FacialRecognition> {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
      
       body: LoginPage(),
      ),
    );
  }
}