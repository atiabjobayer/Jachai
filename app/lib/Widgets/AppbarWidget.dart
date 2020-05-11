import 'package:facial_recognition/Screens/AddSample.dart';
import 'package:flutter/material.dart';

class AppbarWidget extends AppBar {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

      resizeToAvoidBottomPadding: true,

              
       appBar: AppBar(
         backgroundColor: Color.fromRGBO(14, 34, 71, 0.9),
         title: Text(
           "যাচাই",
           style: TextStyle(
             fontSize: 22.0
           ),
           ),
       ), 

             // side menu
      drawer: Drawer(
        child: Container(
         color: Color.fromRGBO(14, 34, 71, 0.9), 
         child: Column(
          children: <Widget>[

            SizedBox(height: 30),

           Container(
              width: double.infinity,
              color: Color(0xffe46b10),
              child: RaisedButton(onPressed: (){
              },
              color: Color(0xffe46b10),
              child: Text("যাচাই", style: TextStyle(color: Colors.white, fontSize: 20.0),),
              ),
            ),
            SizedBox(height: 15.0),

            Row(
              children: <Widget>[

                SizedBox(width: 10.0,),

                Icon(Icons.face, color: Colors.white, size: 40.0,),

                SizedBox(width: 20.0,),

                GestureDetector(
                  onTap: (){

                  },

                  child: GestureDetector(

                    onTap: (){

                       Navigator.push(
                        context,
                        new MaterialPageRoute(builder: (context) =>  AddSample())
                      ); 
                    },
                    child: Text("Add Sample", style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),),
                  ),

                ),
              ],
            ),


            SizedBox(height: 15.0),

            Row(
              children: <Widget>[

                SizedBox(width: 10.0,),

                Icon(Icons.perm_identity, color: Colors.white, size: 45.0,),

                SizedBox(width: 20.0,),

                GestureDetector(
                  onTap: (){

                  },

                  child: GestureDetector(

                    onTap: (){

                       Navigator.push(
                        context,
                        new MaterialPageRoute(builder: (context) =>  AddSample())
                      ); 
                    },
                    child: Text("Identify Patient", style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),),
                  ),

                ),
              ],
            ),
          ], 
         ),
        ),
      ),        

      ),
    );
  }
}