import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SubmitPage extends StatefulWidget {
  String en;
  String sub;
  bool iscolor;
  var time;
  SubmitPage(this.sub, this.time, this.en, this.iscolor);

  @override
  State<SubmitPage> createState() => _SubmitPageState();
}

class _SubmitPageState extends State<SubmitPage> {
  @override
  Widget build(BuildContext context) {
    String datetime = DateTime.now().toString();
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg3.png"), fit: BoxFit.cover)),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.sub,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.en,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection('student')
                          .doc(widget.en)
                          .collection(widget.sub)
                          .add({'present': datetime,
                      'isColor': widget.iscolor});

                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(colors: [
                            Colors.yellow,
                            Colors.blue,
                          ])),
                      child: const Center(
                        child: Text(
                          "Submit ",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
            )));
  }
}

// ElevatedButton(
//     onPressed: () async {
//       await FirebaseFirestore.instance
//           .collection('student')
//           .doc(widget.en)
//           .collection(widget.sub)
//           .add({datetime: true});
//
//       await FirebaseFirestore.instance
//           .collection('student')
//           .doc(widget.en)
//           .collection('attendance')
//           .doc(widget.sub)
//           .set({datetime: true});
//     },
//     child: CircleAvatar())
