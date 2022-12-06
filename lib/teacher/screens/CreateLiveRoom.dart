import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fair_attendance/teacher/screens/in_live.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class CreateRoom extends StatefulWidget {
  // String en;
  //
  // CreateRoom(this.en) ;

  @override
  State<CreateRoom> createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  var items = [
    'English',
    'Software Development Fundamentals',
    'Applied Physics',
    'Engineering Mathematics',
    'Data Structures',
    'Database Management System',
    'Computer Networks',
    'Theory of Computation',
    'Full Stack Development',
    'Artificial Intelligence'
  ];

  Location location = Location();
  bool _serviceEnabled = false;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;
  bool isGetLocation = false;
  late LocationData data;
  bool isLoading = true;

  void get_location() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (_serviceEnabled) return;
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) return;
    }
    _locationData = await location.getLocation();
    setState(() {
      isGetLocation = true;
      isLoading = false;
    });
  }

  @override
  void initState() {
    get_location();

    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var data = FirebaseFirestore.instance.collection("teacher").doc(widget.en).get().then((value) {
    //   print(value['teacher']);

    // });


    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg3.png"), fit: BoxFit.cover)),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: isLoading
                  ? const CircularProgressIndicator()
                  : Center(
                      child: ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () async {
                                get_location();
                                await FirebaseFirestore.instance
                                    .collection("live")
                                    .doc('class')
                                    .update({
                                  'isClass': true,
                                  'isStop': false,
                                  'la': _locationData.latitude,
                                  'lo': _locationData.longitude,
                                  'subject': items[index],
                                  'teacher':''
                                });
                                //print(_locationData.latitude);
                                //print(_locationData.longitude);
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) => InLive(items[index]),
                                ));
                                //  Navigator.pop(context);
                              },
                              child: ListTile(
                                  leading: const Icon(Icons.arrow_forward_ios),
                                  trailing: Text(
                                    Random().nextInt(10).toString(),
                                    style: const TextStyle(
                                        color: Colors.green, fontSize: 15),
                                  ),
                                  title: Text(items[index])),
                            );
                          }),
                    ),
            )));
  }
}
