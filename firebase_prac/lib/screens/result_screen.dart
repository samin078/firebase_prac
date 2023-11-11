import 'package:firebase_prac/main.dart';
import 'package:firebase_prac/screens/database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'basic_screen.dart';

var userId = DatabaseMethods.userId;

class ResultScreen extends StatefulWidget {
  static String id = 'result_screen';



  const ResultScreen({Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {

  String location = "User's location";
  List<Map> selectedCategories = [];

  Future<void> fetchSelectedCategories(String userId) async {
    try {
      final categoriesCollection = FirebaseFirestore.instance
          .collection("user_info")
          .doc(userId)
          .collection("categories");

      final QuerySnapshot categoriesSnapshot = await categoriesCollection.get();

      selectedCategories = categoriesSnapshot.docs
          .map((doc) => {
                "name": doc.get("name"),
                "isChecked": doc.get("isChecked"),
              })
          .toList();

      setState(() {
        // Trigger a rebuild of the UI with the fetched data
      });
    } catch (e) {
      print('Error fetching selected categories: $e');
    }
  }

  // Define a function to fetch user data
  Future<void> fetchUserData() async {
    try {
      final DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('user_info')
          .doc(userId)
          .get();

      // Assuming your Firestore document fields match the fields in the userInfo object
      userInfo.name = userSnapshot.get("Name");
      userInfo.age = userSnapshot.get("Age");
      userInfo.dob = userSnapshot.get("DoB");
      userInfo.email = userSnapshot.get("Email");
      userInfo.number = userSnapshot.get("Number");
      userInfo.gender = userSnapshot.get("Gender");
      print(DateTime.fromMicrosecondsSinceEpoch(userInfo.dob, isUtc:true));
      setState(() {
        // Trigger a rebuild of the UI with the fetched data
      });
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  void initState() {
    // Call the function to fetch user data when the screen is loaded
    DatabaseMethods().getUId();
    // Fetch the user's location when the screen is loaded
    DatabaseMethods().getUserLocation(userId!).then((value) {
      if (value != null) {
        final latitude = value.latitude;
        final longitude = value.longitude;
        setState(() {
          location = 'Latitude: $latitude, Longitude: $longitude';
        });
      } else {
        setState(() {
          location = 'User location not available';
        });
      }
    }).catchError((error) {
      // Handle errors that may occur during the asynchronous operation
      print("Error getting user location: $error");
    });

    fetchUserData();
    fetchSelectedCategories(userId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: DatabaseMethods().getUserData(userId!),
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(),
          );
        }

        if (userSnapshot.hasError) {
          return Text('Error: ${userSnapshot.error}');
        }

        final userData = userSnapshot.data;

        return FutureBuilder<List<Map<String, dynamic>>?>(
          future: DatabaseMethods().getSelectedCategories(userId!),
          builder: (context, categoriesSnapshot) {
            if (categoriesSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(),
              );
            }

            if (categoriesSnapshot.hasError) {
              return Text('Error: ${categoriesSnapshot.error}');
            }

            final selectedCategories = categoriesSnapshot.data ?? [];

            return Scaffold(
              appBar: AppBar(
                title: Text('User Result'),
              ),
              body: SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name: ${userData!['Name']}",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "Age: ${userData['Age']}",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "Email: ${userData['Email']}",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "Phone: ${userData['Number']}",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "Gender: ${userData['Gender']}",
                      style: TextStyle(fontSize: 18),
                    ),
                    Divider(),
                    Text(
                      "Selected Categories:",
                      style: TextStyle(fontSize: 18),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: selectedCategories.length,
                      itemBuilder: (context, index) {
                        final category = selectedCategories[index];
                        return ListTile(
                          title: Text(category['name']),
                          subtitle: Text(
                            category['isChecked'] ? 'Selected' : 'Not Selected',
                          ),
                        );
                      },
                    ),
                    Divider(),
                    Text(
                      location,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Divider(),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, BasicScreen.id);
                      },
                      child: Text('View Nearby Users'),
                    ),

                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
