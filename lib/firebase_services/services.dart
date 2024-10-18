import 'package:agthia_slot_booking/Admin_pages/admin_Home.dart';
import 'package:agthia_slot_booking/user_pages/homeBottomNavigation.dart';
import 'package:agthia_slot_booking/user_pages/homePage.dart';
import 'package:agthia_slot_booking/user_pages/login_or_register.dart';
import 'package:agthia_slot_booking/user_pages/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Login TexteditingControllers
TextEditingController loginmailcontroller = TextEditingController();
TextEditingController loginpasscontroller = TextEditingController();

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;
  final usermail = FirebaseAuth.instance.currentUser?.email;


Future resetpassword(context) async {
  await FirebaseAuth.instance
      .sendPasswordResetEmail(email: loginmailcontroller.text.trim());
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      duration: Duration(milliseconds: 500),
      backgroundColor: Color.fromARGB(255, 255, 102, 0),
      content: Text("Reset link send Successfully")));
}

// SignOut Function

Future<void> signOut(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(milliseconds: 500),
        backgroundColor: Color.fromARGB(255, 255, 102, 0),
        content: Text("Logout successfully")));

    Navigator.push(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => const LoginOrRegister()),
    );
  } on FirebaseAuthException catch (e) {
    showDialog(
      // ignore: use_build_context_synchronously
      context: context,
      builder: (context) => AlertDialog(title: Text(e.toString())),
    );
  }
}

// Login Function
Future<void> login(BuildContext context) async {
  const String adminEmail = 'admin4@gmail.com';
  const String adminPassword = 'admin1234';

  final String email = loginmailcontroller.text.trim();
  final String password = loginpasscontroller.text.trim();

  try {
    // Check if the entered credentials are for admin
    if (email == adminEmail && password == adminPassword) {
      // Admin Login
      const CircularProgressIndicator();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(milliseconds: 500),
          backgroundColor: Color.fromARGB(255, 255, 102, 0),
          content: Text("Admin Login Successfully")));

      // Navigate to Admin Homepage
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const AdminHome()));
    } else {
      // User Login
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      const CircularProgressIndicator();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(milliseconds: 500),
          backgroundColor: Color.fromARGB(255, 255, 102, 0),
          content: Text("User Login Successfully")));

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Homepage()));
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == "wrong-password") {
      // Show wrong password alert
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(title: Text("Wrong password")),
      );
    } else if (e.code == "user-not-found") {
      // Show user not found alert
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(title: Text("User not found")),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(title: Text("Login failed")),
      );
    }
  } catch (e) {
    print(e);
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(title: Text("An error occurred")),
    );
  }
}

Future<void> signup(
    BuildContext context, String name, String mail, String password) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    await FirebaseFirestore.instance.collection('Userid').doc(name).set({
      'Name': name,
      'Mail': mail,
      'Password': password,
    });

    print("SignUp successful");

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Homepage()));
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) => const AlertDialog(
              title: Text("Pass must be at least 6 character")));
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) =>
              const AlertDialog(title: Text("email-already-in-use")));
      print('The account already exists for that email.');
    } else {
      print("$e cfrgvbhnjgbhnjkm");
      showDialog(

          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) =>
              const AlertDialog(title: Text("Email not valid")));
    }
  } catch (e) {
    print("Error: rfgtvbhtfgvhb $e");
  }
}


