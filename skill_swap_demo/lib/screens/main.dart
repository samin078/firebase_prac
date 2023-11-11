import 'package:flutter/material.dart';


class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.indigo[200],
        body: Center(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: (){
                Navigator.pushNamed(context, 'loc');
              },
                  child: Text(
                    'See Location',
                  ),
              ),
              ElevatedButton(onPressed: (){
                Navigator.pushNamed(context, 'home');
              },
                child: Text(
                  'User Profile',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
