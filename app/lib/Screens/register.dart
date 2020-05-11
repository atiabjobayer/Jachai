
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../Widgets/BezierContainer.dart';
import '../Animation/FadeAnimation.dart';
import '../Screens/TestScreen.dart';
import '../Screens/Loading.dart';

class CreateAccount extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreateAccountState();
  }
}

class CreateAccountState extends State<CreateAccount> {
  // Controllers and other variables
  final nameController = TextEditingController();
  final mailController = TextEditingController();
  final passwordController = TextEditingController();
  final medicalIdController = TextEditingController();

  bool loading = false;

  // Widget for Top button
  @override
  Widget _topButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Color(0xffe46b10)),
            ),
            Text('Back',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffe46b10)))
          ],
        ),
      ),
    );
  }

  // Widget for entry field
  // This is actually a combination to code less

  Widget _entryField(String title, TextEditingController txController,
      {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Color(0xffe46b10)),
          ),
          SizedBox(
            height: 10,
          ),

          // Maybe convert this into form later
          // It works for now
          TextField(
            obscureText: isPassword,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
            controller: txController,
          )
        ],
      ),
    );
  }

  // Register button
  // some process needs to be changed later
  Widget _submitButton() {
    return FadeAnimation(
      3.4,
      GestureDetector(
        onTap: () async {
          // Have to crate efficient validator later
          String user = nameController.value.text;
          String mail = mailController.value.text;
          String password = passwordController.value.text;
          String medicalId = medicalIdController.value.text;

          int mailValidate = 0;
          int passValidate = 0;

          if (mail.isNotEmpty) {
            mailValidate = 1;
          }

          if (password.length >= 6) {
            passValidate = 1;
          }
          // change the validation later

          if (mailValidate == 0 && passValidate == 0) {
            print("Enter valid info !");
          } else if (mailValidate == 1 && passValidate == 1) {
            print("Validator Works !");

            setState(() {
              loading = true;
            });
            dynamic result ;

            if (result == null) {
              // do something later on
              setState(() {
                loading = false;

                Alert(
                  context: context,
                  type: AlertType.error,
                  title: "Error !!",
                  desc: "User not Found. Check credentials !",
                  buttons: [
                    DialogButton(
                      child: Text(
                        "Okay",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () => Navigator.pop(context),
                      width: 120,
                    )
                  ],
                ).show();
              });
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Test()),
              );
            }

            nameController.clear();
            mailController.clear();
            passwordController.clear();
            medicalIdController.clear();
          }

          // createData();
        },
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 15),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.shade200,
                      offset: Offset(2, 4),
                      blurRadius: 5,
                      spreadRadius: 2)
                ],
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xfffbb448), Color(0xfff7892b)])),
            child: FadeAnimation(
              1.5,
              Text(
                'Register Now',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            )),
      ),
    );
  }

  // widget for the title
  Widget _title() {
    return FadeAnimation(
      1.8,
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: 'যা',
            style: GoogleFonts.portLligatSans(
              textStyle: Theme.of(context).textTheme.display1,
              fontSize: 35,
              fontWeight: FontWeight.w700,
              color: Color(0xffe46b10),
            ),
            children: [
              TextSpan(
                text: 'চা',
                style: TextStyle(color: Colors.white, fontSize: 35),
              ),
              TextSpan(
                text: 'ই',
                style: TextStyle(color: Color(0xffe46b10), fontSize: 35),
              ),
            ]),
      ),
    );
  }

  // Entry fields column
  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        FadeAnimation(
          2.2,
          _entryField("Username", nameController),
        ),
        FadeAnimation(
          2.4,
          _entryField("Medical Id", medicalIdController),
        ),
        FadeAnimation(2.6, _entryField("Email id", mailController)),
        FadeAnimation(
            3.0, _entryField("Password", passwordController, isPassword: true)),
      ],
    );
  }

  // main page
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
          resizeToAvoidBottomPadding: false,

            backgroundColor: Color.fromRGBO(14, 34, 71, 1),
            body: SingleChildScrollView(
                child: Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 4,
                          child: SizedBox(),
                        ),
                        _title(),
                        SizedBox(
                          height: 50,
                        ),
                        _emailPasswordWidget(),
                        SizedBox(
                          height: 20,
                        ),
                        _submitButton(),
                        Expanded(
                          flex: 2,
                          child: SizedBox(),
                        )
                      ],
                    ),
                  ),
                  Positioned(top: 40, left: 0, child: _topButton()),
                  Positioned(
                      top: -MediaQuery.of(context).size.height * .2,
                      right: -MediaQuery.of(context).size.width * .5,
                      child: FadeAnimation(1, BezierContainer()))
                ],
              ),
            )));
  }

  // dont know need this or not
  // just keeping it in case gonna need it
  void createData() async {
    //   DocumentReference ref = await db.collection('USERS').add(
    //     {'name': '${nameController.value.text}',
    //     'mail': '${mailController.value.text}',
    //      'id': '${medicalIdController.value.text}',
    //     'password': '${passwordController.value.text}',
    //     },
    //     );
  }
}