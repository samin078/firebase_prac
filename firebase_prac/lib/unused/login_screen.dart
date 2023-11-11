import 'package:flutter/material.dart';
import 'package:firebase_prac/unused/database.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  uploadData() async {
    Map<String, dynamic> uploaddata= {
      "First Name": userfirstnamecontroller.text,
      "Last Name": userlastnamecontroller.text,
      "Age": useragecontroller.text,
    };

    await DatabaseMethods().addUserDetails(uploaddata);

    Fluttertoast.showToast(
        msg: "Data Uploaded Successfully",
    );

  }



  TextEditingController userfirstnamecontroller = new TextEditingController();
  TextEditingController userlastnamecontroller = new TextEditingController();
  TextEditingController useragecontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
                child: TextField(
                  controller: userfirstnamecontroller,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: "First Name",
                      hintStyle: TextStyle(
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                       // borderRadius: BorderRadius(10.0),
                      ),
                    ),
                ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: TextField(
                controller: userlastnamecontroller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: "Last Name",
                  hintStyle: TextStyle(
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    // borderRadius: BorderRadius(10.0),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: TextField(
                controller: useragecontroller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: "Age",
                  hintStyle: TextStyle(
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    // borderRadius: BorderRadius(10.0),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
                onPressed: () {
                  uploadData();
                },

                child: Text(
                  "Create",
                ),
              ),

          ),
        ],
      ),
    );
  }
}