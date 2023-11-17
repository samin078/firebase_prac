import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_geohash/dart_geohash.dart';
import 'package:firebase_prac/components/reusable_card.dart';
import 'package:firebase_prac/screens/user_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_prac/screens/database.dart';
import 'package:geolocator/geolocator.dart';

import '../location/location.dart';

var userId = DatabaseMethods.userId;

class BasicScreen extends StatefulWidget {
  static String id = 'basic_screen';

  const BasicScreen({Key? key}) : super(key: key);

  @override
  _BasicScreenState createState() => _BasicScreenState();
}

class _BasicScreenState extends State<BasicScreen> {
  List<String> currentUserSkilledCategories = [];
  Map<String, dynamic> nearbyUsers = {};
  GeoHasher geoHasher = GeoHasher();

  double currentUserLatitude = 0.0;
  double currentUserLongitude = 0.0;

  @override
  void initState() {
    // Fetch the list of nearby users here
    fetchUserLocation(userId!);
    // fetchAllUserLocation(currentUserLatitude, currentUserLongitude, userId!);
    fetchNearbyUsers(10000.0);
    // fetchAndDisplayAllUsers();
    super.initState();
  }

  // List<String> nearbyUsers = [];

  // Add a method to fetch and display all users
  Future<void> fetchAndDisplayAllUsers() async {
    DatabaseMethods databaseMethods = DatabaseMethods();
    List<DocumentSnapshot> userDocuments =
        await databaseMethods.fetchAllUsers();

    // Extract and display user data
    Map<String, dynamic> usersMap = {};

    for (DocumentSnapshot doc in userDocuments) {
      final userId = doc.id;
      final userData = doc.data();
      usersMap[userId] = userData;
    }

    setState(() {
      nearbyUsers = usersMap;
    });
  }

  Future<void> fetchUserLocation(String userId) async {
    try {
      GeoPoint? userLocation = await DatabaseMethods().getUserLocation(userId);

      if (userLocation != null) {
        double currentUserLatitude = userLocation.latitude!;
        double currentUserLongitude = userLocation.longitude!;

        // Now you have the user's latitude and longitude as double values
        print(
            "Latitude: $currentUserLatitude, Longitude: $currentUserLongitude");
      } else {
        print("User location is null");
        // Handle the case when userLocation is null, if needed
      }
    } catch (e) {
      // Handle any errors that may occur during location retrieval
      print("Error getting location: $e");
    }
  }

  Future<List<String>?> getUserSkilledCategories(String userId) async {
    List<String>? userCategories; // Update the type to List<String>?

    try {
      final userRef =
          FirebaseFirestore.instance.collection("user_info").doc(userId);
      final categoriesCollection = userRef.collection("skilled_in");
      final QuerySnapshot querySnapshot = await categoriesCollection.get();

      // Extract selected categories of the user
      userCategories = querySnapshot.docs
          .where((doc) => doc.get("isChecked") == true)
          .map((doc) => doc.get("name") as String) // Ensure the type is String
          .toList();
    } catch (e) {
      print('Error fetching user selected categories: $e');
    }

    return userCategories;
  }

  Future<List<String>?> getUserUnskilledCategories(String userId) async {
    List<String>? userCategories; // Update the type to List<String>?

    try {
      final userRef =
          FirebaseFirestore.instance.collection("user_info").doc(userId);
      final categoriesCollection = userRef.collection("unskilled_in");
      final QuerySnapshot querySnapshot = await categoriesCollection.get();

      // Extract selected categories of the user
      userCategories = querySnapshot.docs
          .where((doc) => doc.get("isChecked") == true)
          .map((doc) => doc.get("name") as String) // Ensure the type is String
          .toList();
    } catch (e) {
      print('Error fetching user selected categories: $e');
    }

    return userCategories;
  }

  Map<String, List<String>> nearbyUserUnskilledCategories = {};
  Map<String, List<String>> nearbyUsersTeachCategories = {};
  Map<String, List<String>> nearbyUserSkilledCategories = {};
  Map<String, List<String>> nearbyUsersLearnCategories = {};

