import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:ms_app/views/screens/doctor_appointment.dart';
import 'package:ms_app/views/screens/medicine_appointment.dart';
import 'package:ms_app/views/widgets/bottom_app_bar.dart';
import 'package:ms_app/views/widgets/top_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // SystemChrome and other settings...

    // Access theme data
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: const TopAppBar(),
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: AspectRatio(
                  aspectRatio: 3 ,
                  child: Column(
                    children: [
                      Expanded(
                        child: _buildCard(
                          icon: Icons.calendar_today,
                          text: 'Doktor, MR, Tahlil',
                          color: colorScheme.primary,
                          context: context,
                          page: const DoctorAppointment(),
                        ),
                      ),
                      const SizedBox(height: 16.0), // Spacing between the cards
                      Expanded(
                        child: _buildCard(
                          icon: Icons.medical_services,
                          text: 'İlaç Randevu Takvimi',
                          color: colorScheme.secondary,
                          context: context,
                          
                          page: const MedicineAppointment(),
                        ),
                      ),
                      const SizedBox(height: 16.0), // Spacing between the cards
                  
                    ],
                  ),
                ),
              ),
            );
          },
        
        ),
        
      ),
       bottomNavigationBar: const HealthBottomAppBar(),
    );
  }


Widget _buildCard({
  required IconData icon,
  required String text,
  required Color color,
  required BuildContext context,
  required Widget page,
}) {
  return Center(
    child: OpenContainer(
      transitionType: ContainerTransitionType.fadeThrough, // Geçiş tipi
      transitionDuration: const Duration(milliseconds: 500), // Geçiş süresi
      openBuilder: (BuildContext context, VoidCallback _) {
        return page; // Geçiş yapılacak sayfa
      },
      closedElevation: 6.0,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      closedColor: color,
      closedBuilder: (BuildContext context, VoidCallback openContainer) {
        return SizedBox(
          width: double.infinity, // Ekran genişliğine göre ayarla
          height: 150.0, // Sabit yükseklik
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: 56.0, color: Colors.white),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}


}
