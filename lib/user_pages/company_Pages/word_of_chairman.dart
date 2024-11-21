import 'package:agthia_slot_booking/user_pages/home_bottom_navigation.dart';
import 'package:agthia_slot_booking/widgets/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class WordOfChairman extends StatefulWidget {
  WordOfChairman({super.key});

  @override
  State<WordOfChairman> createState() => _WordOfChairmanState();
}

class _WordOfChairmanState extends State<WordOfChairman> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF302c34),
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Homepage()));
              },
              icon: const Icon(Icons.arrow_back_ios,
                  color: Color.fromARGB(255, 255, 102, 0))),
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "Word of chairman",
            style: GoogleFonts.anekKannada(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Consumer<BannerProvider>(
              builder: (context, provider, child) {
                if (provider.chairmanBanner != null &&
                    provider.chairmanBanner!.isNotEmpty) {
                  return Image.network(
                    provider.chairmanBanner!,
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  );
                } else {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Center(
                      child: Text('No image available'),
                    ),
                  );
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 255, 102, 0)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black,
                              const Color.fromARGB(255, 52, 54, 159)
                            ])),
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("Word of chairman")
                                .doc("word")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator(color: Color.fromARGB(255, 255, 102, 0)));
                              }
                              if (snapshot.hasError) {
                                return const Text("Error loading data");
                              }
                              if (!snapshot.hasData || !snapshot.data!.exists) {
                                return const Text(
                                  "No data available",
                                  style: TextStyle(color: Colors.white),
                                );
                              }

                              // Get the 'AboutUs' data from the document
                              String newsText = snapshot.data!.get("word");
                              return Text(
                                newsText,
                                style: GoogleFonts.raleway(
                                    fontSize: 15, color: Colors.white),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
