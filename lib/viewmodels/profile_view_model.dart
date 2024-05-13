// kullanıcı tarafından girilen bilgileri alacak ve
// UserService
// aracılığıyla bu bilgileri Firebase Firestore'a kaydedecek bir ViewModel oluşturacağız.
// lib/viewmodels/profile_view_model.dart
// lib/viewmodels/profile_view_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:ms_app/services/user_service.dart';
import 'package:provider/provider.dart';

class ProfileViewModel with ChangeNotifier {
  final FirebaseAuth auth;
  final UserService userService;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final Logger _logger = Logger();
  DateTime _lastDoctorVisitDate = DateTime.now();
  DateTime? _nextDoctorVisitDate;
  DateTime? _nextMRApptDate;
  DateTime? _nextTestDate;
  DateTime? lastTakenDate;
  DateTime? lastTakenDoctorDate;
  bool _isTakingMedicine = false;
  bool _needsPrescription = false;
  bool isFirstTime = true; //kullanıcı ilk kez bilgileri girmişse
  String _dosageFrequency = '';
  int _age = 0;

  //kullanıcı verilerinin tutulması için değerler
 Map<String, dynamic>? _userData;
  bool _hasUserData = false;

  bool get hasUserData => _hasUserData;
  Map<String, dynamic>? get userData => _userData;
  
//verileri çekmek için
  Future<void> fetchAndSetUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot doc = await _db.collection('users').doc(user.uid).get();
      if (doc.exists) {
        _userData = doc.data() as Map<String, dynamic>?;
        _hasUserData = true;
      } else {
        _hasUserData = false;
      }
      notifyListeners();
    }
  }
//verileri çekmek için 
 Future<void> saveOrUpdateUserData(Map<String, dynamic> userData) async {
  try {
    if (hasUserData) {
      // Firestore'da güncelleme işlemi
      await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .update(userData);
      _logger.i('User data updated successfully');
    } else {
      // Firestore'da yeni bir doküman oluşturma
      await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .set(userData);
      _logger.i('User data saved successfully');
    }
  } catch (e) {
    _logger.e('Error saving or updating user data: $e');
  }
}

 

  ProfileViewModel(this.auth,this.userService);

//get set methodları tanımlandı değişkenlerdeki sıraya göre düzenle
//medicine silindi orada başka bir algoritma kur 
//günlük ise her gün hatırlatma olsun
//haftalık ise 6 gün sonraya randevu olsun
//yıllık ise 5 ay sonra randevu ver
   int get age => _age;
  set age(int value) {
    if (_age != value) {
      _age = value;
      _logger.d('Age updated to: $value');
      notifyListeners();
    }
  }
  
