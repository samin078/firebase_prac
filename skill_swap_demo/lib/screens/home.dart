import 'package:flutter/material.dart';


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.indigo[200],
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 60.0,
                backgroundImage: AssetImage('images/gojo.png'),
              ),
              Text(
                'Samin Saiara',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              // Text(
              //   'FLUTTER DEVELOPER',
              //   style: TextStyle(
              //     fontFamily: 'Source Sans 3',
              //     fontWeight: FontWeight.bold,
              //     fontSize: 20.0,
              //     color: Colors.teal[100],
              //     letterSpacing: 2.5,
              //   ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow[400],
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow[400],
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow[400],
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow[400],
                    ),
                    Icon(
                      Icons.star_border_outlined,
                      color: Colors.yellow[400],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
                width: 150.0,
                child: Divider(
                  color: Colors.teal[100],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Card(
                    margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                          child: Column(
                            children: [
                              Text(
                                'Expert:',
                                style: TextStyle(
                                  fontFamily: 'Source Sans 3',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.0,
                                  color: Colors.teal[900],
                                  letterSpacing: 2.0,
                                ),
                              ),
                              Text(
                                'Math',
                                style: TextStyle(
                                  fontFamily: 'Source Sans 3',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.0,
                                  color: Colors.teal[900],
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ],
                          ),
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              'Interested:',
                              style: TextStyle(
                                fontFamily: 'Source Sans 3',
                                fontWeight: FontWeight.bold,
                                fontSize: 22.0,
                                color: Colors.teal[900],
                                letterSpacing: 2.0,
                              ),
                            ),
                            Text(
                              'English',
                              style: TextStyle(
                                fontFamily: 'Source Sans 3',
                                fontWeight: FontWeight.bold,
                                fontSize: 22.0,
                                color: Colors.teal[900],
                                letterSpacing: 2.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.phone,
                      color: Colors.teal[900],
                    ),
                    title: Text(
                      '+44 123 456 789',
                      style: TextStyle(
                        fontFamily: 'Source Sans 3',
                        color: Colors.teal[900],
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.email,
                      color: Colors.teal[900],
                    ),
                    title: Text(
                      'gojosatoru@gmail.com',
                      style: TextStyle(
                        fontFamily: 'Source Sans 3',
                        color: Colors.teal[900],
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
                width: 150.0,
                child: Divider(
                  color: Colors.teal[100],
                ),
              ),
              Container(
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.facebook,
                      size: 35.0,
                      color: Colors.black,
                    ),
                    Icon(
                      Icons.mail,
                      size: 35.0,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
