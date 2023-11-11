import 'package:bmi_calculator/screens/results_page.dart';
import 'package:flutter/material.dart';
import 'screens/input_page.dart';



void main() => runApp(BMICalculator());

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(
      //   scaffoldBackgroundColor: Color(0xFF0A0E21),
      //   colorScheme: ColorScheme.fromSwatch().copyWith(
      //     secondary: Colors.red,      // Your accent color
      //     primary: Color(0xFF0A0E21),
      //   ),
      //   textTheme: TextTheme(
      //      // bodyLarge: TextStyle(color: Colors.white),
      //     bodyMedium: TextStyle(color: Colors.white),
      //    // bodySmall: TextStyle(color: Colors.white),
      //   ),
      // ),
      theme: ThemeData.dark().copyWith(
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: Color(0xFF0A0E21),
        secondary: Color(0xFFB7B3DB),
      ),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => InputPage(),
        '/results': (context) => Results(),
      },
    );
  }
}

