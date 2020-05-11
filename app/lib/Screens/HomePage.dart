import 'dart:math';

import 'package:facial_recognition/Screens/AddSample.dart';
import 'package:facial_recognition/Screens/Identify.dart';
import 'package:facial_recognition/Widgets/AppbarWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        
              resizeToAvoidBottomPadding: true,
              
       appBar: AppBar(
         centerTitle: true,
         backgroundColor: Color.fromRGBO(14, 34, 71, 0.9),
         title: Text(
           "যাচাই",
           style: TextStyle(
             fontSize: 22.0
           ),
           ),
       ), 

  
        body: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.12,
            ),
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
            SizedBox(
              height: 20.0,
            ),
            Text(
              "A Face recognition app",
              style: GoogleFonts.aBeeZee(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(14, 34, 71, 1),
              ),
            ),
            Text(
              "For identifying",
              style: GoogleFonts.aBeeZee(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(14, 34, 71, 1),
              ),
            ),
            Text(
              "COVID-19 Patients",
              style: GoogleFonts.aBeeZee(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(14, 34, 71, 1),
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            GestureDetector(
              onTap: () {
                print("Add Sample");
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  AddSample()),
                ); 
                
              },
              child: Card(
                elevation: 30.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.8,
                    color: Color.fromRGBO(14, 34, 71, 1),
                    child: Center(
                      child: Text(
                        "Add Sample",
                        style: GoogleFonts.aBeeZee(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

                        SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),

                        GestureDetector(
              onTap: () {
                print("Identify Patient");
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  Identify()),
                ); 

              },
              child: Card(
                elevation: 30.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.8,
                    color: Color.fromRGBO(14, 34, 71, 1),
                    child: Center(
                      child: Text(
                        "Identify Patient",
                        style: GoogleFonts.aBeeZee(
                          fontSize: 30,
                          color: Colors.white,
                        ),
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
