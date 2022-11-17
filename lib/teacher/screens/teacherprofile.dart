import 'dart:async';
import 'package:location/location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class TProfile extends StatefulWidget {
  @override
  State<TProfile> createState() => _TProfileState();
}

class _TProfileState extends State<TProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Homepage')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Name"),
            Text("Year"),
            Text("Enrollment No"),
          ],
        ),
      ),
    );
  }
}
