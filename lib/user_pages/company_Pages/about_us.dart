import 'package:agthia_slot_booking/user_pages/company_Pages/contact_us.dart';
import 'package:agthia_slot_booking/widgets/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          forceMaterialTransparency: true,
          centerTitle: true,
          title: Text(
            'About Us',
            style: GoogleFonts.outfit(
              fontSize: 28,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: const Color(0xFF302c34),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [],
              ),
             Consumer<BannerProvider>(
          builder: (context, provider, child) {
            if (provider.aboutUsBanner != null &&
                provider.aboutUsBanner!.isNotEmpty) {
              return Image.network(
                provider.aboutUsBanner!,
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
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.5,
                child: Center(
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("Company")
                            .doc("AboutUs")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator(color: Color.fromARGB(255, 255, 102, 0)));
                          }
                          if (snapshot.hasError) {
                            return Text("Error loading data");
                          }
                          if (!snapshot.hasData || !snapshot.data!.exists) {
                            return Text("No data available");
                          }

                          // Get the 'AboutUs' data from the document
                          String aboutUsText = snapshot.data!.get("AboutUs");

                          return Padding(
                            padding: const EdgeInsets.all(10),
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
              ),
              const SizedBox(
                height: 20,
              ),
              CompanyDetails()
            ],
          ),
        ),
      ),
    );
  }
}
