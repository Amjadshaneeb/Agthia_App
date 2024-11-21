import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MediaPage extends StatelessWidget {
  const MediaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height*0.03,
        ),
        Text(
          "Latest News",
          style: GoogleFonts.nunito(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),SizedBox(
          height: MediaQuery.of(context).size.height*0.015,
        ),
        Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Color.fromARGB(207, 240, 233, 233)),
          height: 150,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Latest News")
                  .doc("News")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: Color.fromARGB(255, 255, 102, 0)));
                }
                if (snapshot.hasError) {
                  return const Text("Error loading data");
                }
                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return const Text("No data available");
                }

                // Get the 'AboutUs' data from the document
                String newsText = snapshot.data!.get("News");
                return Text(
                  newsText,
                  style: GoogleFonts.dmSerifDisplay(
                      fontSize: 15, color: Colors.black),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
