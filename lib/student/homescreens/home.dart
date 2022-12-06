import 'package:fair_attendance/student/homescreens/liveroom.dart';
import 'package:fair_attendance/student/homescreens/profile.dart';
import 'package:fair_attendance/student/homescreens/subjectslists.dart';
import 'package:flutter/material.dart';
import '../../authmethods.dart';

class HomePage extends StatefulWidget {
  String en;
  HomePage(this.en);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: ListView(children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
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
                            padding: EdgeInsets.only(right: 60),
                            child: Column(
                              children: [
                              ],
                            ),
                          )
                        ],
                      )),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                    height: MediaQuery.of(context).size.height - 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: Column(children: [
                      mainCard(context),
                      SizedBox(height: 60),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                                onTap:(){
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Profile(widget.en),
                                  ));
                                },
                                child: regularCard(context,Colors.yellow.shade300, 'Profile')),
                            InkWell(
                              focusColor: Colors.black12,
                              onTap: (){  Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SubjectList(widget.en),
                                ),
                              );},
                              child: regularCard(context,Colors.green.shade300,
                                  'Subjects'),
                            ),

                          ]),
                      SizedBox(height: 20),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                                onTap:(){
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => LiveRoom(widget.en),
                                    ),
                                  );
                                },
                                child: regularCard(context,Colors.red.shade400,'Live Room')),
                            InkWell(
                                onTap:(){

                                  AuthMethods().signOut(context);
                                },
                                child: regularCard( context,Colors.blue.shade300,'Sign Out')),

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
          width: MediaQuery.of(context).size.width *0.4,
          child: Text(cardLabel,
              textAlign: TextAlign.center,
              style: textStyle(16, FontWeight.w600, Colors.black)) ,
          // height: MediaQuery.of(context).size.height *0.1,
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
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

        ),
        SizedBox(height: 5),
        // Text(cardLabel,
        //     textAlign: TextAlign.center,
        //     style: textStyle(16, FontWeight.w600, Colors.black))
      ]),
    );
  }

  Container mainCard(context) {
    return Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
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
            //  color: Colors.red,
            alignment: Alignment.bottomCenter,
            width: (MediaQuery.of(context).size.width - 80) / 2,
            height: 140,
            child: Image.asset(
              "assets/images/6.png",
            ),
          ),
          SizedBox(
            width: (MediaQuery.of(context).size.width - 80) / 2,
            height: 100,
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Hello \Student',
                  style: textStyle(24, FontWeight.w800, Colors.black)),
              SizedBox(height: 16),
              Text("It's not about perfect. It's about effort",
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
