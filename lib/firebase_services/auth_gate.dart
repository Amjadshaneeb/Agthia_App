import 'package:agthia_slot_booking/Admin_pages/admin_Home.dart';
import 'package:agthia_slot_booking/user_pages/home_bottom_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          if (user == null) {
            return const Homepage();
          } else {
            return const AdminHome();
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
