import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:ms_app/services/user_service.dart';
import 'package:ms_app/viewmodals/profile_view_model.dart';
import 'package:ms_app/views/widgets/top_app_bar.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final UserService userService = UserService();
  //firebase işlemleri başka bir sayfada yapılacak
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  var logger = Logger();

  late int _age = 0; // Yaş bilgisini saklamak için değişken eklendi
  late final DateTime _lastDoctorVisitDate = DateTime.now();
  bool _isTakingMedicine = false;
  bool _needsPrescription = false;
  String _dosageFrequency = '';
  DateTime? _lastTakenDate;

  // Çıkış yapma işlevi
  Future<void> _logOut() async {
    try {
      await _auth.signOut();
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    } catch (e) {
      logger.e('Hata çıkış yapılırken: $e');
    }
  }

  Future<void> saveDoctorVisitDate() async {
  try {
    await firestore.collection('doctorVisits').add({
      'userId': _auth.currentUser?.uid,
      'lastVisitDate': _lastDoctorVisitDate,
      'age': _age,
      'needsPrescription': _needsPrescription,
      'dosageFrequency': _dosageFrequency,
      'lastTakenDate': _lastTakenDate,
      'isTakingMedicine': _isTakingMedicine
    });
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Randevu bilgileri kaydedildi'))
      );
    }
  } catch (e) {
    logger.e('Hata doktor ziyaret tarihini kaydederken: $e');
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Randevu bilgileri kaydedilemedi'))
      );
    }
  }
}


  Future<void> _showAgeDialog(BuildContext context) async {
    TextEditingController ageController = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Yaşınızı Girin'),
          content: TextField(
            controller: ageController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Yaş'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                final age = int.tryParse(ageController.text) ?? 0;
                setState(() => _age = age);
                Navigator.of(context).pop();
              },
              child: const Text('Tamam'),
            ),
          ],
        );
      },
    );
  }


  Future<void> _selectDoctorVisitDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: userService.lastDoctorVisit,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != userService.lastDoctorVisit) {
      userService.updateDoctorVisitDate(picked);
    }
  }


  Future<void> _selectLastTakenDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _lastTakenDate = picked);
    }
  }

  Future<void> _selectDosageFrequency(BuildContext context) async {
    final String? dosage = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('İlaç Dozaj Sıklığı'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(title: const Text('Günlük'), onTap: () => Navigator.pop(context, 'Günlük')),
              ListTile(title: const Text('Haftalık'), onTap: () => Navigator.pop(context, 'Haftalık')),
              ListTile(title: const Text('Aylık'), onTap: () => Navigator.pop(context, 'Aylık')),
            ],
          ),
        );
      },
    );
    if (dosage != null) {
      setState(() => _dosageFrequency = dosage);
    }
  }

  @override
  Widget build(BuildContext context) {
   final viewModel = Provider.of<ProfileViewModel>(context);

    return Scaffold(
      appBar: const TopAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                title: const Text('Yaş Bilgisi'),
                subtitle: Text(_age > 0 ? 'Yaşınız: $_age' : 'Yaşınızı girin'),
                onTap: () => _showAgeDialog(context),
                tileColor: Colors.blueGrey[50],
              ),
              SwitchListTile(
                title: const Text('İlaç Kullanıyor musunuz?'),
                value: _isTakingMedicine,
                onChanged: (bool value) => setState(() => _isTakingMedicine = value),
                activeColor: Colors.green,
                inactiveThumbColor: Colors.grey,
              ),
              if (_isTakingMedicine) ...[
                SwitchListTile(
                  title: const Text('Hastaneden mi almanız gerekiyor?'),
                  value: _needsPrescription,
                  onChanged: (bool value) => setState(() => _needsPrescription = value),
                  activeColor: Colors.red,
                  inactiveThumbColor: Colors.grey,
                ),
                if (_needsPrescription) ...[
                  ListTile(
                    title: const Text('İlaç Dozaj Sıklığı'),
                    subtitle: Text(_dosageFrequency.isNotEmpty ? _dosageFrequency : 'Seçim Yapılmadı'),
                    onTap: () => _selectDosageFrequency(context),
                    tileColor: Colors.blueGrey[50],
                  ),
                  ListTile(
                    title: const Text('Son Alınan Tarih'),
                    subtitle: Text(_lastTakenDate != null
                        ? '${_lastTakenDate!.day}/${_lastTakenDate!.month}/${_lastTakenDate!.year}'
                        : 'Tarih seçilmedi'),
                    onTap: () => _selectLastTakenDate(context),
                    tileColor: Colors.blueGrey[50],
                  ),
                ],
              ],
              ListTile(
                title: const Text('En Son Doktora Gittiğiniz Tarih'),
                subtitle: Text('${_lastDoctorVisitDate.day}/${_lastDoctorVisitDate.month}/${_lastDoctorVisitDate.year}'),
                onTap: () => _selectDoctorVisitDate(context),
                tileColor: Colors.blueGrey[50],
              ),
               ElevatedButton(
            onPressed: () {
              // Kullanıcı girdilerini ViewModel'e ayarlayın ve verileri kaydedin
              viewModel.updateUserData();
            },
            child: const Text('Save Data'),
          ),
              ElevatedButton(
                onPressed: _logOut,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Çıkış Yap'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}