// import 'package:agthia_slot_booking/admin_pages/admin_home.dart';
// import 'package:agthia_slot_booking/widgets/controllers.dart';
// import 'package:agthia_slot_booking/widgets/textField.dart';
// import 'package:flutter/material.dart';

// class ContactEdit extends StatelessWidget {
//   const ContactEdit({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF302c34),
//       appBar: AppBar(
//         forceMaterialTransparency: true,
//         centerTitle: true,
//         title: Text("Contact Us"),
//       ),
//       body: Column(
//         children: [
//           Center(
//             child: Mytextfield(
//               maxlines: 6,
//               hinttext: "Content",
//               obscure: false,
//               controller: contactusController,
//               textStyle: const TextStyle(color: Colors.white),
//             ),
//           ),
//           TextButton(
//             style: const ButtonStyle(
//                 backgroundColor:
//                     WidgetStatePropertyAll(Color.fromARGB(255, 255, 102, 0))),
//             onPressed: () {
//               Navigator.pushReplacement(context,
//                   MaterialPageRoute(builder: (context) => const AdminHome()));
//             },
//             child: const Text("Save", style: TextStyle(color: Colors.white)),
//           )
//           // Center(
//           //   child: Mytextfield(
//           //     hinttext: "Content",
//           //     obscure: false,
//           //     controller: aboutusController,
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
// }
