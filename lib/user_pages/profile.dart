import 'package:agthia_slot_booking/widgets/List/list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Profile",
          style: GoogleFonts.ptSerif(
            textStyle: const TextStyle(color: Color(0xFF0f172b)),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Container(
            height: 250,
            width: 500,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 102, 0),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25))),
            child: const Column(
              children: [
                SizedBox(height: 20),
                Center(
                  child: CircleAvatar(
                    radius: 60,
                    child: Icon(Icons.person_2_outlined),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "User Name",
                  style: TextStyle(color: Colors.white, fontSize: 19),
                )
              ],
            ),
          ),
          Expanded(
            flex: 50,
            child: ListView.builder(
                itemCount: 5,
                padding: const EdgeInsets.all(30),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: const Color(0xFF0f172b),
                            borderRadius: BorderRadius.circular(20)),
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
                      const SizedBox(
                        height: 10,
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
