import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultPositive extends StatefulWidget {
  final String name;
  final String caseId;

  ResultPositive(this.name, this.caseId);

  @override
  _ResultPositiveState createState() => _ResultPositiveState();
}

class _ResultPositiveState extends State<ResultPositive> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(16, 36, 73, .9),
          title: Center(
            child: Text(
              "Results",
              style: TextStyle(color: Colors.white, fontSize: 22.0),
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height * 1,
          width: MediaQuery.of(context).size.width * 1,
          color: Color.fromRGBO(14, 34, 71, 1),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Card(
                  elevation: 40.0,
                  color: Color.fromRGBO(225, 225, 225, 1),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                        ),
                        Text(
                          "COVID-19",
                          style: GoogleFonts.robotoMono(
                              color: Color.fromRGBO(14, 34, 71, 1),
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold),
                        ),

                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.035,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.09,
                            width: MediaQuery.of(context).size.width * 0.6,
                            color: Color.fromRGBO(237, 39, 89, 1),
                            child: Center(
                              child: Text(
                                "POSITIVE",
                                style: GoogleFonts.lexendGiga(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),

                        // row for case id
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.09,
                            ),
                            Text(
                              "Case Id :",
                              style: GoogleFonts.robotoMono(
                                  color: Color.fromRGBO(14, 34, 71, 1),
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "${widget.caseId}",
                                  style: GoogleFonts.robotoMono(
                                      color: Color.fromRGBO(237, 39, 89, 1),
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),

                        // row for name
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.09,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.31,
                              height:
                                  MediaQuery.of(context).size.height * 0.045,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "Name    :",
                                  style: GoogleFonts.robotoMono(
                                      color: Color.fromRGBO(14, 34, 71, 1),
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "${widget.name}",
                                  style: GoogleFonts.robotoMono(
                                      color: Color.fromRGBO(237, 39, 89, 1),
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.09,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.31,
                              height:
                                  MediaQuery.of(context).size.height * 0.045,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "Location :",
                                  style: GoogleFonts.robotoMono(
                                      color: Color.fromRGBO(14, 34, 71, 1),
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "set it later",
                                  style: GoogleFonts.robotoMono(
                                      color: Color.fromRGBO(237, 39, 89, 1),
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Center(
                      child: Text(
                        "Done !",
                        style: GoogleFonts.roboto(
                            color: Colors.green[900],
                            fontSize: 27.0,
                            fontWeight: FontWeight.bold),
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