  void _navigateToUserDetailScreen(String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserDetailedScreen(userId: userId),
      ),
    );
  }

  Future<void> fetchNearbyUsers(double searchRadius) async {
    // Create a Firestore collection reference to your users
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection("user_info");

    final cLocation = await DatabaseMethods().getUserLocation(userId!);
    currentUserLatitude = cLocation!.latitude;
    currentUserLongitude = cLocation.longitude;

    Map<String, GeoPoint> nearbyUsersMap = {};

    List<String>? currentSkilledCategories =
        await getUserSkilledCategories(userId!);
    List<String>? currentUnskilledCategories =
        await getUserUnskilledCategories(userId!);

    // Query all users without any location constraints
    QuerySnapshot querySnapshot = await usersCollection.get();
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      final nuserId = doc.id;
      final location = await DatabaseMethods().getUserLocation(nuserId);

      if (location != null && userId != nuserId) {
        double userLatitude = location.latitude;
        double userLongitude = location.longitude;
        print(currentUserLatitude);
        print(currentUserLongitude);
        print(userLatitude);
        print(userLongitude);

        // Calculate the distance between the current user and the found user
        double distance = Geolocator.distanceBetween(currentUserLatitude,
            currentUserLongitude, userLatitude, userLongitude);
        print(distance);

        // If the distance is within the specified radius, add the user to the map
        if (distance <= searchRadius ) {
          // Call the method to get the selected categories of the nearby user
          List<String>? nearbyUnskilledCategories =
              await getUserUnskilledCategories(nuserId);

          List<String> commonTeachCategories = [];
          if (currentSkilledCategories != null &&
              nearbyUnskilledCategories != null) {
            commonTeachCategories = currentSkilledCategories
                .toSet()
                .intersection(nearbyUnskilledCategories.toSet())
                .toList();
            print(commonTeachCategories);

            if(commonTeachCategories.isEmpty){
              nearbyUserUnskilledCategories.remove(nuserId);
              commonTeachCategories.remove(nuserId);
            }


          }

          List<String>? nearbySkilledCategories =
              await getUserSkilledCategories(nuserId);

          List<String> commonLearnCategories = [];
          if (currentUnskilledCategories != null &&
              nearbySkilledCategories != null) {
            commonLearnCategories = currentUnskilledCategories
                .toSet()
                .intersection(nearbySkilledCategories.toSet())
                .toList();
            print(commonLearnCategories);
          }
          print(nuserId);

          // Update the UI with nearby user data
          setState(() {
            nearbyUserUnskilledCategories[nuserId] =
                nearbyUnskilledCategories ?? [];
            nearbyUsersTeachCategories[nuserId] = commonTeachCategories;
            nearbyUserSkilledCategories[nuserId] =
                nearbySkilledCategories ?? [];
            nearbyUsersLearnCategories[nuserId] = commonLearnCategories;
          });
        }
      }
    }

    // Update the UI with nearby user data
    setState(() {
      nearbyUsers = nearbyUsersMap;
      print(nearbyUsers);
    });
  }

  Future<void> fetchAllUserLocation(double currentUserLatitude,
      double currentUserLongitude, String userId) async {
    DatabaseMethods databaseMethods = DatabaseMethods();
    List<DocumentSnapshot> userDocuments =
        await databaseMethods.fetchAllUsers();

    // Extract and display user location data
    Map<String, GeoPoint> userLocations = {};

    for (DocumentSnapshot doc in userDocuments) {
      final userId = doc.id;
      GeoPoint? location = await databaseMethods.getUserLocation(userId);

      if (location != null) {
        userLocations[userId] = location;
      }
    }

    setState(() {
      nearbyUsers = userLocations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearby Users'),
        centerTitle: true,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: nearbyUserUnskilledCategories.length,
          itemBuilder: (context, index) {
            final userId = nearbyUserUnskilledCategories.keys.elementAt(index);
            //final userId = nearbyUsers[index];
            final usersUnskilledCategories =
                nearbyUserUnskilledCategories[userId];
            final commonTeachCategories = nearbyUsersTeachCategories[userId];
            final usersSkilledCategories = nearbyUserSkilledCategories[userId];
            final commonLearnCategories = nearbyUsersLearnCategories[userId];

            return InkWell(
              onTap: () {
                _navigateToUserDetailScreen(userId);
              },
              child: Container(
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.blueGrey[100],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
                  child: ListTile(
                    minLeadingWidth: 2.0,
                    trailing: Icon(
                      Icons.ac_unit,
                      size: 20.0,
                    ),
                    // leading: Container(
                    //   height: double.infinity,
                    //   // alignment: Alignment.centerLeft,
                    //   child: Icon(
                    //     Icons.ac_unit,
                    //     size: 40.0,
                    //   ),
                    // ),
                    title: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.abc,
                            size: 35.0,
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            'UserName',
                            style: TextStyle(
                              fontSize: 22.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // subtitle: Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Text(
                    //         'Interested Categories: ${usersUnskilledCategories?.join(', ') ?? ''}'),
                    //     Text(
                    //         'Matched Categories: ${commonTeachCategories?.join(', ') ?? ''}'),
                    //     Text(
                    //         'Skilled Categories: ${usersSkilledCategories?.join(', ') ?? ''}'),
                    //     Text(
                    //         'Matched Categories: ${commonLearnCategories?.join(', ') ?? ''}'),
                    //   ],
                    // ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Text(
                                'Skilled In',
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              Text(
                                '${usersSkilledCategories?.join('\n') ?? ''}',
                              ),
                              Text(
                                'Matched',
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              Text(
                                '${commonLearnCategories?.join('\n') ?? ''}',
                              ),
                            ],
                          ),
                        ),
                        VerticalDivider(
                          color: Colors.black45,
                          thickness: 2,
                        ),
                        Container(
                          child: Column(
                            children: [
                              Text(
                                'Interested In',
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              Text(
                                '${usersUnskilledCategories?.join('\n') ?? ''}',
                              ),
                              Text(
                                'Matched',
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              Text(
                                '${commonTeachCategories?.join('\n') ?? ''}',
                              ),
                            ],
                          )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
