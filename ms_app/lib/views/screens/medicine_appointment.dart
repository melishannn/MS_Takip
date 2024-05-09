import 'package:flutter/material.dart';
import 'package:ms_app/views/widgets/bottom_app_bar.dart';
import 'package:ms_app/views/widgets/buttons.dart';
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
 void _editAppointment() {
    // Randevu düzenleme işlevi
  }

  void _cancelAppointment() {
    // Randevu iptal etme işlevi
  }
  // Randevu listesi
  List<String> appointments = [
    'İlaç randevusu 1',
    'İlaç randevusu 2',
    'İlaç randevusu 3',
    // İhtiyacınıza göre randevu listesini burada genişletebilirsiniz
  ];

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
        title: const Text('Medicine Appointment'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16), // İzin verilen en erken tarih
            lastDay: DateTime.utc(2030, 3, 14),   // İzin verilen en son tarih
            focusedDay: _focusedDay,              // Şu anda odaklanılan gün
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
                _focusedDay = focusedDay; // Update _focusedDay for TableCalendar
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
                // Burada randevu öğesi widget'ını oluşturun
                return AppointmentItem(appointment: appointment);
              },
            ),
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
      // İsteğe bağlı olarak, randevu öğelerine tıklama işlevselliği ekleyebilirsiniz
      onTap: () {
        // Randevu detaylarına gitmek için bir yönlendirme ekleyin
      },
    );
  }
}
