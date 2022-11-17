import 'package:fair_attendance/teacher/screens/students_lists.dart';
import 'package:fair_attendance/teacher/screens/teacherprofile.dart';

import 'package:flutter/material.dart';

import '../../authmethods.dart';
import 'CreateLiveRoom.dart';

class TeacherHomePage extends StatefulWidget {
  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Homepage')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TProfile(),
                  ));
                },
                child: Text("Profile")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Students(),
                    ),
                  );
                },
                child: Text("Students")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CreateRoom(),
                    ),
                  );
                },
                child: Text("Create Live Room")),
            ElevatedButton(
              onPressed: () {
                AuthMethods().signOut(context);
              },
              child: Text('Sign Out'),
            )
          ],
        ),
      ),
    );
  }
}
