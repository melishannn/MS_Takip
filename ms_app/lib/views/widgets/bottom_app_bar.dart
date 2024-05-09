import 'package:flutter/material.dart';
import 'package:ms_app/views/screens/doctor_lists.dart';
import 'package:ms_app/views/screens/profile_page.dart';


class HealthBottomAppBar extends StatelessWidget {
  const HealthBottomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 6.0,
      color: Theme.of(context).colorScheme.background,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround, // Daha iyi hizalama için 'spaceEvenly' yerine 'spaceAround' kullanıldı
        children: <Widget>[
        /*  IconButton(
            icon: Icon(Icons.local_hospital, color: Theme.of(context).colorScheme.primary),
            onPressed: () {
              // Tanımlanmış MS merkezleri olan adresler
            },
          ),*/
          IconButton(
            icon: Icon(Icons.notifications, color: Theme.of(context).colorScheme.primary),
            onPressed: () {
              // gönderilen randevu hatırlatmaları
            },
          ),
        /*  IconButton(
            icon: Icon(Icons.medical_services, color: Theme.of(context).colorScheme.secondary),
            onPressed: () {
              // Şu an kullanılan ilaç hakkında bilgiler
              //ilaçlar hakkında bilgi verilmiyor
            },
          ),*/ 
          IconButton(
            icon: Icon(Icons.person_search, color: Theme.of(context).colorScheme.primary),
            onPressed: () {
              // MS doktorlarının bulunduğu liste
               Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DoctorListPage()),
            );
            },
          ),
          IconButton(
          icon: Icon(Icons.account_circle, color: Theme.of(context).colorScheme.primary),
          onPressed: () {
            // Navigate to ProfilePage
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
