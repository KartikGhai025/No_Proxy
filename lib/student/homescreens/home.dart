import 'dart:async';
import 'package:fair_attendance/homepage.dart';
import 'package:location/location.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../authmethods.dart';
import 'dashboard.dart';
import 'liveroom.dart';
import 'profile.dart';


class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homepage')
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Profile(),
                      ));
                },
                child: Text("Profile")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Dashboard(),
                      ),);
                },
                child: Text("Dashboard")),

            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(title: '')
                    ),);
                },
                child: Text("Live Room")),
            ElevatedButton(onPressed: (){
              AuthMethods().signOut(context);


            },

              child: Text('Sign Out'),)

          ],
        ),
      ),
    );
  }
}

