import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // DateFormat için
import 'package:ms_app/viewmodels/medicine_appointment_view_model.dart';
import 'package:ms_app/views/widgets/bottom_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class MedicineAppointment extends StatefulWidget {
  const MedicineAppointment({Key? key}) : super(key: key);

  @override
  MedicineAppointmentState createState() => MedicineAppointmentState();
}

class MedicineAppointmentState extends State<MedicineAppointment> {
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();

    // İlaç randevularını fetch et
    final viewModel = Provider.of<MedicineAppointmentViewModel>(context, listen: false);
    viewModel.fetchMedicineAppointments();
  }

  String formatDate(DateTime? date) {
    return date != null ? DateFormat('d MMMM yyyy', 'tr_TR').format(date) : 'Tarih Belirtilmemiş';
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MedicineAppointmentViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicine Appointment'),
      ),
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
          Expanded(
            child: ListView(
              children: viewModel.appointments.map((appointment) {
                return ListTile(
                  title: Text('İlaç Randevusu: ${formatDate(appointment.appointmentDate)}'),
                  subtitle: Text('Dozaj Sıklığı: ${appointment.dosageFrequency}'),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const HealthBottomAppBar(),
    );
  }
}
