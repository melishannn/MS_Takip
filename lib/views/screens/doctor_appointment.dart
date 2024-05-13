import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // DateFormat için
import 'package:ms_app/viewmodels/profile_view_model.dart';
import 'package:ms_app/views/widgets/bottom_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class DoctorAppointment extends StatefulWidget {
  const DoctorAppointment({Key? key}) : super(key: key);

  @override
  DoctorAppointmentState createState() => DoctorAppointmentState();
}

class DoctorAppointmentState extends State<DoctorAppointment> {
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
  }

  String formatDate(DateTime? date) {
    return date != null ? DateFormat('d MMMM yyyy', 'tr_TR').format(date) : 'Tarih Belirtilmemiş';
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Doctor Randevu Takvimi')),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            onPageChanged: (focusedDay) => setState(() => _focusedDay = focusedDay),
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
          ),
          // Randevuları listele
          Expanded(
            child: ListView(
              children: [
               if (viewModel.nextDoctorVisitDate != null)
                  ListTile(title: Text('Tahmini Sonraki Doktor Randevusu: ${formatDate(viewModel.nextDoctorVisitDate)}')),
                if (viewModel.nextMRApptDate != null)
                  ListTile(title: Text('Tahmini Sonraki MR Randevusu: ${formatDate(viewModel.nextMRApptDate)}')),
                if (viewModel.nextTestDate != null)
                  ListTile(title: Text('Tahmini Sonraki Tahliler : ${formatDate(viewModel.nextTestDate)}')),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const HealthBottomAppBar(),
    );
  }
}
