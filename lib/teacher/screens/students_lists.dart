import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Students extends StatefulWidget {
  @override
  _StudentsState createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('student').snapshots();

  @override
  Widget build(BuildContext context) {
    return
      Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bg3.png"), fit: BoxFit.cover)),
          child:

      Scaffold(
      backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
              document.data()! as Map<String, dynamic>;
              return
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(

               tileColor: Colors.black12,
                    leading: const Icon(Icons.person),
                    // trailing: Text(
                    //   Random().nextInt(10).toString(),
                    //   style: TextStyle(color: Colors.green, fontSize: 15),
                    // ),
                    title: Text(data['name'])),
                );
            }).toList(),
          );
        },
      ),
      )  );
  }
}
