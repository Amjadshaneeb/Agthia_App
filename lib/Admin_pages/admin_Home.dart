import 'package:agthia_slot_booking/admin_pages/edit_restaurant.dart';
import 'package:agthia_slot_booking/firebase_services/services.dart';
import 'package:agthia_slot_booking/user_pages/company_Pages/career.dart';
import 'package:agthia_slot_booking/user_pages/company_Pages/media_page.dart';
import 'package:agthia_slot_booking/user_pages/details.dart';
import 'package:agthia_slot_booking/user_pages/home_page_content.dart';
import 'package:agthia_slot_booking/widgets/List/list.dart';
import 'package:agthia_slot_booking/widgets/admin_drawer.dart';
import 'package:agthia_slot_booking/widgets/local_carousal.dart';
import 'package:agthia_slot_booking/widgets/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';

final ImagePicker picker = ImagePicker();

XFile? imagefile;
bool isAdmin = true;

final storage = FirebaseStorage.instance;

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  final PageController _pageController = PageController(viewportFraction: 0.7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF302c34),
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "Admin Home",
          style: GoogleFonts.sora(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(
                Icons.keyboard_double_arrow_left_outlined,
                color: Color.fromARGB(255, 255, 102, 0),
              )),
        ),
        actions: [
          IconButton(
              onPressed: () {
                signOut(context);
              },
              icon: const Icon(
                Icons.logout_sharp,
                color: Color.fromARGB(255, 255, 102, 0),
              )),
        ],
      ),
      drawer: const AdminDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Consumer<FunctionProvider>(
                  builder: (context, provider, child) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: (provider.imageUrl != null &&
                                provider.imageUrl!.isNotEmpty)
                            ? DecorationImage(
                                image: NetworkImage(provider.imageUrl!),
                                fit: BoxFit.fitWidth,
                              )
                            : null, // Set a placeholder if needed
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 15,
                            spreadRadius: 0,
                          ),
                        ],
                        color: Colors.white,
                      ),
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width * 0.89,
                      child: (provider.imageUrl == null ||
                              provider.imageUrl!.isEmpty)
                          ? const Center(child: Text("Image not available"))
                          : null,
                    );
                  },
                ),
              ],
            ),
            Consumer<FunctionProvider>(
              builder: (context, provider, child) {
                return IconButton(
                  onPressed: () {
                    provider.pickImage(context, "Banner");
                  },
                  icon: const Icon(
                    Icons.mode_edit_outlined,
                    size: 25,
                    color: Color.fromARGB(255, 255, 102, 0),
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.96,
                  child: ListView.builder(
                      controller: _pageController,
                      scrollDirection: Axis.horizontal,
                      itemCount: sorting.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: ChoiceChip(
                                  showCheckmark: false,
                                  label: Text(sorting[index]),
                                  selected: selectedindex == index,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      selectedindex = index;
                                    });
                                  },
                                  selectedColor:
                                      const Color.fromARGB(255, 255, 102, 0),
                                  backgroundColor: Colors.grey.shade200,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  side: BorderSide.none,
                                  labelStyle: TextStyle(
                                    color: selectedindex == index
                                        ? Colors.white
                                        : const Color.fromARGB(
                                            255, 134, 133, 133),
                                  ),
                                )),
                          ],
                        );
                      }),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Consumer<BrandProvider>(
              builder: (context, provider, child) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: MediaQuery.of(context).size.height * 0.45,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: selectedindex == 0
                        ? LayoutBuilder(
                            builder: (context, constraints) {
                              double containerHeight =
                                  constraints.maxWidth * 16 / 7;
                              return SizedBox(
                                height: containerHeight,
                                width: constraints.maxWidth,
                                child: FutureBuilder<List<Map<String, String>>>(
                                  future: provider.getBrandsWithImages(
                                      "InterNational Brand"),
                                  // Fetch data from Firestore
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child:
                                            CircularProgressIndicator(color: Color.fromARGB(255, 255, 102, 0)), // Loading indicator
                                      );
                                    }

                                    if (snapshot.hasError) {
                                      return const Center(
                                        child: Text('Failed to load Brands.'),
                                      );
                                    }

                                    if (!snapshot.hasData ||
                                        snapshot.data!.isEmpty) {
                                      return const Center(
                                        child: Text('No Brands available.'),
                                      );
                                    }

                                    List<Map<String, String>> brandData =
                                        snapshot.data!;

                                    return CarouselSlider.builder(
                                      itemCount: brandData.length,
                                      itemBuilder: (context, index, realIndex) {
                                        String imageUrl =
                                            brandData[index]['Url'] ?? '';
                                        String brandName =
                                            brandData[index]['Name'] ?? '';
                                        String reservationLink =
                                            brandData[index]['Reservation'] ??
                                                '';
                                        String twitterLink =
                                            brandData[index]['Twitter'] ?? '';
                                        String instagramLink =
                                            brandData[index]['Instagram'] ?? '';
                                        String facebookLink =
                                            brandData[index]['Facebook'] ?? '';
                                        String discription = brandData[index]
                                                ['Description'] ??
                                            '';

                                        return GestureDetector(
                                          onTap: () {
                                            // Navigate to the DetailsPage with brand name and image URL
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailsPage(
                                                  isAdmin: true,
                                                  imageUrl: imageUrl,
                                                  brandName: brandName,
                                                  description: discription,
                                                  reservationLink:
                                                      reservationLink,
                                                  instagramLink: instagramLink,
                                                  twitterLink: twitterLink,
                                                  facebookLink: facebookLink,
                                                ),
                                              ),
                                            );
                                          },
                                          onLongPress: () {
                                            // Show popup with Edit and Delete options
                                            showModalBottomSheet(
                                              backgroundColor:
                                                  const Color(0xFF302c34),
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Consumer<
                                                    DeleteBrandProvider>(
                                                  builder: (context, provider,
                                                      child) {
                                                    return Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        ListTile(
                                                          leading: const Icon(
                                                              Icons.edit,
                                                              color:
                                                                  Colors.white),
                                                          title: const Text(
                                                              'Edit',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context); // Close the popup
                                                            Map<String, String>
                                                                brand =
                                                                brandData[
                                                                    index]; // Assuming you have a list of brand data

                                                            // Navigate to the EditRestaurantScreen and pass the selected brand data
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    EditRestaurantScreen(
                                                                        brand:
                                                                            brand), // Pass the selected brand
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                        ListTile(
                                                          leading: const Icon(
                                                              Icons.delete,
                                                              color:
                                                                  Colors.white),
                                                          title: const Text(
                                                              'Delete',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                  backgroundColor:
                                                                      const Color(
                                                                          0xFF302c34),
                                                                  title: const Text(
                                                                      'Confirm Deletion',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white)),
                                                                  content: const Text(
                                                                      'Are you sure you want to delete this brand?',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white)),
                                                                  actions: <Widget>[
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context); // Close the dialog
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        'Cancel',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        final parentContext =
                                                                            context;
                                                                        Navigator.pop(
                                                                            context); // Close the dialog
                                                                        provider.deleteBrand(
                                                                            brandName,
                                                                            parentContext,
                                                                            "InterNational Brand"); // Perform deletion
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        'Delete',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.red),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          },
                                                        )
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                            );
                                          },
                                          child: Container(
                                            width: constraints.maxWidth,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.transparent,
                                            ),
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: Image.network(
                                                    imageUrl,
                                                    fit: BoxFit.cover,
                                                    width: double.infinity,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.5,
                                                    loadingBuilder: (context,
                                                        child,
                                                        loadingProgress) {
                                                      if (loadingProgress ==
                                                          null) return child;
                                                      return const Center(
                                                        child:
                                                            CircularProgressIndicator(color: Color.fromARGB(255, 255, 102, 0)),
                                                      );
                                                    },
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return const Icon(
                                                          Icons.error,
                                                          color: Colors.red);
                                                    },
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  child: Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 255, 102, 0),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(20),
                                                        bottomRight:
                                                            Radius.circular(20),
                                                      ),
                                                    ),
                                                    alignment:
                                                        AlignmentDirectional
                                                            .centerStart,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.05,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.594,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        brandName,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                          ) // Show Carousel if index is 0
                        : selectedindex == 1
                            ? const CarousalContainer2(
                                admin: true,
                              ) // Show CarousalContainer2 if index is 1
                            : selectedindex == 2
                                ? const MediaPage()
                                : selectedindex == 3
                                    ? const Careerpage()
                                    : Container(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
