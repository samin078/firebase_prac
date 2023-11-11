
//import 'package:firebase_prac/screens/skill_data.dart';
import 'package:firebase_prac/location/userLocation.dart';
import 'package:firebase_prac/pages/map_page.dart';
import 'package:firebase_prac/screens/basic_screen.dart';
import 'package:firebase_prac/screens/date_picker.dart';
import 'package:firebase_prac/screens/login_screen.dart';
import 'package:firebase_prac/screens/registration_screen.dart';
import 'package:firebase_prac/screens/result_screen.dart';
import 'package:firebase_prac/screens/skill_list.dart';
import 'package:firebase_prac/screens/skill_screen.dart';
import 'package:firebase_prac/screens/skilled_in.dart';
import 'package:firebase_prac/screens/unskilled_in.dart';
import 'package:firebase_prac/screens/welcome_screen.dart';
import 'package:firebase_prac/unused/skills_screen.dart';
import 'package:firebase_prac/screens/user_info.dart';
import 'package:firebase_prac/screens/user_input.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/home_screen.dart';


UserInfo userInfo= UserInfo();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 // await SkillData().addInitialSkillsToFirestore();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //   routes: {
        //     '/': (context) => HomeScreen(),
        //     '/userInput': (context) => UserInputForm(),
        //     '/skillScreen': (context) => Skills(),
        //     '/datePicker' : (context) => DatePicker(),
        //   },
        // initialRoute: '/',
     // home: HomeScreen(),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        BasicScreen.id: (context) => BasicScreen(),
        UserInputForm.id :(context) => UserInputForm(),
        SkillScreen.id: (context) => SkillScreen(),
        ResultScreen.id: (context) => ResultScreen(),
        Location.id: (context) => Location(),
        MapPage.id: (context) => MapPage(),
        SkilledInScreen.id: (context) => SkilledInScreen(),
        UnskilledInScreen.id: (context) => UnskilledInScreen(),
      },
    );
  }
}
