import 'package:agthia_slot_booking/admin_pages/admin_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SubscribersPage extends StatefulWidget {
  const SubscribersPage({super.key});

  @override
  State<SubscribersPage> createState() => SubscribersPageState();
}

class SubscribersPageState extends State<SubscribersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF302c34),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AdminHome()));
            },
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
            ),
            color: const Color.fromARGB(255, 255, 102, 0)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('subscribers').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color.fromARGB(255, 255, 102, 0)));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No subscribers yet'),
            );
          }

          final subscribers = snapshot.data!.docs;

          return ListView.builder(
            itemCount: subscribers.length,
            itemBuilder: (context, index) {
              final subscriber = subscribers[index];
              final email = subscriber['email'] ?? 'No email provided';
              final timestamp = subscriber['timestamp'] != null
                  ? (subscriber['timestamp'] as Timestamp).toDate()
                  : null;

              return ListTile(
                leading: const Icon(Icons.email, color: Colors.orange),
                title: Text(
                  email,
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: timestamp != null
                    ? Text(style: TextStyle(color: Colors.white.withOpacity(0.4)),
                        'Subscribed on: ${timestamp.day}/${timestamp.month}/${timestamp.year} ${timestamp.hour % 12}:${timestamp.minute.toString().padLeft(2, '0')} ${timestamp.hour >= 12 ? 'PM' : 'AM'}',
                      )
                    : null,
              );
            },
          );
        },
      ),
    );
  }
}
