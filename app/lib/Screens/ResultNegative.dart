import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultNegative extends StatefulWidget {

  @override
  _ResultNegativeState createState() => _ResultNegativeState();
}

class _ResultNegativeState extends State<ResultNegative> {
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
                            color: Colors.green[600],
                            child: Center(
                              child: Text(
                                "Negative",
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
                        Image(
                          image: AssetImage("assets/emoji.png"),
                          height: 200,
                          width: 200,
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
