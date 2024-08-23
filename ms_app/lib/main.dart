import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ms_app/firebase_options.dart';
import 'package:ms_app/services/auth_service.dart';
import 'package:ms_app/services/medicine_appointment_service.dart';
import 'package:ms_app/services/notification_service.dart';
import 'package:ms_app/services/user_service.dart';
import 'package:ms_app/viewmodels/home_view_model.dart';
import 'package:ms_app/viewmodels/medicine_appointment_view_model.dart';
import 'package:ms_app/viewmodels/profile_view_model.dart';
import 'package:ms_app/views/screens/home_page.dart';
import 'package:ms_app/views/screens/login.dart';
import 'package:ms_app/views/screens/medicine_appointment.dart';
import 'package:ms_app/views/theme/theme_data.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting('tr_TR', null);
  tz.initializeTimeZones();

  final NotificationService notificationService = NotificationService();
  await notificationService.init();

  runApp(MyApp(notificationService: notificationService));
}

class MyApp extends StatelessWidget {
  final NotificationService notificationService;

  const MyApp({Key? key, required this.notificationService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuth>(
          create: (_) => FirebaseAuth.instance,
        ),
        Provider<UserService>(
          create: (_) => UserService(),
        ),
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        Provider<MedicineAppointmentService>(
          create: (_) => MedicineAppointmentService(),
        ),
        Provider<NotificationService>(
          create: (_) => notificationService,
        ),
        ChangeNotifierProvider<HomeViewModel>(
          create: (context) => HomeViewModel(),
        ),
        ChangeNotifierProvider<ProfileViewModel>(
          create: (context) => ProfileViewModel(
            Provider.of<FirebaseAuth>(context, listen: false),
            Provider.of<UserService>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider<MedicineAppointmentViewModel>(
          create: (context) => MedicineAppointmentViewModel(
            Provider.of<FirebaseAuth>(context, listen: false),
            Provider.of<MedicineAppointmentService>(context, listen: false),
          ),
        ),
      ],
      child: MaterialApp(
        theme: buildThemeData(),
        home: const LoginPage(),
        routes: {
          '/login': (context) => const LoginPage(),
          '/home': (context) => const HomePage(),
          '/medicine_appointment': (context) => const MedicineAppointment(),
          
        },
      ),
    );
  }
}
