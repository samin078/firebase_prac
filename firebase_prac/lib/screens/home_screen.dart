//import 'package:firebase_prac/screens/login_screen.dart';
//import 'package:firebase_prac/screens/date_picker.dart';
import 'package:firebase_prac/screens/user_input.dart';
import 'package:firebase_prac/screens/welcome_screen.dart';
//import 'package:firebase_prac/screens/read_data.dart';
//import 'package:firebase_prac/screens/user_input.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {


  
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: WelcomeScreen(),
    );
  }
}
