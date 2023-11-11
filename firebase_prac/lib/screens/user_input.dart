import 'package:firebase_prac/screens/skill_screen.dart';
import 'package:firebase_prac/screens/skilled_in.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_prac/main.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'database.dart';



DateTime _currentdatetime = DateTime.now();
DateTime _selecteddatetime = DateTime.now();

class UserInputForm extends StatefulWidget {

  static String id = 'user_input_screen';

  @override
  _UserInputFormState createState() => _UserInputFormState();
}

class _UserInputFormState extends State<UserInputForm> {

  int age = 0;
  String DoB = "";

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController socialController = TextEditingController();


  String gender = 'Male';


  uploadData() async {
    Map<String, dynamic> uploaddata= {
      "Name": nameController.text,
      "Age": age.toString(),
      "DoB": _selecteddatetime.microsecondsSinceEpoch,
      "Email": loggedInUser.email.toString(),
      "Number": numberController.text,
      "Gender": "$gender",
    };


    userInfo.name = nameController.text;
    userInfo.email = loggedInUser.email.toString();
    userInfo.age = age.toString();
    userInfo.number = numberController.text;
    userInfo.gender = "$gender";
    userInfo.dob = DoB.toString();

    print(DoB);

   // await SkillData().addInitialSkillsToFirestore();

    await DatabaseMethods().addUserDetails(uploaddata);

    Fluttertoast.showToast(
      msg: "Data Uploaded Successfully",
    );

  }

  @override
  void initState() {
    DatabaseMethods().getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Input '),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            // TextField(
            //   controller: ageController,
            //   decoration: InputDecoration(labelText: 'Age'),
            //   keyboardType: TextInputType.number,
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                age.toString(),
                style: TextStyle(
                  fontSize: 20.0,

                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: MaterialButton(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1920),
                        lastDate: DateTime(2025),
                      ).then( (value) {
                        setState(() {
                          _selecteddatetime = value!;
                          age = (_currentdatetime.difference(_selecteddatetime).inDays ~/ 365);
                          print(age);
                         DoB = _selecteddatetime.toString();
                        });
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Choose Date of Birth',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                        ),
                      ),
                    ),
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
            InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                // Handle the phone number input here
                numberController.text = number.phoneNumber.toString();
                //phone = number.toString();
              },

              maxLength: 11,
              inputDecoration: InputDecoration(
                labelText: "Phone Number",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              ),
              selectorConfig: SelectorConfig(
                selectorType: PhoneInputSelectorType.DIALOG,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text("Gender : ",
                  style: TextStyle(
                    fontSize: 15,
                  ),),
                DropdownButton<String>(
                  value: gender,
                  onChanged: (newValue) {
                    setState(() {
                      gender = newValue!;
                    });
                  },
                  items: <String>['Male', 'Female', 'Other']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),

            ElevatedButton(
              onPressed: () {
                uploadData();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SkilledInScreen(),
                  ),
                );

                // Handle the user input here
                String name = nameController.text;
                //int age = int.tryParse(ageController.text) ?? 0;
                //int age = _selecteddatetime.difference(_currentdatetime) as int;
                age = 0;
                print(age);
                String email = loggedInUser.email.toString();
                String phone = numberController.text;

                // print('Name: $name');
                // print('Age: $age');
                // print('Email: $email');
                // print('Phone: $phone');
                // print('Gender: $gender');
                print('name: ' + userInfo.name);
                print('Age: ' +  userInfo.age);
                print('Email:  ' + userInfo.email);
                print('Phone:  ' + userInfo.number);
                print('Gender:  ' + userInfo.gender);
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}