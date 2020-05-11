import 'dart:math';

import 'package:facial_recognition/Screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:rflutter_alert/rflutter_alert.dart";
import 'package:shared_preferences/shared_preferences.dart';

import '../Animation/FadeAnimation.dart';
import '../Screens/Loading.dart';
import '../Screens/register.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  bool checker = true;

  @override
  Widget build(BuildContext context) {
    bool boolTrue = true;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: null,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // top blank area
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),

            // page title

            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 1,
              child: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.14,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "যাচাই",
                        style: TextStyle(
                          height: sqrt1_2,
                          fontFamily: "AmarBangla",
                          fontSize: 80.0,
                          color: Color.fromRGBO(14, 34, 71, 1),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // row for sing in and sign up
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            Row(
              children: <Widget>[
                // sign in text
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.17,
                ),

                // column to give underkline effect

                Column(
                  children: <Widget>[
                    Text(
                      "Sign in",
                      style: TextStyle(
                        color: Color.fromRGBO(14, 34, 71, 1),
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    Container(
                      height: 4.0,
                      width: 80.0,
                      color: Color.fromRGBO(14, 34, 71, 1),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                ),

                // sign up button
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateAccount()),
                    );
                  },
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      color: Color.fromRGBO(14, 34, 71, 1),
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            // login feild
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),

              // container for user name
              child: Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.85,
                color: Color.fromRGBO(223, 223, 223, 1),
                child: TextFormField(
                  cursorColor: Colors.black,
                  decoration: new InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      hintText: "Enter user email"),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                // container for password
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.85,
                color: Color.fromRGBO(223, 223, 223, 1),
                child: TextFormField(
                  cursorColor: Colors.black,
                  decoration: new InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      hintText: "Enter password"),
                ),
              ),
            ),

            // row for check box and text
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      checker = false;
                    });
                  },
                  child: Checkbox(
                    value: checker,
                    onChanged: null,
                  ),
                ),
                Text(
                  "Remember me",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            // login button
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            GestureDetector(
              onTap: () {
                // TODO: Implement user auth later

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.85,
                  color: Color.fromRGBO(14, 34, 71, 1),
                  child: Center(
                    child: Text(
                      "Login",
                      style: GoogleFonts.aBeeZee(
                        fontSize: 30.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
