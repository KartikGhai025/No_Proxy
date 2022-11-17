import 'dart:async';
import 'dart:math' show cos, sqrt, asin;
import 'package:latlng/latlng.dart';
import 'package:location/location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'authmethods.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Location location = new Location();
  bool _serviceEnabled = false;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;
  bool isListenLocation = false, isGetLocation = false;
  StreamController check = StreamController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () async {
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
                  });
                },
                child: Text("Get Location")),
            isGetLocation
                ? SelectableText(
                    "Location: ${_locationData.latitude}/${_locationData.longitude}")
                : Container(),
            ElevatedButton(
                onPressed: () async {
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
                    isListenLocation = true;
                  });
                },
                child: Text("Listen Location")),
            StreamBuilder(
                stream: location.onLocationChanged,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.waiting) {
                    var data = snapshot.data as LocationData;
                    // if(_locationData==data){
                    //   return Text('in range');
                    // }
                    // else
                    return Column(
                      children: [
                        SelectableText(calculateDistance(_locationData.latitude, _locationData.longitude, data.latitude, data.longitude).toString()),
                        SelectableText(
                            "Live Location: \n${data.latitude}/${data.longitude} ")
                      ],
                    );
                    //  return Text("Live Location: \n${data.latitude}/${data.longitude} ");
                  } else
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                }),
          ],
        ),
      ),
    );
  }
}

double calculateDistance(double? lat1, double? long1, double? lat2, double? long2) {
  const p = 0.017453292519943295;
  final a = 0.5 -
      cos((lat2! - lat1!) * p) / 2 + cos(lat1 * p) * cos(lat2* p) * (1 - cos((long2! - long1!) * p)) / 2;
  return 12742 * asin(sqrt(a));
}
