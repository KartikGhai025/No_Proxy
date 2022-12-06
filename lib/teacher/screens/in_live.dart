import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class InLive extends StatefulWidget {
  String sub;
  InLive(this.sub);


  @override
  _InLiveState createState() => _InLiveState();
}

class _InLiveState extends State<InLive> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );

 var totaltime;
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




  Widget LiveScreen() {
    return

      Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage("assets/images/bg3.png"), fit: BoxFit.cover)),
    child:
      Scaffold(
        backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('Live lecture'),
        leading: Icon(
          Icons.circle,
          color: Colors.red,
        ),
      ),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.sub,
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ),

          ),
          timer_stream(),
          const SizedBox(
            height: 10,
          ),

          ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection("live")
                    .doc('class')
                    .update({
                  'isStop': true,
                  'duration': totaltime

                });

                //      print('kartik');
                      sleep(const Duration(seconds: 5));

                  //    print('ghai');


                await FirebaseFirestore.instance
                    .collection("live")
                    .doc('class')
                    .update({
                  'isClass': false,

                });
                Navigator.pop(context);
              },
              child: Text('Stop')),
        ],
      )   ),
    );
  }




  Widget timer_stream() {
    return StreamBuilder<int>(
      stream: _stopWatchTimer.rawTime,
      initialData: _stopWatchTimer.rawTime.value,
      builder: (context, snap) {
        final value = snap.data!;
         displayTime =
        StopWatchTimer.getDisplayTime(value, milliSecond: false);
        totaltime= StopWatchTimer.getDisplayTime(value, milliSecond: false, second: true);
        //print(double.parse(totaltime));
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



  @override
  void initState() {
_stopWatchTimer.onStartTimer();
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override

  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> _usersStream =
    FirebaseFirestore.instance.collection('live').doc('class').snapshots();
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: _usersStream,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return snapshot.data!['isClass']
              ?
          //ListTile(title: Text(snapshot.data!['subject']),)
          LiveScreen()
              : SizedBox();
        },
      ),
    );
  }
}
