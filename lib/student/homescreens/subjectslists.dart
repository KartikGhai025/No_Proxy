import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fair_attendance/student/homescreens/attendance.dart';
import 'package:flutter/material.dart';

class SubjectList extends StatefulWidget {
  String en;
  SubjectList(this.en);
  @override
  _SubjectListState createState() => _SubjectListState();
}

class _SubjectListState extends State<SubjectList> {
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

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg3.png"), fit: BoxFit.cover)),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            //   appBar: AppBar(),
            body: ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: (){

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AttendanceDetails(items[index], widget.en),
                        ),
                      );
                    },
                    child: ListTile(
                        leading: const Icon(Icons.arrow_forward_ios),
                        title: Text(
                          items[index],
                        )),
                  );
                })
        )
    );
  }
}
