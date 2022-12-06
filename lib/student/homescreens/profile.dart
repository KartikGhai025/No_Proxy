import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Profile extends StatelessWidget {
  final String documentId;

  Profile(this.documentId);
String name='';

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('student');
  return  Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bg3.png"), fit: BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Colors.transparent,

      body: SafeArea(
        child: FutureBuilder<DocumentSnapshot>(
          future: users.doc(documentId).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return const Text("Document does not exist");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
              return
              ProfileScreen(data['name']);

            }

            return const Text("loading");
          },
        ),
      ),
      ));
  }

  Widget ProfileScreen(String name){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const CircleAvatar(
          radius: 50.0,
          backgroundImage: NetworkImage('https://i.pinimg.com/originals/bb/41/33/bb41330a6ee5fc2b21715a91d54ecc0d.jpg'),
        ),
        Text(
          name,
          style: const TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 40.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'STUDENT',
          style: TextStyle(
            fontFamily: 'Source Sans Pro',
            color: Colors.teal.shade100,
            fontSize: 20.0,
            letterSpacing: 2.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 20.0,
          width: 150.0,
          child: Divider(
            color: Colors.teal.shade100,
          ),
        ),
        Card(
            margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
            child: ListTile(
              leading: const Icon(
                Icons.turned_in,
                color: Colors.teal,
              ),
              title: Text(
                documentId,
                style: TextStyle(
                  color: Colors.teal.shade900,
                  fontFamily: 'Source Sans Pro',
                  fontSize: 20.0,
                ),
              ),
            )),
        Card(
            margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
            child: ListTile(
              leading: const Icon(
                Icons.school,
                color: Colors.teal,
              ),
              title: Text(
                'Jaypee University of Engineering and Technology, Guna',
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.teal.shade900,
                    fontFamily: 'Source Sans Pro'),
              ),
            ))
      ],
    );
  }
}




