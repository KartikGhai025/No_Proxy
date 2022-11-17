import 'package:flutter/material.dart';
import 'count_up.dart';


class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.pinkAccent,
                  padding: const EdgeInsets.all(4),
                  shape: const StadiumBorder(),
                ),
                onPressed: () {
                  CountUpTimerPage.navigatorPush(context);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Go To CountUpTimer',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.pinkAccent,
                  padding: const EdgeInsets.all(4),
                  shape: const StadiumBorder(),
                ),
                onPressed: () {
                //  CountDownTimerPage.navigatorPush(context);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Go To CountDownTimer',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// Count UP Timer



// Count Down Timer





// Rounded Button






// import 'package:flutter/material.dart';
// import 'package:custom_timer/custom_timer.dart';
//
//
//
// class TimerState extends StatefulWidget {
//   @override
//   _TimerStateState createState() => _TimerStateState();
// }
//
// class _TimerStateState extends State<TimerState> {
//   final CustomTimerController _controller = CustomTimerController();
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("CustomTimer example"),
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             CustomTimer(
//
//                 controller: _controller,
//                 begin: Duration(days: 1),
//                 end: Duration(),
//                 builder: (remaining) {
//                   return Text(
//                       "${remaining.hours}:${remaining.minutes}:${remaining.seconds}.${remaining.milliseconds}",
//                       style: TextStyle(fontSize: 24.0));
//                 }),
//             SizedBox(height: 24.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 RoundedButton(
//                   text: "Start",
//                   color: Colors.green,
//                   onPressed: () => _controller.start(),
//                 ),
//                 RoundedButton(
//                   text: "Pause",
//                   color: Colors.blue,
//                   onPressed: () => _controller.pause(),
//                 ),
//                 RoundedButton(
//                   text: "Reset",
//                   color: Colors.red,
//                   onPressed: () => _controller.reset(),
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class RoundedButton extends StatelessWidget {
//   final String text;
//   final Color color;
//   final void Function()? onPressed;
//
//   RoundedButton({required this.text, required this.color, this.onPressed});
//
//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       child: Text(text, style: TextStyle(color: Colors.white)),
//       style: TextButton.styleFrom(
//         backgroundColor: color,
//         padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
//         shape:
//         RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
//       ),
//       onPressed: onPressed,
//     );
//   }
// }