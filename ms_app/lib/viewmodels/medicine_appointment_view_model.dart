//ui ve servis arasında köprü görevi görür
//ve ilaç randevu yönetimini sağlar
// lib/viewmodels/medicine_appointment_view_model.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:logger/logger.dart';
import 'package:ms_app/models/medicine_appointment_model.dart';
import 'package:ms_app/services/medicine_appointment_service.dart';

class MedicineAppointmentViewModel with ChangeNotifier {
  final FirebaseAuth auth;
  final MedicineAppointmentService medicineAppointmentService;
 // final Logger _logger = Logger();

  List<MedicineAppointmentModel> _appointments = [];

  MedicineAppointmentViewModel(this.auth, this.medicineAppointmentService);

  List<MedicineAppointmentModel> get appointments => _appointments;

  Future<void> fetchMedicineAppointments() async {
    User? user = auth.currentUser;
    if (user != null) {
      _appointments = await medicineAppointmentService.getMedicineAppointments(user.uid);
      notifyListeners();
    }
  }

  Future<void> saveOrUpdateMedicineAppointment(MedicineAppointmentModel appointment) async {
    await medicineAppointmentService.saveOrUpdateMedicineAppointment(appointment);
    await fetchMedicineAppointments();
  }
}
