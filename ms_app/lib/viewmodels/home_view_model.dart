import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeViewModel with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _userName;
  String? get userName => _userName;

  Future<String> fetchUserName() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userData = await _firestore.collection('users').doc(user.uid).get();
      if (userData.exists) {
        _userName = "${userData['firstName']} ${userData['lastName']}";
        notifyListeners();
        return _userName!;
      }
    }
    return 'User';
  }
}
