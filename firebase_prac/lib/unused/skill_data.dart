import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_prac/unused/skill.dart';


class SkillData {
  List<Skill> categories = [
    Skill(name: "Programming", isChecked: false),
    Skill(name: "Cooking", isChecked: false),
    Skill(name: "Swimming", isChecked: false),
    Skill(name: "Singing", isChecked: false),
    Skill(name: "Calculus", isChecked: false),
  ];


  Future<void> addInitialSkillsToFirestore() async {
    final snapshot = await FirebaseFirestore.instance.collection('skills').get();

    // Check if the "skills" collection is empty to avoid duplicates
    if (snapshot.docs.isEmpty) {
      // If the collection is empty, add the initial skills
      for (var category in categories) {
        await FirebaseFirestore.instance.collection('skills').add(category.toMap());
      }
    }
  }


  //Method to add a new Skill
  Future<void> insertNewSkillToFirestore(Skill skill) async {
    final skillName = skill.name;
    final skillCollection = FirebaseFirestore.instance.collection('skills');

    // Check if a document with the same name already exists
    final query = await skillCollection.where('name', isEqualTo: skillName).get();

    if (query.docs.isEmpty) {
      // Skill doesn't exist, so add it
      await skillCollection.add(skill.toMap());
    } else {
      // Skill already exists, handle the situation accordingly
      // You can throw an error, display a message, or take other action
      print('Skill $skillName already exists in Firestore.');
    }
  }


}

