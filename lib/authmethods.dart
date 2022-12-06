import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<String> signUpUser({
    required String eno,
    required String password,
    required String name,
 //   required String sem

  }) async {
    String res = "Some error Occurred";
    try {
      if (eno.isNotEmpty ||
          password.isNotEmpty ) {

        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: eno+'@juetguna.in',
          password: password,
        );

        await _firestore
            .collection("student")
            .doc(eno)
            .set({
          'eno': eno,
          'name':name,

        });

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<String> teacher_signUpUser({
    required String password,
    required String name,
    required String eno

  }) async {
    String res = "Some error Occurred";
    try {
      if (eno.isNotEmpty ||
          password.isNotEmpty ) {

        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: eno+'@juetguna.in',
          password: password,
        );

        await _firestore
            .collection("teacher")
            .doc(eno)
            .set({

          'name':name,
          'eno':eno,
        });

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }


  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {

        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.pop(context);
  }
}


showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}