//ilaç randevu bilgilerini temsil eder
// lib/models/medicine_appointment_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class MedicineAppointmentModel {
  String id;
  String userId;
  DateTime appointmentDate;
  String dosageFrequency;
  bool needsPrescription;

  MedicineAppointmentModel({
    required this.id,
    required this.userId,
    required this.appointmentDate,
    required this.dosageFrequency,
    required this.needsPrescription,
  });

  factory MedicineAppointmentModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return MedicineAppointmentModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      appointmentDate: (data['appointmentDate'] as Timestamp).toDate(),
      dosageFrequency: data['dosageFrequency'] ?? '',
      needsPrescription: data['needsPrescription'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'appointmentDate': appointmentDate,
      'dosageFrequency': dosageFrequency,
      'needsPrescription': needsPrescription,
    };
  }
}
