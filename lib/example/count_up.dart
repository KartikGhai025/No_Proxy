import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import '../widgets/rounded_button.dart';

class CountUpTimerPage extends StatefulWidget {
  static Future<void> navigatorPush(BuildContext context) async {
    return Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (_) => CountUpTimerPage(),
      ),
    );
  }

  @override
  _CountUpTimerPageState createState() => _CountUpTimerPageState();
}

class _CountUpTimerPageState extends State<CountUpTimerPage> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );
  final _scrollController = ScrollController();

  Location location = Location();
  bool _serviceEnabled = false;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;
  bool isListenLocation = false, isGetLocation = false;
  StreamController check = StreamController<LocationData>();
  late LocationData data;
  bool isLoading = true;
  var range;

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

  double calculateDistance(
      double? lat1, double? long1, double? lat2, double? long2) {
    const p = 0.017453292519943295;
    final a = 0.5 -
        cos((lat2! - lat1!) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((long2! - long1!) * p)) / 2;
    return 12742 * asin(sqrt(a)) * 1000;
  }

  @override
  void initState() {
    get_location();

    // _stopWatchTimer.onStartTimer();
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                StreamBuilder<int>(
                  stream: _stopWatchTimer.rawTime,
                  initialData: _stopWatchTimer.rawTime.value,
                  builder: (context, snap) {
                    final value = snap.data!;
                    final displayTime = StopWatchTimer.getDisplayTime(value,
                        milliSecond: false);

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
                ),

                SizedBox(
                  height: 10,
                ),
                Container(
                  child: StreamBuilder<List<StopWatchRecord>>(
                    stream: _stopWatchTimer.records,
                    initialData: _stopWatchTimer.records.value,
                    builder: (context, snap) {
                      final value = snap.data!;
                      if (value.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      Future.delayed(const Duration(milliseconds: 100), () {
                        _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeOut);
                      });
                      return ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          final data = value[index];
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              '${index + 1} ${data.displayTime}',
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                        },
                        itemCount: value.length,
                      );
                    },
                  ),
                ),

                /// Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: RoundedButton(
                        color: Colors.lightBlue,
                        onTap: _stopWatchTimer.onStartTimer,
                        child: const Text(
                          'Start',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: RoundedButton(
                        color: Colors.green,
                        onTap: _stopWatchTimer.onStopTimer,
                        child: const Text(
                          'Stop',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: RoundedButton(
                        color: Colors.red,
                        onTap: _stopWatchTimer.onResetTimer,
                        child: const Text(
                          'Reset',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
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
                              _permissionGranted =
                                  await location.requestPermission();
                              if (_permissionGranted !=
                                  PermissionStatus.granted) return;
                            }
                            _locationData = await location.getLocation();
                            setState(() {
                              isGetLocation = true;
                            });
                          },
                          child: const Text("Get Location")),
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
                              _permissionGranted =
                                  await location.requestPermission();
                              if (_permissionGranted !=
                                  PermissionStatus.granted) return;
                            }
                            _locationData = await location.getLocation();
                            setState(() {
                              isListenLocation = true;
                            });
                          },
                          child: const Text("Listen Location")),
                      StreamBuilder(
                          stream: location.onLocationChanged,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState !=
                                ConnectionState.waiting) {
                              data = snapshot.data as LocationData;
                              range = calculateDistance(
                                      _locationData.latitude,
                                      _locationData.longitude,
                                      data.latitude,
                                      data.longitude)
                                  .toStringAsFixed(2);
                              return Column(
                                children: [
                                  Text(calculateDistance(
                                          _locationData.latitude,
                                          _locationData.longitude,
                                          data.latitude,
                                          data.longitude)
                                      .toStringAsFixed(2)
                                      .toString()),
                                  Text(
                                      "Live Location: \n${data.latitude}/${data.longitude} ")
                                ],
                              );
                              //  return Text("Live Location: \n${data.latitude}/${data.longitude} ");
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
