import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_prac/screens/database.dart';
//import 'package:firebase_prac/screens/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../location/userLocation.dart';

var userId = DatabaseMethods.userId;

class SkillScreen extends StatefulWidget {
  static String id = 'skill_screen';

  const SkillScreen({Key? key}) : super(key: key);

  @override
  State<SkillScreen> createState() => _SkillScreenState();
}

class _SkillScreenState extends State<SkillScreen> {
  List<Map> categories = [
    {"name": "Math", "isChecked": false},
    {"name": "Physics", "isChecked": false},
    {"name": "Algorithms", "isChecked": false},
    {"name": "Football", "isChecked": false},
    {"name": "Cooking", "isChecked": false},
    {"name": "Sewing", "isChecked": false},
    {"name": "Baking", "isChecked": false},
    {"name": "Painting ", "isChecked": false},
    {"name": "Data Science", "isChecked": false},
    {"name": "Economics", "isChecked": false},
    {"name": "Machine Learning", "isChecked": false},
    {"name": "Photography", "isChecked": false},
    {"name": "Photo Editing ", "isChecked": false},
    {"name": "Video Editing ", "isChecked": false},
    {"name": "Web Development", "isChecked": false},
    {"name": "App Development", "isChecked": false},
    {"name": "System Analysis", "isChecked": false},
    {"name": "Database Management", "isChecked": false},
    {"name": "Search Engine Optimization", "isChecked": false},
    {"name": "Digital Marketing", "isChecked": false},
    {"name": "3D modeling", "isChecked": false},
    {"name": "Graphics Design", "isChecked": false},
    {"name": "Foreign Language", "isChecked": false},
    {"name": "Microsoft Office Skills", "isChecked": false},
    {"name": "Game Development", "isChecked": false},
    {"name": "Gaming ", "isChecked": false},
    {"name": "Engineering Design", "isChecked": false},
    {"name": "Thermodynamics", "isChecked": false},
    {"name": "Fluid Mechanics", "isChecked": false},
    {"name": "Heat and Mass", "isChecked": false},
    {"name": "IOT", "isChecked": false},
    {"name": "Artificial Intelligence", "isChecked": false},
  ];

  List<Map> selectedCategories = [];

  @override
  void initState() {
    DatabaseMethods().getUId();
    super.initState();
    // Call the function to add categories to Firestore when the screen is loaded
    //addCategoriesToFirestore(categories);
  }

// Define a reference to the Firestore collection
  final CollectionReference categoriesCollection =
      FirebaseFirestore.instance.collection('categories');

// Function to add categories to Firestore
  Future<void> addCategoriesToFirestore(List<Map> Categories) async {
    try {
      for (var category in Categories) {
        await categoriesCollection.add({
          'name': category['name'],
          'isChecked': false,
        });
      }
      print('Categories added to Firestore');
    } catch (e) {
      print('Error adding selected categories: $e');
    }
  }

// Function to check if selected skills are already in database or not
  Future<bool> skillExistsInDatabase(String skillName) async {
    try {
      final userRef =
      FirebaseFirestore.instance.collection("user_info").doc(userId);
      final categoriesCollection = userRef.collection("categories");
      final QuerySnapshot querySnapshot = await categoriesCollection
          .where("name", isEqualTo: skillName)
          .get();

      // If any documents with the same name exist, the skill already exists
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking if skill exists: $e');
      return false;
    }
  }

  // Function to add selected categories to Firestore as a subcollection
  Future<void> addSelectedCategoriesToFirestore(
      List<Map> categories, String userId) async {
    try {
      final userRef =
          FirebaseFirestore.instance.collection("user_info").doc(userId);
      final categoriesCollection = userRef.collection("categories");

      for (var category in categories) {
        await categoriesCollection.add({
          'name': category['name'],
          'isChecked': category['isChecked'],
        });
      }
      Fluttertoast.showToast(msg: 'Skills added');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error adding skills: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    //addCategoriesToFirestore(categories);
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: const [
            Text('Checkboxes'),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Please Choose the ones you are skilled in:",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              Column(
                  children: categories.map((favorite) {
                return CheckboxListTile(
                    activeColor: Colors.deepPurpleAccent,
                    checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    value: favorite["isChecked"],
                    title: Text(favorite["name"]),
                    onChanged: (val) {
                      setState(() {
                        favorite["isChecked"] = val;
                      });
                    });
              }).toList()),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              Wrap(
                children: categories.map((favorite) {
                  if (favorite["isChecked"] == true) {
                    return Card(
                      elevation: 3,
                      color: Colors.deepPurpleAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              favorite["name"],
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  favorite["isChecked"] =
                                      !favorite["isChecked"];
                                });
                              },
                              child: const Icon(
                                Icons.delete_forever_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Container();
                }).toList(),
              ),
              Divider(
                color: Colors.grey,
              ),
              ElevatedButton(
                onPressed: () async {
                  selectedCategories.clear();
                  for (var category in categories) {
                    if (category["isChecked"]) {
                      final skillName = category["name"];
                      print(skillName.toString());
                      final skillExists = await skillExistsInDatabase(skillName);
                      print(skillExists.toString());
                      final skillExistsInSelectedCategories = selectedCategories.any(
                            (selectedCategory) => selectedCategory["name"] == skillName,
                      );

                      if (!skillExists && !skillExistsInSelectedCategories) {
                        selectedCategories.add(category);
                      }
                    }
                  }

                  //showToast("Skills Added", 2);
                  print('Selected Categories: $selectedCategories');
                  // Pass the user's ID (userId) obtained from the constructor
                  addSelectedCategoriesToFirestore(
                      selectedCategories, userId.toString());
                  Navigator.pushNamed(context, Location.id);
                },
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
