import 'package:agthia_slot_booking/user_pages/details.dart';
import 'package:agthia_slot_booking/widgets/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:agthia_slot_booking/widgets/List/list.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

final controller2 = CarouselController();

class CarousalContainer2 extends StatefulWidget {
  const CarousalContainer2({super.key});

  @override
  State<CarousalContainer2> createState() => AdvContainerState();
}

class AdvContainerState extends State<CarousalContainer2> {
  int activePage = 0; // Tracks the current page index

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double containerHeight = constraints.maxWidth * 16 / 7;
        return Consumer<BrandProvider>(
          builder: (context, provider, child) {
            return SizedBox(
              height: containerHeight,
              child: FutureBuilder<List<Map<String, String>>>(
                future: provider.getBrandsWithImages("Local Brand"),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Center(child: Text('Failed to load data.'));
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No data available.'));
                  }

                  List<Map<String, String>> brandData = snapshot.data!;

                  return CarouselSlider.builder(
                    itemCount: brandData.length,
                    itemBuilder: (context, index, realIndex) {
                      String imageUrl = brandData[index]['Url'] ?? '';
                      String brandName = brandData[index]['Name'] ?? '';
                      String reservationLink =
                          brandData[index]['Reservation'] ?? '';
                      String twitterLink = brandData[index]['Twitter'] ?? '';
                      String instagramLink =
                          brandData[index]['Instagram'] ?? '';
                      String facebookLink = brandData[index]['Facebook'] ?? '';
                      String discription =
                          brandData[index]['Description'] ?? '';

                      return GestureDetector(
                        onTap: () {
                          // Navigate to the DetailsPage with brand name and image URL
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                isAdmin: false,
                                imageUrl: imageUrl,
                                brandName: brandName,
                                description: discription,
                                reservationLink: reservationLink,
                                instagramLink: instagramLink,
                                twitterLink: twitterLink,
                                facebookLink: facebookLink,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: constraints.maxWidth,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.transparent,
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.error,
                                        color: Colors.red);
                                  },
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 255, 102, 0),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                  ),
                                  alignment: AlignmentDirectional.centerStart,
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:
                                      MediaQuery.of(context).size.width * 0.594,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      brandName,
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      padEnds: false,
                      height: containerHeight,
                      autoPlay: true,
                      viewportFraction: 0.6,
                      // disableCenter: false,
                      enlargeCenterPage: true,
                      // onPageChanged: (index, reason) {
                      //   provider.updateActivePage(index);
                      // },
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
