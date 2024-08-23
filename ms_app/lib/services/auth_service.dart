import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ms_app/views/screens/home_page.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential> registerWithEmailAndPassword(String email, String password, String firstName, String lastName) async {
    await Firebase.initializeApp();
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

    // Kayıt sonrası kullanıcı bilgilerini 'users' koleksiyonuna ekle
    await _firestore.collection('users').doc(userCredential.user!.uid).set({
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
    });

    return userCredential;
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }

  Future<void> signInWithEmailAndPassword(String email, String password, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    } catch (e) {
      String message = 'An error occurred. Please try again later.';
      if (e.toString().contains('user-not-found')) {
        message = 'No user found for that email.';
      } else if (e.toString().contains('wrong-password')) {
        message = 'Wrong password provided for that user.';
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    }
  }

  // Kullanıcı bilgilerini appointments koleksiyonuna kaydetmek ve güncellemek için
  Future<void> saveAppointmentData(String uid, Map<String, dynamic> data) async {
    await _firestore.collection('appointments').doc(uid).set(data, SetOptions(merge: true));
  }

  Future<Map<String, dynamic>?> getUserData(String uid) async {
    DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();
    return userDoc.data() as Map<String, dynamic>?;
  }

  Future<Map<String, dynamic>?> getAppointmentData(String uid) async {
    DocumentSnapshot appointmentDoc = await _firestore.collection('appointments').doc(uid).get();
    return appointmentDoc.data() as Map<String, dynamic>?;
  }

  // Oturumu açan kullanıcının isimlerini almak için metot
  Future<Map<String, dynamic>?> getCurrentUserName() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
      return userDoc.data() as Map<String, dynamic>?;
    }
    return null;
  }
}
