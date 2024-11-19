import 'package:agthia_slot_booking/Admin_pages/admin_Home.dart';
import 'package:agthia_slot_booking/user_pages/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

TextEditingController loginmailcontroller = TextEditingController();
TextEditingController loginpasscontroller = TextEditingController();

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;
final usermail = FirebaseAuth.instance.currentUser?.email;

Future resetpassword(context) async {
  await FirebaseAuth.instance
      .sendPasswordResetEmail(email: loginmailcontroller.text.trim());
  try {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(milliseconds: 500),
        backgroundColor: Color.fromARGB(255, 255, 102, 0),
        content: Text("Reset link send Successfully")));
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(milliseconds: 500),
        backgroundColor: Color.fromARGB(255, 255, 102, 0),
        content: Text("Not valid mail")));
    print(e);
  }
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
  final String email = loginmailcontroller.text.trim();
  final String password = loginpasscontroller.text.trim();

  if (email.isEmpty || password.isEmpty) {
    showDialog(
      context: context,
      builder: (context) =>
          const AlertDialog(title: Text("Please enter email and password")),
    );
    return;
  }

  try {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    Navigator.of(context).pop(); // Dismiss loading


    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      duration: Duration(milliseconds: 500),
      backgroundColor: Color.fromARGB(255, 255, 102, 0),
      content: Text("Admin Login Successfully"),
    ));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AdminHome()),
    );
  } on FirebaseAuthException catch (e) {
    Navigator.of(context).pop(); 
    print('FirebaseAuthException: ${e.code}');

    String errorMessage =
        e.code == "wrong-password" || e.code == "invalid-credential"
            ? "Wrong Password!"
            : "Login Failed";

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(milliseconds: 500),
      backgroundColor: Color.fromARGB(255, 255, 102, 0),
      content: Text(errorMessage),
    ));
  } catch (e) {
    Navigator.of(context).pop();
    print(e);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      duration: Duration(milliseconds: 500),
      backgroundColor: Color.fromARGB(255, 255, 102, 0),
      content: Text("An Error Occurred"),
    ));
  }
}




// Future<void> signup(
//     BuildContext context, String name, String mail, String password) async {
//   try {
//     await FirebaseAuth.instance.createUserWithEmailAndPassword(
//       email: emailController.text.trim(),
//       password: passwordController.text.trim(),
//     );

//     await FirebaseFirestore.instance.collection('Userid').doc(name).set({
//       'Name': name,
//       'Mail': mail,
//       'Password': password,
//     });

//     print("SignUp successful");

//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => Homepage()));
//   } on FirebaseAuthException catch (e) {
//     if (e.code == 'weak-password') {
//       showDialog(
//           // ignore: use_build_context_synchronously
//           context: context,
//           builder: (context) => const AlertDialog(
//               title: Text("Pass must be at least 6 character")));
//       print('The password provided is too weak.');
//     } else if (e.code == 'email-already-in-use') {
//       showDialog(
//           // ignore: use_build_context_synchronously
//           context: context,
//           builder: (context) =>
//               const AlertDialog(title: Text("email-already-in-use")));
//       print('The account already exists for that email.');
//     } else {
//       print("$e cfrgvbhnjgbhnjkm");
//       showDialog(

//           // ignore: use_build_context_synchronously
//           context: context,
//           builder: (context) =>
//               const AlertDialog(title: Text("Email not valid")));
//     }
//   } catch (e) {
//     print("Error: rfgtvbhtfgvhb $e");
//   }
// }


