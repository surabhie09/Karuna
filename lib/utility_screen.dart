import 'package:flutter/material.dart';

// --- UTILITY SCREENS ---

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});
  
  final List<Map<String, dynamic>> mockNotifications = const [
    {'title': 'Donation Confirmed', 'subtitle': 'Your pledge is complete.', 'icon': Icons.check_circle, 'color': Colors.green},
    {'title': 'New Message', 'subtitle': 'You have a new message from NGO.', 'icon': Icons.chat, 'color': Colors.blue},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView.builder(
        itemCount: mockNotifications.length,
        itemBuilder: (context, index) {
          final notif = mockNotifications[index];
          return ListTile(
            leading: Icon(notif['icon'], color: notif['color']),
            title: Text(notif['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(notif['subtitle']),
          );
        },
      ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About NGO Connect')),
      body: const Center(child: Text('App version 1.0. Read about our mission here.', textAlign: TextAlign.center, style: TextStyle(fontSize: 16))),
    );
  }
}