import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instalike/models/user.dart' as model;
import 'package:instalike/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection("users").doc(_auth.currentUser!.uid).get();

    return model.User.fromSnap(snap);
  }

  //creer compte
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Erreur";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        /******************** ENREGISTREMENT COMPTE ********************/
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        /******************** ENREGISTREMENT PP ********************/
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilPics', file, false);

        model.User user = model.User(
            username: username,
            uid: cred.user!.uid,
            email: email,
            bio: bio,
            followers: [],
            following: [],
            photoUrl: photoUrl);

        /******************** STOCKAGE COMPTE ********************/
        await _firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );

        /* Id document FIrestore et id user Fireauth different
        await _firestore.collection('users').add({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'followers': [],
          'following': [],
        });
        */

        res = 'succès';
      }
    } /*on FirebaseAuthException catch(error) {
      if(error.code == 'invalid-email') {
        res = 'Email mal formatté';
      }
    }*/
    catch (err) {
      res = err.toString();
    }
    return res;
  }

  //login
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Erreur";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        _auth.signInWithEmailAndPassword(email: email, password: password);
        res = "succès";
      } else {
        res = "Remplissez les champs";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
