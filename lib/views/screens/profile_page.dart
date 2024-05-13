//ui sayfasından provider aracılığıyla veriler profile_view_modal'a yollanıyor
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:ms_app/services/user_service.dart';
import 'package:ms_app/viewmodels/profile_view_model.dart';
import 'package:ms_app/views/widgets/top_app_bar.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> 
{
   final UserService _userService = UserService();
    late ProfileViewModel viewModel;
  //firebase işlemleri başka bir sayfada yapılacak
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var logger = Logger();
  final bool _isTakingMedicine = false;
  final bool _needsPrescription = false;
  final String _dosageFrequency = '';
  DateTime? _lastTakenDate;
  
  //Yaş bilgisi
 Future<void> _showAgeDialog(BuildContext context) async {
  final viewModel = Provider.of<ProfileViewModel>(context, listen: false);
  TextEditingController ageController = TextEditingController(
    text: viewModel.userData != null && viewModel.userData!['age'] != null 
        ? viewModel.userData!['age'].toString() 
        : ''
  );

  await showDialog<void>(
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
              viewModel.saveOrUpdateUserData({'age': age});
              Navigator.of(context).pop();
            },
            child: const Text('Tamam'),
          ),
        ],
      );
    },
  );
}
 
  //ilaç dozaj
 Future<void> selectDosageFrequency(BuildContext context) async {
   final viewModel = Provider.of<ProfileViewModel>(context, listen: false);
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
    // ViewModel'e erişim sağla ve değeri güncelle
    viewModel.dosageFrequency = dosage;
  }
}
 
   //bu ekranda gözüküyor
 Future<void> _selectLastTakenDate(BuildContext context) async {
    final viewModel = Provider.of<ProfileViewModel>(context, listen: false);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && mounted) {
      viewModel.lastTakenDate = picked;
    }
  }
 
  Future<void> selectLastDoctorVisitDate(BuildContext context) async {
    final viewModel = Provider.of<ProfileViewModel>(context, listen: false);
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Başlangıç tarihi bugün
      firstDate: DateTime(2000), // En eski seçilebilecek tarih
      lastDate: DateTime.now(), // En son seçilebilecek tarih
    );

    if (pickedDate != null && mounted) {
      viewModel.lastDoctorVisitDate = pickedDate;
      viewModel.calculateFutureDates(); 
    }
  }

 void saveDoctorVisitDate() async {
  try {
    final viewModel = Provider.of<ProfileViewModel>(context, listen: false);

    // Tarihlerin null olup olmadığını kontrol et
    if (viewModel.nextDoctorVisitDate != null && viewModel.nextMRApptDate != null && viewModel.nextTestDate != null) {
      await _userService.saveAppointmentData(
        userId: _auth.currentUser!.uid,
        lastVisitDate: viewModel.lastDoctorVisitDate,
        nextDoctorVisitDate: viewModel.nextDoctorVisitDate!,
        nextMRApptDate: viewModel.nextMRApptDate!,
        nextTestDate: viewModel.nextTestDate!,
        age: viewModel.age,
        needsPrescription: viewModel.needsPrescription,
        dosageFrequency: viewModel.dosageFrequency,
        lastTakenDate: viewModel.lastTakenDate,
        isTakingMedicine: viewModel.isTakingMedicine
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Randevu bilgileri kaydedildi'))
        );
      }
    } else {
      // Gerekli tarihler mevcut değilse hata göster
      logger.e('Tarih bilgileri eksik');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tarih bilgileri eksik, işlem yapılamadı'))
        );
      }
    }
  } catch (e) 
    _logger.e('Hata doktor ziyaret tarihini kaydederken: $e');
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Randevu bilgileri kaydedilemedi'))
      );
    }
  } 

  // Çıkış yapma işlevi
 void _logOut() async {
    try {
      await _userService.logOut();
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    } catch (e) {
       logger.e('Hata çıkış yapılırken: $e');

    }
  }

   @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileViewModel>(context, listen: false);

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
              subtitle: Text(
            viewModel.userData != null && viewModel.userData!['age'] != null 
              ? 'Yaşınız: ${viewModel.userData!['age']}' 
              : 'Yaşınızı girin'
                 ),                
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
                  activeColor: Colors.green,
                ),
                if (_needsPrescription) ...[
                  ListTile(
                    title: const Text('İlaç Dozaj Sıklığı'),
                    subtitle: Text(_dosageFrequency.isNotEmpty ? _dosageFrequency : 'Seçim Yapılmadı'),
                    onTap: () => selectDosageFrequency(context),
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
            title: Text('En Son Doktora Gittiğiniz Tarih: ${viewModel.lastDoctorVisitDate.toLocal()}'),
            subtitle: const Text('Tarih Seçilmedi'),
            onTap: () => selectLastDoctorVisitDate(context),
            tileColor: Colors.blueGrey[50],
          ),
               ElevatedButton(
                  onPressed: () => viewModel.updateAppointments(),
                  child: const Text('Bilgileri Kaydet'),
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


 
