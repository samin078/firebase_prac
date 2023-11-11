import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_prac/unused/database.dart';
//import 'package:fluttertoast/fluttertoast.dart';


class ReadData extends StatefulWidget {
  const ReadData({Key? key}) : super(key: key);

  @override
  State<ReadData> createState() => _ReadDataState();
}

class _ReadDataState extends State<ReadData> {

  String firstname="", lastname="", age="", id="";
  TextEditingController userfirstnamecontroller = new TextEditingController();


  searchUser(String name)async {
    QuerySnapshot querySnapshot = await DatabaseMethods().getthisUserInfo(name);

    firstname="${querySnapshot.docs[0]["First Name"]}";
    lastname="${querySnapshot.docs[0]["Last Name"]}";
    age="${querySnapshot.docs[0]["Age"]}";
    id=querySnapshot.docs[0].id;

    setState(() {

    });
  }

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
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              onPressed: () {
                searchUser(userfirstnamecontroller.text);
              },
              child: Text(
                "Search",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              onPressed: () async {
               await DatabaseMethods().UpdateUserData("25", id);
               searchUser(userfirstnamecontroller.text);
              },
              child: Text(
                "Update",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              onPressed: () async {
                await searchUser(userfirstnamecontroller.text);
                await DatabaseMethods().DeleteUserData(id);
              },
              child: Text(
                "Delete",
              ),
            ),
          ),
          Container(
            child: Column(
              children: [
                Text(
                  firstname,
                ),
                Text(
                  lastname,
                ),
                Text(
                  age,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
