import 'package:flutter/material.dart';
import 'package:ms_app/views/screens/home_page.dart';
import 'package:ms_app/views/screens/notification_screen.dart'; // Bildirim ekranını ekleyin
import 'package:ms_app/views/screens/profile_page.dart';
import 'package:ms_app/views/theme/theme_data.dart';

class HealthBottomAppBar extends StatelessWidget {
  const HealthBottomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    buildThemeData(); // Use the buildThemeData method to get the theme data

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 6.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationScreen()), // Bildirim ekranına yönlendir
              );
            },
          ),
        
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
        ],
      ),
    );
  }

 
}
