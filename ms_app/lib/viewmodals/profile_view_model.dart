// kullanıcı tarafından girilen bilgileri alacak ve
// UserService
// aracılığıyla bu bilgileri Firebase Firestore'a kaydedecek bir ViewModel oluşturacağız.
// lib/viewmodels/profile_view_model.dart
// lib/viewmodels/profile_view_model.dart
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:ms_app/services/user_service.dart';

class ProfileViewModel with ChangeNotifier {
  final UserService _userService;
  final Logger _logger = Logger();

  bool _isTakingMedicine = false;
  bool _needsPrescription = false;
  String _dosageFrequency = '';
  int _age = 0;
  DateTime _lastDoctorVisitDate = DateTime.now();

  ProfileViewModel(this._userService);

  int get age => _age;
  set age(int value) {
    if (_age != value) {
      _age = value;
      notifyListeners();
    }
  }

  bool get isTakingMedicine => _isTakingMedicine;
  set isTakingMedicine(bool value) {
    if (_isTakingMedicine != value) {
      _isTakingMedicine = value;
      notifyListeners();
    }
  }

  bool get needsPrescription => _needsPrescription;
  set needsPrescription(bool value) {
    if (_needsPrescription != value) {
      _needsPrescription = value;
      notifyListeners();
    }
  }

  String get dosageFrequency => _dosageFrequency;
  set dosageFrequency(String value) {
    if (_dosageFrequency != value) {
      _dosageFrequency = value;
      notifyListeners();
    }
  }

  DateTime get lastDoctorVisitDate => _lastDoctorVisitDate;
  set lastDoctorVisitDate(DateTime value) {
    if (_lastDoctorVisitDate != value) {
      _lastDoctorVisitDate = value;
      notifyListeners();
    }
  }

  Future<void> updateUserData() async {
    try {
      await _userService.saveDoctorVisitDate(_lastDoctorVisitDate, _age, _needsPrescription, _dosageFrequency, null, _isTakingMedicine);
      _logger.i('User data updated successfully');
    } catch (e) {
      _logger.e('Error updating user data: $e');
    }
  }

  Future<void> logOut() async {
    try {
      await _userService.logOut();
      _logger.i('User logged out successfully');
    } catch (e) {
      _logger.e('Error logging out: $e');
    }
  }
}


