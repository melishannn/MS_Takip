import 'package:flutter/material.dart';
import 'package:ms_app/views/widgets/bottom_app_bar.dart';
import 'package:ms_app/views/widgets/buttons.dart';
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
 void _editAppointment() {
    // Randevu düzenleme işlevi
  }

  void _cancelAppointment() {
    // Randevu iptal etme işlevi
  }
  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Appointment'),
      ),
      body: Stack( // Use Stack for layering
        children: [
          Column(
            children: [
               TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
              ),
            Buttons(
          onEditPressed: _editAppointment,
          onCancelPressed: _cancelAppointment,
        ),
              Expanded(
                child: ListView.builder(
                  itemCount: appointments.length,
                  itemBuilder: (context, index) {
                    final appointment = appointments[index];
                    return AppointmentItem(appointment: appointment);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
       bottomNavigationBar: const HealthBottomAppBar(),
    );
  }
}

class AppointmentItem extends StatelessWidget {
  final String appointment;

  const AppointmentItem({required this.appointment, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(appointment),
      onTap: () {
        // Add navigation to appointment details
      },
    );
  }
}

List<String> appointments = [
  'Doktor Randevusu 1',
  'Doktor Randevusu 2',
  'MR Randevusu 1',
  'MR Randevusu 2',
  'Tahlil Randevusu 1',
  'Tahlil Randevusu 2',
];