DateTime? get nextDoctorVisitDate => _nextDoctorVisitDate;
  set nextDoctorVisitDate(DateTime? date) {
    _nextDoctorVisitDate = date;
    notifyListeners();
  }

  DateTime? get nextMRApptDate => _nextMRApptDate;
  set nextMRApptDate(DateTime? date) {
    _nextMRApptDate = date;
    notifyListeners();
  }

  DateTime? get nextTestDate => _nextTestDate;
  set nextTestDate(DateTime? date) {
    _nextTestDate = date;
    notifyListeners();
  }

   // lastDoctorVisitDate için getter
  DateTime get lastDoctorVisitDate => _lastDoctorVisitDate;
  // lastDoctorVisitDate için setter
  set lastDoctorVisitDate(DateTime value) {
    if (_lastDoctorVisitDate != value) {
      _lastDoctorVisitDate = value;
      notifyListeners();  // UI'ın güncellenmesini tetikler
    }
  }


  bool get isTakingMedicine => _isTakingMedicine;
 void setIsTakingMedicine(bool value) {
    if (_isTakingMedicine != value) {
      _isTakingMedicine = value;
      notifyListeners();  // UI'ı güncellemek için dinleyicileri bilgilendir
      _logger.d('Is Taking Medicine updated to: $value');
    }
  }

  bool get needsPrescription => _needsPrescription;
 void setneedsPrescription(bool value) {
    if (_needsPrescription != value) {
      _needsPrescription = value;
      notifyListeners();  // UI'ı güncellemek için dinleyicileri bilgilendir
      _logger.d('Is Taking Medicine updated to: $value');
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
  DateTime sixMonthsAgo = now.subtract(const Duration(days: 180)); // 6 months ago

  // Eğer son doktor ziyaret tarihi şu andan 6 ay önceyse, güncel tarihten 3 ay sonrasına randevu ver
  if (_lastDoctorVisitDate.isBefore(sixMonthsAgo)) {
    nextDoctorVisitDate = now.add(const Duration(days: 90)); // 3 months later from now
  } else {
    // Normal koşullarda son ziyaret tarihinden 6 ay sonrasına randevu ver
    nextDoctorVisitDate = _lastDoctorVisitDate.add(const Duration(days: 180)); // 6 months later
  }

  // MR ve test tarihlerini hesapla
  nextMRApptDate = nextDoctorVisitDate?.subtract(const Duration(days: 14)); // 2 weeks before the next doctor visit
  nextTestDate = nextDoctorVisitDate?.subtract(const Duration(days: 7)); // 1 week before the next doctor visit
}
//hatırlatmalar ve alert mesajları yapılacak
//acil atak durumlarında ne yapılacak hemşire cep numarası açılacak.
//randevu getir
  


 Future<void> updateAppointments() async {
  if (auth.currentUser != null) {
    try {
      // Değişken değerlerini logla
      _logger.d('UserID: ${auth.currentUser!.uid}');
      _logger.d('Last Visit Date: $_lastDoctorVisitDate');
      _logger.d('Next Doctor Visit Date: $nextDoctorVisitDate');
      _logger.d('Next MR Appointment Date: $nextMRApptDate');
      _logger.d('Next Test Date: $nextTestDate');
      _logger.d('Age: $_age');
      _logger.d('Needs Prescription: $_needsPrescription');
      _logger.d('Dosage Frequency: $_dosageFrequency');
      _logger.d('Last Taken Date: $lastTakenDate');
      _logger.d('Is Taking Medicine: $_isTakingMedicine');

      await userService.saveAppointmentData(
        userId: auth.currentUser!.uid,
        lastVisitDate: _lastDoctorVisitDate,
        nextDoctorVisitDate: nextDoctorVisitDate!,
        nextMRApptDate: nextMRApptDate!,
        nextTestDate: nextTestDate!,
        age: _age,
        needsPrescription: _needsPrescription,
        dosageFrequency: _dosageFrequency,
        lastTakenDate: lastTakenDate,
        isTakingMedicine: _isTakingMedicine
      );
      _logger.i('Appointment data updated successfully');
       isFirstTime = false;
    } catch (e, s) {
      _logger.e('Error updating appointment data: $e', e, s);
    }
  } else {
    _logger.w('User not logged in.');
  }
  notifyListeners();
}


// ProfilePage sınıfı içindeki bir metot olarak tanımla
Future<void> selectLastDoctorVisitDate(BuildContext context) async {
  // BuildContext'i bir değişkene ata
  final localContext = context;
  final viewModel = Provider.of<ProfileViewModel>(localContext, listen: false);

  final DateTime? pickedDate = await showDatePicker(
    context: localContext,
    initialDate: DateTime.now(), // Başlangıç tarihi bugün
    firstDate: DateTime(2000), // En eski seçilebilecek tarih
    lastDate: DateTime.now(), // En son seçilebilecek tarih
  );

  if (pickedDate != null) {
    // ViewModel'e erişim sağla
    viewModel.lastDoctorVisitDate = pickedDate;
  }
}

  Future<void> logOut() async {
    try {
      await userService.logOut();
      _logger.i('User logged out successfully');
    } catch (e) {
      _logger.e('Error logging out: $e');
    }
  }

}

