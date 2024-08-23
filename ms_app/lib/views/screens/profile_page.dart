import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:ms_app/services/auth_service.dart';
import 'package:ms_app/services/user_service.dart';
import 'package:ms_app/viewmodels/profile_view_model.dart';
import 'package:ms_app/views/screens/home_page.dart'; // HomePage import
import 'package:ms_app/views/widgets/buttons.dart';
import 'package:ms_app/views/widgets/top_app_bar.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final UserService _userService = UserService();
  final AuthService _authService = AuthService();
  late ProfileViewModel viewModel;
  var logger = Logger();

  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<ProfileViewModel>(context, listen: false);
    viewModel.fetchUserData();
    viewModel.fetchAppointmentData(); // Appointment verilerini de getir
  }

  void _checkLastDoctorVisit() {
    final viewModel = Provider.of<ProfileViewModel>(context, listen: false);
    final DateTime? lastDoctorVisit = viewModel.lastDoctorVisitDate;
    if (lastDoctorVisit != null && DateTime.now().difference(lastDoctorVisit).inDays > 365) {
      _showWarningMessage();
    } else {
      _showProfileUpdatedMessage();
    }
  }

  void _showWarningMessage() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Uyarı'),
        content: const Text('En son doktora gittiğiniz tarih bir yıldan daha eski. Lütfen randevularınıza daha erken gitmeye özen gösterin.En yakın tarihe randevular oluşturulmuştur.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }

  void _showProfileUpdatedMessage() {
    Fluttertoast.showToast(
      msg: 'Profil bilgileri güncellendi',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );
  }

  Future<void> _showAgeDialog(BuildContext context) async {
    final viewModel = Provider.of<ProfileViewModel>(context, listen: false);
    TextEditingController ageController = TextEditingController(
      text: viewModel.userData != null && viewModel.userData!['age'] != null
          ? viewModel.userData!['age'].toString()
          : ''
    );
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.scale,
      title: 'Yaşınızı Girin',
      body: Column(
        children: [
          TextField(
            controller: ageController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Yaş'),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('İptal'),
              ),
              TextButton(
                onPressed: () {
                  final age = int.tryParse(ageController.text);
                  if (age != null) {
                    viewModel.age = age;
                    viewModel.saveOrUpdateUserData({'age': age});
                  }
                  Navigator.of(context).pop();
                },
                child: const Text('Tamam'),
              ),
            ],
          ),
        ],
      ),
    ).show();
  }

  Future<void> selectDosageFrequency(BuildContext context) async {
    final viewModel = Provider.of<ProfileViewModel>(context, listen: false);
    final String? dosage = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('İlaç Dozaj Sıklığı', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ListTile(title: const Text('Günlük'), onTap: () => Navigator.pop(context, 'Günlük')),
                ListTile(title: const Text('Haftalık'), onTap: () => Navigator.pop(context, 'Haftalık')),
                ListTile(title: const Text('Aylık'), onTap: () => Navigator.pop(context, 'Aylık')),
              ],
            ),
          ),
        );
      },
    );
