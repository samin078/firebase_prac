import 'package:firebase_prac/unused/skills_screen.dart';
import 'package:flutter/material.dart';





DateTime _datetime = DateTime.now();

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key}) : super(key: key);



  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //display the date
            Text(
              _datetime.toString(),
              style: TextStyle(
                fontSize: 30.0,
              ),
            ),
            MaterialButton(
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1920),
                  lastDate: DateTime(2025),
                ).then( (value) {
                  setState(() {
                    _datetime = value!;
                  });
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Skills(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Choose Date',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
                ),
              ),
              color: Colors.blueGrey,
            ),
          ],
        ),
      ),
    );
  }
}
