import 'package:fair_attendance/teacher/screens/students_lists.dart';
import 'package:fair_attendance/teacher/screens/teacherprofile.dart';
import 'package:flutter/material.dart';
import '../../authmethods.dart';
import 'CreateLiveRoom.dart';

class TeacherHomePage extends StatefulWidget {
  String en;
  TeacherHomePage(this.en);
  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bgg.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 60),
                            child: Column(
                              children: const [],
                            ),
                          )
                        ],
                      )),
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                    height: MediaQuery.of(context).size.height - 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: Column(children: [
                      mainCard(context),
                      const SizedBox(height: 40),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => TProfile(widget.en),
                                  ));
                                },
                                child: regularCard(
                                    context, Colors.yellow.shade300, 'Profile')),
                            InkWell(
                              focusColor: Colors.black12,
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Students(),
                                  ),
                                );
                              },
                              child: regularCard(
                                  context, Colors.green.shade300, 'Students'),
                            ),
                          ]),
                      const SizedBox(height: 20),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CreateRoom(),
                                    ),
                                  );
                                },
                                child: regularCard(
                                    context, Colors.red.shade400, 'Create Room')),
                            InkWell(
                                onTap: () {
                                  AuthMethods().signOut(context);
                                },
                                child: regularCard(
                                    context, Colors.blue.shade300, 'Sign Out')),
                          ])
                    ]),
                  ),
                ],
              )),
        ]));
  }

  SizedBox regularCard(BuildContext context, Color color, String cardLabel) {
    return SizedBox(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: color,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300,
                  offset: Offset.zero,
                  blurRadius: 20)
            ],
          ),
          child: Text(cardLabel,
              textAlign: TextAlign.center,
              style: textStyle(16, FontWeight.w600, Colors.black)),
        ),
        const SizedBox(height: 5),
      ]),
    );
  }

  Container mainCard(context) {
    return Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[100],
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade300,
                offset: Offset.zero,
                blurRadius: 20)
          ],
        ),
        child: Row(children: [
          Container(
            alignment: Alignment.bottomCenter,
            width: (MediaQuery.of(context).size.width - 80) / 2,
            height: 140,
            child: Image.network(
              "http://clipart-library.com/images_k/teacher-transparent/teacher-transparent-2.png",
            ),
          ),
          SizedBox(
            width: (MediaQuery.of(context).size.width - 80) / 2,
            height: 180,
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Hello \nTeacher',
                  style: textStyle(24, FontWeight.w800, Colors.black)),
              const SizedBox(height: 16),
              Text(
                  'Better than a thousand days of diligent study is one day with a great teacher',
                  style: textStyle(16, FontWeight.w800, Colors.grey.shade600))
            ]),
          ),
        ]));
  }

  TextStyle textStyle(double size, FontWeight fontWeight, Color colorName) =>
      TextStyle(
        fontFamily: 'QuickSand',
        color: colorName,
        fontSize: size,
        fontWeight: fontWeight,
      );
}
