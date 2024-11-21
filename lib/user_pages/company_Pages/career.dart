import 'package:agthia_slot_booking/widgets/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Careerpage extends StatefulWidget {
  const Careerpage({super.key});

  @override
  State<Careerpage> createState() => _CareerpageState();
}

class _CareerpageState extends State<Careerpage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<BannerProvider>(
          builder: (context, provider, child) {
            if (provider.careerBanner != null &&
                provider.careerBanner!.isNotEmpty) {
              return Image.network(
                provider.careerBanner!,
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              );
            } else {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Center(
                  child: Text('No image available'),
                ),
              );
            }
          },
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Career",
          style: GoogleFonts.nunito(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.015,
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
                  .collection("Career")
                  .doc("career")
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
                String newsText = snapshot.data!.get("career");
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
