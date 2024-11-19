import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF302c34),
      appBar: AppBar(),
      body: const Column(
        children: [
          Center(
              child: Text(
            "Notification",
            style: TextStyle(fontSize: 50),
          ))
        ],
      ),
    );
  }
}
