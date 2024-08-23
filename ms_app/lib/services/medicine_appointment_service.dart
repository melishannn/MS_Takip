// lib/services/medicine_appointment_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:ms_app/models/medicine_appointment_model.dart';

class MedicineAppointmentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Logger _logger = Logger();

  Future<void> saveOrUpdateMedicineAppointment(MedicineAppointmentModel appointment) async {
    try {
      await _firestore.collection('medicine_appointments').doc(appointment.id).set(appointment.toMap(), SetOptions(merge: true));
      _logger.i('Medicine appointment saved or updated successfully');
    } catch (e) {
      _logger.e('Error saving or updating medicine appointment: $e');
    }
  }

  Future<List<MedicineAppointmentModel>> getMedicineAppointments(String userId) async {
    try {
      QuerySnapshot query = await _firestore.collection('medicine_appointments').where('userId', isEqualTo: userId).get();
      return query.docs.map((doc) => MedicineAppointmentModel.fromFirestore(doc)).toList();
    } catch (e) {
      _logger.e('Error fetching medicine appointments: $e');
      return [];
    }
  }
}
