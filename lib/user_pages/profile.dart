import 'package:agthia_slot_booking/firebase_services/services.dart';
import 'package:agthia_slot_booking/widgets/List/list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFF0f172b),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Profile",
          style: GoogleFonts.ptSerif(
            textStyle: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Container(
            height: 230,
            width: 500,
            decoration: const BoxDecoration(
                color: Color(0xFF0f172b),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25))),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      child: Icon(Icons.person_2_outlined),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 40,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Userid')
                        .where("Mail", isEqualTo: usermail)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      return Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: snapshot.data!.docs.map((document) {
                            return Text(
                              document["Name"],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 5,
                padding: const EdgeInsets.all(20),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            // color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          children: [
                            ListTile(
                              trailing: const Icon(Icons.arrow_forward_ios,
                                  color: Colors.white),
                              leading: Icon(
                                iconss[index],
                                color: const Color.fromARGB(255, 255, 102, 0),
                              ),
                              title: Text(
                                profile[index],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              contentPadding: const EdgeInsets.all(10),
                            ),
                          ],
                        ),
                      ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      const Divider(
                        color: Colors.white,
                      )
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}
