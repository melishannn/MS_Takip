import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ms_app/views/widgets/bottom_app_bar.dart';
import 'package:ms_app/views/widgets/top_app_bar.dart';

class Doctor {
  final String name;
  final String specialty;
  final String city;

  Doctor({required this.name, required this.specialty, required this.city});
}

class DoctorListPage extends StatefulWidget {
  const DoctorListPage({Key? key}) : super(key: key);

  @override
  DoctorListPageState createState() => DoctorListPageState();
}

class DoctorListPageState extends State<DoctorListPage> {
  late Future<Map<String, List<Doctor>>> doctorsBySpecialty;

  @override
  void initState() {
    super.initState();
    doctorsBySpecialty = loadDoctorsGroupedBySpecialty();
  }

  Future<Map<String, List<Doctor>>> loadDoctorsGroupedBySpecialty() async {
    final bytes = await rootBundle.load('assets/doctors.xlsx');
    final buffer = bytes.buffer;
    var excel = Excel.decodeBytes(buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
    Map<String, List<Doctor>> doctorsBySpecialty = {};

    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        var name = (row[0]?.value ?? '').toString();
        var specialty = (row[1]?.value ?? '').toString();
        var city = (row[2]?.value ?? '').toString();

        if (!doctorsBySpecialty.containsKey(specialty)) {
          doctorsBySpecialty[specialty] = [];
        }
        doctorsBySpecialty[specialty]!.add(Doctor(name: name, specialty: specialty, city: city));
      }
    }
    return doctorsBySpecialty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopAppBar(), 
      body: FutureBuilder<Map<String, List<Doctor>>>(
        future: doctorsBySpecialty,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata oluştu: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Doktor bulunamadı.'));
          }

          final doctorsBySpecialty = snapshot.data!;
          return ListView(
            children: doctorsBySpecialty.entries.map((entry) {
              return ExpansionTile(
                title: Text(entry.key),
                children: entry.value.map((doctor) {
                  return ListTile(
                    title: Text(doctor.name),
                    subtitle: Text(doctor.city),
                    
                  );
                }).toList(),
              );
            }).toList(),
          );
        },
      ),
      bottomNavigationBar: const HealthBottomAppBar(), // BottomAppBar widget'ınızı ekleyin

    );
  }
}
