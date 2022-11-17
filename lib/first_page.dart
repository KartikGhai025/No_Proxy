import 'package:fair_attendance/student/auth/login_screen.dart';
import 'package:fair_attendance/teacher/auth/teacher_login.dart';
import 'package:flutter/material.dart';
import '../../authmethods.dart';



class FirstPage extends StatefulWidget {

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                },
                child: Text("Student")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TeacherLoginScreen(),
                    ),);
                },
                child: Text("Teacher")),



          ],
        ),
      ),
    );
  }
}

