import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart'; // DateFormat için gerekli import
import 'package:ms_app/firebase_options.dart';
import 'package:ms_app/services/user_service.dart';
import 'package:ms_app/viewmodels/profile_view_model.dart';
import 'package:ms_app/views/screens/home_page.dart';
import 'package:ms_app/views/screens/login.dart';
import 'package:ms_app/views/theme/theme_data.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting('tr_TR', null); // Tarih formatlamasını başlat
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        ChangeNotifierProvider<ProfileViewModel>(
          create: (context) => ProfileViewModel(
            Provider.of<FirebaseAuth>(context, listen: false),
            Provider.of<UserService>(context, listen: false),
          ),
        ),
      ],
      child: MaterialApp(
        theme: buildThemeData(),
        home: const LoginPage(),
        routes: {
          '/login': (context) => const LoginPage(),
          '/home': (context) => const HomePage(),
        },
      ),
    );
  }
}
