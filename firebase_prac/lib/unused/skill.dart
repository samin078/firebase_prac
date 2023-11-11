import 'package:cloud_firestore/cloud_firestore.dart';

class Skill {
  String name;
  bool isChecked;

  Skill({
    required this.name,
    this.isChecked = false,
  });

  // Convert Skill object to a Map for Firebase storage
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'isChecked': isChecked,
    };
  }

  // Create a Skill object from a Firebase snapshot
  Skill.fromSnapshot(snapshot)
      : name = snapshot.data()['name'],
        isChecked = snapshot.data()['isChecked'];

  Future<void> addSkill(Map<String, bool> toMap) async {
    await FirebaseFirestore.instance.collection("skills").doc().set(toMap);
  }

  List<Skill> categories = [
    Skill(name: "Programming", isChecked: false),
    Skill(name: "Cooking", isChecked: false),
    Skill(name: "Swimming", isChecked: false),
    Skill(name: "Singing", isChecked: false),
    Skill(name: "Calculus", isChecked: false),
  ];

  Future<void> addCategoriesToFirestore() async {
    for (var category in categories) {
      await FirebaseFirestore.instance.collection('skills').add(category.toMap());
    }
  }



}
