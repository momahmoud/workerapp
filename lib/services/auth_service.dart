
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workerapp/models/user_data.dart';



class AuthService {
  static final _firestore = Firestore.instance;
  static final _auth = FirebaseAuth.instance;

  static void signupUser(
      BuildContext context, String name, String email, String password) async {
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      FirebaseUser signedInUser = authResult.user;
      if (signedInUser != null) {
          _firestore.collection('users').document(signedInUser.uid).setData(
          {
            'name': name,
            'email': email,
            'profileImageUrl': ' ',
          },
        );

         Provider.of<UserData>(context, listen: false).currentUserId = signedInUser.uid;
        Navigator.pop(context);
   

        
      }
    } catch (e) {
      throw e;
    }
  }

  static void logout() {
    try {
      _auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  static void signinUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } catch (e) {
      print(e);
    }
  }
}
