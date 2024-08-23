import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:ms_app/services/user_service.dart';

class ProfileViewModel with ChangeNotifier {
  final FirebaseAuth auth;
  final UserService userService;

  final Logger _logger = Logger();
  DateTime? _lastDoctorVisitDate;
  DateTime? _nextDoctorVisitDate;
  DateTime? _nextMRApptDate;
  DateTime? _nextTestDate;
  DateTime? _lastTakenDate;
  bool _isTakingMedicine = false;
  bool _needsPrescription = false;
  bool isFirstTime = true;
  String _dosageFrequency = '';
  int _age = 0;

  Map<String, dynamic>? _userData;
  Map<String, dynamic>? _appointmentData;
  bool _hasUserData = false;

  ProfileViewModel(this.auth, this.userService) {
    _initializeUser();
  }

  void _initializeUser() {
    auth.authStateChanges().listen((User? user) {
      if (user != null) {
        fetchUserData();
        fetchAppointmentData();
      } else {
        _clearUserData();
      }
    });
  }

  void _clearUserData() {
    _userData = null;
    _appointmentData = null;
    _lastDoctorVisitDate = null;
    _nextDoctorVisitDate = null;
    _nextMRApptDate = null;
    _nextTestDate = null;
    _lastTakenDate = null;
    _isTakingMedicine = false;
    _needsPrescription = false;
    _dosageFrequency = '';
    _age = 0;
    _hasUserData = false;
    notifyListeners();
  }

  Map<String, dynamic>? get userData => _userData;
  Map<String, dynamic>? get appointmentData => _appointmentData;

  bool get hasUserData => _hasUserData;

  Future<void> fetchUserData() async {
    User? user = auth.currentUser;
    if (user != null) {
      _userData = await userService.getUserData(user.uid);
      _hasUserData = _userData != null;
      if (_userData != null) {
        _age = _userData!['age'] ?? 0;
        notifyListeners();
      }
    }
  }

  Future<void> fetchAppointmentData() async {
    User? user = auth.currentUser;
    if (user != null) {
      _appointmentData = await userService.getAppointmentData(user.uid);
      if (_appointmentData != null) {
        _lastDoctorVisitDate = (_appointmentData!['lastVisitDate'] as Timestamp?)?.toDate();
        _nextDoctorVisitDate = (_appointmentData!['nextDoctorVisitDate'] as Timestamp?)?.toDate();
        _nextMRApptDate = (_appointmentData!['nextMRApptDate'] as Timestamp?)?.toDate();
        _nextTestDate = (_appointmentData!['nextTestDate'] as Timestamp?)?.toDate();
        _lastTakenDate = (_appointmentData!['lastTakenDate'] as Timestamp?)?.toDate();
        _isTakingMedicine = _appointmentData!['isTakingMedicine'] ?? false;
        _needsPrescription = _appointmentData!['needsPrescription'] ?? false;
        _dosageFrequency = _appointmentData!['dosageFrequency'] ?? '';
        notifyListeners();
      }
    }
  }

  int get age => _age;
  set age(int value) {
    if (_age != value) {
      _age = value;
      notifyListeners();
    }
  }

  DateTime? get lastDoctorVisitDate => _lastDoctorVisitDate;
  set lastDoctorVisitDate(DateTime? value) {
    if (_lastDoctorVisitDate != value) {
      _lastDoctorVisitDate = value;
      notifyListeners();
    }
  }

  DateTime? get nextDoctorVisitDate => _nextDoctorVisitDate;
  set nextDoctorVisitDate(DateTime? value) {
    _nextDoctorVisitDate = value;
    notifyListeners();
  }

  DateTime? get nextMRApptDate => _nextMRApptDate;
  set nextMRApptDate(DateTime? value) {
    _nextMRApptDate = value;
    notifyListeners();
  }

  DateTime? get nextTestDate => _nextTestDate;
  set nextTestDate(DateTime? value) {
    _nextTestDate = value;
    notifyListeners();
  }

  DateTime? get lastTakenDate => _lastTakenDate;
  set lastTakenDate(DateTime? value) {
    if (_lastTakenDate != value) {
      _lastTakenDate = value;
      notifyListeners();
    }
  }

  bool get isTakingMedicine => _isTakingMedicine;
  void setIsTakingMedicine(bool value) {
    if (_isTakingMedicine != value) {
      _isTakingMedicine = value;
      notifyListeners();
    }
  }

  bool get needsPrescription => _needsPrescription;
  void setNeedsPrescription(bool value) {
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

  void calculateFutureDates() {
    DateTime now = DateTime.now();
    DateTime sixMonthsAgo = now.subtract(const Duration(days: 180));

    if (_lastDoctorVisitDate == null || _lastDoctorVisitDate!.isBefore(sixMonthsAgo)) {
      nextDoctorVisitDate = now.add(const Duration(days: 90));
    } else {
      nextDoctorVisitDate = _lastDoctorVisitDate!.add(const Duration(days: 180));
    }

    nextMRApptDate = nextDoctorVisitDate?.subtract(const Duration(days: 14));
    nextTestDate = nextDoctorVisitDate?.subtract(const Duration(days: 7));
  }

  Future<void> saveOrUpdateUserData(Map<String, dynamic> userData) async {
    User? user = auth.currentUser;
    if (user != null) {
      await userService.saveOrUpdateUserData(user.uid, userData);
      fetchUserData();
    }
  }

  Future<void> updateAppointments() async {
    if (auth.currentUser != null) {
      try {
        await userService.saveAppointmentData(
          userId: auth.currentUser!.uid,
          lastVisitDate: _lastDoctorVisitDate ?? DateTime.now(),
          nextDoctorVisitDate: _nextDoctorVisitDate ?? DateTime.now(),
          nextMRApptDate: _nextMRApptDate ?? DateTime.now(),
          nextTestDate: _nextTestDate ?? DateTime.now(),
          age: _age,
          needsPrescription: _needsPrescription,
          dosageFrequency: _dosageFrequency,
          lastTakenDate: _lastTakenDate,
          isTakingMedicine: _isTakingMedicine,
        );
        fetchAppointmentData(); // Update local data after saving to Firestore
      } catch (e, s) {
        _logger.e('Error updating appointment data: $e', e, s);
      }
    } else {
      _logger.w('User not logged in.');
    }
    notifyListeners();
  }

  Future<void> logOut() async {
    try {
      await userService.logOut();
    } catch (e) {
      _logger.e('Error logging out: $e');
    }
  }
}
