import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AttendanceDetails extends StatefulWidget {
  String sub;
  String en;
   AttendanceDetails(this.sub,this.en) ;

  @override
  State<AttendanceDetails> createState() => _AttendanceDetails();
}

class _AttendanceDetails extends State<AttendanceDetails> {

  // int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> usersStream = FirebaseFirestore.instance
        .collection('student')
        .doc(widget.en)
        .collection(widget.sub)
        .snapshots();

    return

      Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage("assets/images/bg3.png"), fit: BoxFit.cover)),
    child: Scaffold(
    backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
        child: StreamBuilder<QuerySnapshot>(
          stream: usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                //  final PropertyDetail propertyModel ;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: data['isColor']?Colors.green.shade300:Colors.red.shade600,
                    child: ListTile(
                        leading: const Icon(Icons.arrow_forward_ios),
                        title:
                      Text(
                            data['present'],

                        )),
                  ),

                );
              }).toList(),
            );
          },
        ),
      ),
    ));
  }
}
