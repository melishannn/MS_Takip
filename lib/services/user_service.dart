// lib/services/user_service.dart
//İş mantığını kullanıcı arayüzünüzden ayrı olarak ele alan bir hizmet oluşturmalısınız. Bu servis, kullanıcının
// yaşını güncellemek, ilaç ayrıntılarını işlemek ve doktor ziyaret tarihlerini yönetmek 
//gibi işlemlerle ilgilenecektir.
// lib/services/user_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Logger _logger = Logger();
   final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      DocumentSnapshot doc = await _db.collection('users').doc(userId).get();
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
    DateTime? lastTakenDate,
    DateTime? lastTakenDoctorDate,
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
      }, SetOptions(merge: true));
      _logger.i('Appointment data saved successfully');
    } catch (e) {
      _logger.e('Error saving appointment data: $e');
    }
  }
  Future<void> logOut() async {
    try {
      await _auth.signOut();
      _logger.i('User logged out successfully');
    } catch (e) {
      _logger.e('Error logging out: $e');
    }
  }
}
