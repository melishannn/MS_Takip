import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Tarih formatlama için gerekli paket
import 'package:ms_app/notification_scheduler.dart';
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
    final viewModel = Provider.of<ProfileViewModel>(context, listen: false);
    viewModel.fetchUserData().then((_) {
      NotificationScheduler(context).scheduleNotifications(viewModel);
    });
  }

  String formatDate(DateTime? date) {
    return date != null ? DateFormat('d MMMM yyyy', 'tr_TR').format(date) : 'Tarih Belirtilmemiş';
  }

  void _showEventDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Kapat'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Doktor Randevu Takvimi')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLegend('MR', Colors.green),
                _buildLegend('Tahlil', Colors.red),
                _buildLegend('Doktor', Colors.blue),
              ],
            ),
          ),
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

              if (viewModel.nextDoctorVisitDate != null &&
                  isSameDay(selectedDay, viewModel.nextDoctorVisitDate)) {
                _showEventDialog('Doktor Randevusu', 'Bu tarih: Doktor randevusu.');
              } else if (viewModel.nextMRApptDate != null &&
                  isSameDay(selectedDay, viewModel.nextMRApptDate)) {
                _showEventDialog('MR Randevusu', 'Bu tarih: MR randevusu.');
              } else if (viewModel.nextTestDate != null &&
                  isSameDay(selectedDay, viewModel.nextTestDate)) {
                _showEventDialog('Tahlil Randevusu', 'Bu tarih: Tahlil randevusu.');
              }
            },
            eventLoader: (day) {
              List<DateTime?> dates = [
                viewModel.nextDoctorVisitDate,
                viewModel.nextMRApptDate,
                viewModel.nextTestDate
              ];
              return dates.where((date) => isSameDay(date, day)).toList();
            },
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                if (events.isNotEmpty) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: events.map((event) {
                      Color markerColor;
                      if (event == viewModel.nextDoctorVisitDate) {
                        markerColor = Colors.blue;
                      } else if (event == viewModel.nextMRApptDate) {
                        markerColor = Colors.green;
                      } else if (event == viewModel.nextTestDate) {
                        markerColor = Colors.red;
                      } else {
                        markerColor = Colors.grey;
                      }
                      return Container(
                        width: 10,
                        height: 10,
                        margin: const EdgeInsets.symmetric(horizontal: 1.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: markerColor,
                        ),
                      );
                    }).toList(),
                  );
                }
                return null;
              },
              defaultBuilder: (context, date, _) {
                Color? bgColor;
                if (viewModel.nextMRApptDate != null && viewModel.nextTestDate != null && viewModel.nextDoctorVisitDate != null) {
                  if (date.isAfter(viewModel.nextMRApptDate!.subtract(const Duration(days: 1))) && date.isBefore(viewModel.nextTestDate!)) {
                    bgColor = Colors.green.withOpacity(0.3);
                  } else if (date.isAfter(viewModel.nextTestDate!.subtract(const Duration(days: 1))) && date.isBefore(viewModel.nextDoctorVisitDate!)) {
                    bgColor = Colors.red.withOpacity(0.3);
                  } else if (isSameDay(date, viewModel.nextDoctorVisitDate)) {
                    bgColor = Colors.blue.withOpacity(0.3);
                  }
                }

                return Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: bgColor,
                  ),
                  child: Center(
                    child: Text(
                      '${date.day}',
                      style: const TextStyle().copyWith(fontSize: 16.0),
                    ),
                  ),
                );
              },
            ),
            locale: 'tr_TR', // Turkish locale
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              leftChevronIcon: Icon(Icons.chevron_left),
              rightChevronIcon: Icon(Icons.chevron_right),
              titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              selectedTextStyle: const TextStyle(color: Colors.white),
              selectedDecoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
              defaultTextStyle: const TextStyle(fontSize: 14),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                if (viewModel.nextDoctorVisitDate != null)
                  ListTile(title: Text('Tahmini Sonraki Doktor Randevusu: ${formatDate(viewModel.nextDoctorVisitDate)}')),
                if (viewModel.nextMRApptDate != null)
                  ListTile(title: Text('Tahmini Sonraki MR Randevusu: ${formatDate(viewModel.nextMRApptDate)}')),
                if (viewModel.nextTestDate != null)
                  ListTile(title: Text('Tahmini Sonraki Tahliler: ${formatDate(viewModel.nextTestDate)}')),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 4,
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Rutin kontrollerde MR çekimi doktor randevusundan en fazla 2 hafta önce çekilmiş olmalıdır.',
                            style: TextStyle(fontSize: 14, color: Colors.black87),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Card(
                        elevation: 4,
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Tahliller için doktorun veya hemşirenin istediği tahliller doktor randevusuna yakın tarihlerde yapılmalıdır.',
                            style: TextStyle(fontSize: 14, color: Colors.black87),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const HealthBottomAppBar(),
    );
  }

  Widget _buildLegend(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 4),
        Text(label),
      ],
    );
  }
}
