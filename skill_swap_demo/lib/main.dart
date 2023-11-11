import 'package:flutter/material.dart';
import 'package:skill_swap_demo/screens/home.dart';
import 'package:skill_swap_demo/screens/location.dart';
import 'package:skill_swap_demo/screens/main.dart';
import 'package:skill_swap_demo/screens/user_profile_1.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: 'main',
    routes: {
      'profile1': (context) => UserProfile1(),
      'home': (context) => Home(),
      'main': (context) => Main(),
      'loc': (context) => Location(),
    },
  ),
  );
}


