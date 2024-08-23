import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:ms_app/viewmodels/home_view_model.dart';
import 'package:ms_app/views/screens/doctor_appointment.dart';
import 'package:ms_app/views/widgets/bottom_app_bar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    homeViewModel.fetchUserName();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
      title: FutureBuilder<String>(
        future: Provider.of<HomeViewModel>(context, listen: false).fetchUserName(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
          } else {
          return Text('Hoş Geldiniz ${snapshot.data}');
          }
        }
        },
      ),
      backgroundColor: colorScheme.primary,
      ),
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
                    aspectRatio: 3,
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
        transitionType: ContainerTransitionType.fadeThrough,
        transitionDuration: const Duration(milliseconds: 500),
        openBuilder: (BuildContext context, VoidCallback _) {
          return page;
        },
        closedElevation: 6.0,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        closedColor: color,
        closedBuilder: (BuildContext context, VoidCallback openContainer) {
          return SizedBox(
            width: double.infinity,
            height: 150.0,
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
