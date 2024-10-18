import 'package:agthia_slot_booking/user_pages/homeBottomNavigation.dart';
import 'package:agthia_slot_booking/user_pages/login_or_register.dart';
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
            return const LoginOrRegister();
          } else {
            return const Homepage();
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
