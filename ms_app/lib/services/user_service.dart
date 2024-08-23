import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Logger _logger = Logger();

  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> saveUserData(String userId, Map<String, dynamic> userData) async {
    await _firestore.collection('users').doc(userId).set(userData, SetOptions(merge: true));
  }

  Future<void> saveOrUpdateUserData(String userId, Map<String, dynamic> userData) async {
    await _firestore.collection('users').doc(userId).set(userData, SetOptions(merge: true));
  }

  Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(userId).get();
      return doc.data() as Map<String, dynamic>?;
    } catch (e) {
      _logger.e('Error fetching user data: $e');
      return null;
    }
  }

  Future<void> saveAppointmentData({
    required String userId,
    required DateTime lastVisitDate,
    required DateTime nextDoctorVisitDate,
    required DateTime nextMRApptDate,
    required DateTime nextTestDate,
    required int age,
    required bool needsPrescription,
    required String dosageFrequency,
    required DateTime? lastTakenDate,
    required bool isTakingMedicine,
  }) async {
    try {
      await _firestore.collection('appointments').doc(userId).set({
        'lastVisitDate': lastVisitDate,
        'nextDoctorVisitDate': nextDoctorVisitDate,
        'nextMRApptDate': nextMRApptDate,
        'nextTestDate': nextTestDate,
        'age': age,
        'needsPrescription': needsPrescription,
        'dosageFrequency': dosageFrequency,
        'lastTakenDate': lastTakenDate,
        'isTakingMedicine': isTakingMedicine,
      });
    } catch (e) {
      throw Exception('Error saving appointment data: $e');
    }
  }

  Future<Map<String, dynamic>?> getAppointmentData(String userId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('appointments').doc(userId).get();
      return doc.data() as Map<String, dynamic>?;
    } catch (e) {
      _logger.e('Error fetching appointment data: $e');
      return null;
    }
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }
}
