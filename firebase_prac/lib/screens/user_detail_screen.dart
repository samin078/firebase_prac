import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'database.dart';


class UserDetailedScreen extends StatefulWidget {
  final String userId;

  const UserDetailedScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _UserDetailedScreenState createState() => _UserDetailedScreenState();
}

class _UserDetailedScreenState extends State<UserDetailedScreen> {
  late Future<Map<String, dynamic>> _userDataFuture;

  @override
  void initState() {
    super.initState();
    _userDataFuture = DatabaseMethods().getUserData(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _userDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available for this user.'));
          } else {
            Map<String, dynamic> userData = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('User ID: ${widget.userId}'),
                  Text('Username: ${userData['username']}'),
                  Text('Age: ${userData['age']}'),
                  // Add other user details here
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
