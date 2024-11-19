import 'package:agthia_slot_booking/user_pages/home_bottom_navigation.dart';
import 'package:agthia_slot_booking/widgets/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OurpeoplePage extends StatelessWidget {
  const OurpeoplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF302c34),
      appBar: AppBar(
        title: Text(
          "Our people",
          style: GoogleFonts.roboto(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Homepage()));
            },
            icon: const Icon(Icons.arrow_back_ios,
                color: Color.fromARGB(255, 255, 102, 0))),
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<BannerProvider>(
          builder: (context, provider, child) {
            if (provider.ourpeopleBanner != null &&
                provider.ourpeopleBanner!.isNotEmpty) {
              return Image.network(
                provider.ourpeopleBanner!,
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
            Center(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Our People")
                        .doc("Ourpeople")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Text("Error loading data");
                      }
                      if (!snapshot.hasData || !snapshot.data!.exists) {
                        return Text("No data available");
                      }

                      // Get the 'AboutUs' data from the document
                      String aboutUsText = snapshot.data!.get("Ourpeople");

                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          aboutUsText,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
