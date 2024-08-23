import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Bildirimler'),
        ),
        body: const Center(
          child: Text('Giriş yapmanız gerekiyor.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bildirimler'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('notifications')
            .where('uid', isEqualTo: user.uid)
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Henüz bir bildiriminiz yok.'));
          }

          final notifications = snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return {
              'title': data['title'] as String,
              'body': data['body'] as String,
              'date': (data['date'] as Timestamp).toDate().toString(),
            };
          }).toList();

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return Card(
                child: ListTile(
                  title: Text(notification['title']!),
                  subtitle: Text(notification['body']!),
                  trailing: Text(notification['date']!),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
