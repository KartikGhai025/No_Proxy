import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fair_attendance/student/homescreens/submit_page.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class LiveRoom extends StatefulWidget {

  String en;
  LiveRoom(this.en);
  // static Future<void> navigatorPush(BuildContext context) async {
  //   return Navigator.push<void>(
  //     context,
  //     MaterialPageRoute(
  //       builder: (_) => LiveRoom(),
  //     ),
  //   );
  // }

  @override
  _LiveRoomState createState() => _LiveRoomState();
}

class _LiveRoomState extends State<LiveRoom> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );

  bool colorRange= false;

  Location location = Location();
  bool _serviceEnabled = false;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;
  bool isListenLocation = false;
  StreamController check = StreamController<LocationData>();
  late LocationData data;
  var range;
 var displayTime;
  late StreamController myScont = StreamController();
  late Stream myStream = myScont.stream.asBroadcastStream();
  final _scrollController = ScrollController();

  bool isLoading = true;

  DocumentReference<Map<String, dynamic>> class_data =
      FirebaseFirestore.instance.collection('live').doc('class');
  num lon = 0;
  num lat = 0;
  bool isClass = false;
  String sub = '';

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
      isLoading = false;
    });
  }


//haversine formula
  double calculateDistance(
      double? lat1, double? long1, double? lat2, double? long2) {
    const p = 0.017453292519943295;
    final a = 0.5 -
        cos((lat2! - lat1!) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((long2! - long1!) * p)) / 2;
    double val = 12742 * asin(sqrt(a)) * 1000;
    myScont.sink.add(val);
    myStream.listen((event) {
      if (event > 10) {
        //print(event * 10000);
      }
    });
    return val;
  }


  getClass() {
    FirebaseFirestore.instance
        .collection("live")
        .doc('class')
        .get()
        .then((value) {
      isClass = value['isClass'];
      lon = value['lo'];
      lat = value['la'];
      sub = value['subject'];

    });
  }

  Widget LiveScreen(String? subject, bool? isStop) {
    if(isStop!){
      Future.delayed(Duration.zero, () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => SubmitPage(subject!,displayTime,widget.en, colorRange),
        )  );

      } );}
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Live lecture'),
        leading: const Icon(
          Icons.circle,
          color: Colors.red,
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Expanded(
                        child: Text(
                          subject!+'',
                          style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                ),
                timer_stream(),
                color_indicator(),
                const SizedBox(
                  height: 10,
                ),
                listen_Location_button(),
                Listen_Distance()
              ],
            ),
    );
  }

  Widget listen_Location_button() {
    return Center(
      child: ElevatedButton(
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
          child: const Text("Listen Location")),
    );
  }

  Widget color_indicator() {
    return StreamBuilder(
        stream: myStream,
        builder: (context, snap) {
          //S   print(snap.data);
           colorRange = false;
          if (!snap.hasData) {
            return const CircularProgressIndicator();
          }
          if (snap.data as double < 10.0) {
            _stopWatchTimer.onStartTimer();
            colorRange = true;
          } else {
            colorRange = false;
            _stopWatchTimer.onStopTimer();
          }
          return colorRange
              ? const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.green,
                )
              : Container(
                  height: 100,
                  width: 100,
                  color: Colors.red,
                );
        });
  }

  Widget timer_stream() {
    return StreamBuilder<int>(
      stream: _stopWatchTimer.rawTime,
      initialData: _stopWatchTimer.rawTime.value,
      builder: (context, snap) {
        final value = snap.data!;
        displayTime =
            StopWatchTimer.getDisplayTime(value, milliSecond: false);

        return Column(
          children: <Widget>[
            Text(
              displayTime,
              style: const TextStyle(
                  fontSize: 40,
                  fontFamily: 'Helvetica',
                  fontWeight: FontWeight.bold),
            ),
          ],
        );
      },
    );
  }

  Widget Listen_Distance() {
    return StreamBuilder(
        stream: location.onLocationChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.waiting) {
            data = snapshot.data as LocationData;
            range = calculateDistance(lat.toDouble(), lon.toDouble(),
                    data.latitude, data.longitude)
                .toStringAsFixed(2);
            return Column(
              children: [
                Text(range),
                Text("Live Location: \n${data.latitude}/${data.longitude} ")
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  @override
  void initState() {
    get_location();
    getClass();
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
//   Widget build(BuildContext context) {
//     getClass();
//     return LiveScreen();
//   }
// }

  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> _usersStream =
        FirebaseFirestore.instance.collection('live').doc('class').snapshots();
    return
      Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bg3.png"), fit: BoxFit.cover)),
          child:
      Scaffold(
      backgroundColor: Colors.transparent,
      body: StreamBuilder<DocumentSnapshot>(
        stream: _usersStream,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          return snapshot.data!['isClass']
              ?
              //ListTile(title: Text(snapshot.data!['subject']),)
              LiveScreen(snapshot.data!['subject'], snapshot.data!['isStop'])
              : const Center(child: Text('No Class Found'),);
        },
      ),
      ) );
  }
}




