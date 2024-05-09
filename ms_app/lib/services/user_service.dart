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
  final Logger logger = Logger();

  Future<void> saveDoctorVisitDate(DateTime lastVisitDate, int age, bool needsPrescription, String dosageFrequency, DateTime? lastTakenDate, bool isTakingMedicine) async {
    if (_auth.currentUser != null) {
      try {
        await _firestore.collection('doctorVisits').add({
          'userId': _auth.currentUser!.uid,
          'lastVisitDate': lastVisitDate,
          'age': age,
          'needsPrescription': needsPrescription,
          'dosageFrequency': dosageFrequency,
          'lastTakenDate': lastTakenDate,
          'isTakingMedicine': isTakingMedicine
        });
        logger.i('Doctor visit data saved successfully');
      } catch (e) {
        logger.e('Error saving doctor visit data: $e');
      }
    }
  }

  Future<void> logOut() async {
    try {
      await _auth.signOut();
      logger.i('User logged out successfully');
    } catch (e) {
      logger.e('Error logging out: $e');
    }
  }
}