//
    if (dosage != null) {
      viewModel.dosageFrequency = dosage;
      await viewModel.saveOrUpdateUserData({'dosageFrequency': dosage});
    }
  }

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
      viewModel.saveOrUpdateUserData({'lastTakenDate': picked});
    }
  }

  Future<void> selectLastDoctorVisitDate(BuildContext context) async {
    final viewModel = Provider.of<ProfileViewModel>(context, listen: false);
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && mounted) {
      viewModel.lastDoctorVisitDate = pickedDate;
      viewModel.calculateFutureDates();
      viewModel.saveOrUpdateUserData({'lastVisitDate': pickedDate});
    }
  }

  void saveDoctorVisitDate() async {
    try {
      final viewModel = Provider.of<ProfileViewModel>(context, listen: false);
      if (viewModel.nextDoctorVisitDate != null && viewModel.nextMRApptDate != null && viewModel.nextTestDate != null) {
        await _userService.saveAppointmentData(
          userId: viewModel.auth.currentUser!.uid,
          lastVisitDate: viewModel.lastDoctorVisitDate ?? DateTime.now(),
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
          _checkLastDoctorVisit();
        }
      } else {
        logger.e('Tarih bilgileri eksik');
        if (mounted) {
          Fluttertoast.showToast(msg: 'Tarih bilgileri eksik, işlem yapılamadı', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER);
        }
      }
    }
    catch (e) {
      logger.e('Hata doktor ziyaret tarihini kaydederken: $e');
      if (mounted) {
        Fluttertoast.showToast(msg: 'Randevu bilgileri kaydedilemedi', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER);
      }
    }
  }

  void _logOut() async {
    try {
      await _authService.logOut();
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false);
      }
    } catch (e) {
      logger.e('Hata çıkış yapılırken: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileViewModel>(context);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        return false;
      },
      child: Scaffold(
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
                  title: const Text('İlaç Kullanıyor musunuz?', style: TextStyle(color: Colors.black87)),
                  value: viewModel.isTakingMedicine,
                  onChanged: (bool value) {
                    viewModel.setIsTakingMedicine(value);
                    viewModel.saveOrUpdateUserData({'isTakingMedicine': value});
                  },
                  activeColor: Colors.green,
                  inactiveThumbColor: Colors.grey,
                  activeTrackColor: Colors.greenAccent,
                  inactiveTrackColor: Colors.grey[300],
                ),
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 300),
                  firstChild: const SizedBox.shrink(),
                  secondChild: Column(
                    children: [
                      SwitchListTile(
                        title: const Text('Hastaneden mi almanız gerekiyor?', style: TextStyle(color: Colors.black87)),
                        value: viewModel.needsPrescription,
                        onChanged: (bool value) {
                          viewModel.setNeedsPrescription(value);
                          viewModel.saveOrUpdateUserData({'needsPrescription': value});
                        },
                        activeColor: Colors.green,
                        inactiveThumbColor: Colors.grey,
                        activeTrackColor: Colors.greenAccent,
                        inactiveTrackColor: Colors.grey[300],
                      ),
                      Visibility(
                        visible: viewModel.needsPrescription,
                        child: Column(
                          children: [
                            ListTile(
                              title: const Text('İlaç Dozaj Sıklığı', style: TextStyle(color: Colors.black87)),
                              subtitle: Text(
                                viewModel.dosageFrequency.isNotEmpty ? viewModel.dosageFrequency : 'Seçim Yapılmadı',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              onTap: () => selectDosageFrequency(context),
                              tileColor: Colors.blueGrey[100],
                            ),
                            ListTile(
                              title: const Text('Son Alınan Tarih', style: TextStyle(color: Colors.black87)),
                              subtitle: Text(
                                viewModel.lastTakenDate != null
                                    ? '${viewModel.lastTakenDate!.day}/${viewModel.lastTakenDate!.month}/${viewModel.lastTakenDate!.year}'
                                    : 'Tarih seçilmedi',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              onTap: () => _selectLastTakenDate(context),
                              tileColor: Colors.blueGrey[100],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  crossFadeState: viewModel.isTakingMedicine ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                ),
                ListTile(
                  title: const Text('En Son Doktora Gittiğiniz Tarih:', style: TextStyle(color: Colors.black87)),
                  subtitle: Text(
                    viewModel.lastDoctorVisitDate != null
                      ? '${viewModel.lastDoctorVisitDate!.day}/${viewModel.lastDoctorVisitDate!.month}/${viewModel.lastDoctorVisitDate!.year}'
                      : 'Tarih seçilmedi',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  onTap: () => selectLastDoctorVisitDate(context),
                  tileColor: Colors.blueGrey[50],
                ),
                Buttons(
                  onSavePressed: () async {
                    await viewModel.updateAppointments();
                    _checkLastDoctorVisit();
                  },
                  onLogoutPressed: _logOut,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
