import 'dart:async';
import 'dart:ui';
import 'package:agthia_slot_booking/user_pages/company_Pages/career.dart';
import 'package:agthia_slot_booking/user_pages/company_Pages/media_page.dart';
import 'package:agthia_slot_booking/user_pages/company_Pages/view_all_restaurant.dart';
import 'package:agthia_slot_booking/user_pages/details.dart';
import 'package:agthia_slot_booking/user_pages/login_or_register.dart';
import 'package:agthia_slot_booking/widgets/List/list.dart';
import 'package:agthia_slot_booking/widgets/local_carousal.dart';
import 'package:agthia_slot_booking/widgets/provider.dart';
import 'package:agthia_slot_booking/widgets/user_drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void showMediaPage(BuildContext context) {
  showModalBottomSheet(
    scrollControlDisabledMaxHeightRatio: 0.5,
    backgroundColor: const Color(0xFF302c34),
    context: context,
    builder: (context) {
      return SizedBox(
          width: MediaQuery.of(context).size.width, child: const MediaPage());
    },
  );
}

bool isAdmin = false;
int selectedindex = 0;
bool isLoading = true;
int activePage = 0; // Tracks the current page index
double currentPageValue = 0;

class HomepageContent extends StatefulWidget {
  const HomepageContent({super.key});

  @override
  State<HomepageContent> createState() => _HomepageState();
}

class _HomepageState extends State<HomepageContent> {
  final PageController _pageController = PageController(viewportFraction: 0.7);

  // Future<void> fetchImagesFromFirestore() async {
  //   final firestore = FirebaseFirestore.instance;
  //   final imagesSnapshot = await firestore.collection('carousel_images').get();
  //   final List<String> urls =
  //       imagesSnapshot.docs.map((doc) => doc['url'] as String).toList();
  //   setState(() {
  //     imageUrls = urls;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentPageValue = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF302c34),
      key: _scaffoldKey,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        leading: IconButton(
            enableFeedback: false,
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            icon: const Icon(Icons.keyboard_double_arrow_left_outlined,
                color: Color.fromARGB(255, 255, 102, 0))),
        title: GestureDetector(
          onLongPressStart: (details) {
            // Start a timer that triggers after 5 seconds
            _timer = Timer(Duration(seconds: 5), () {
              // Action to take after 5 seconds of long press
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginOrRegister()),
              );
            });
          },
          onLongPressEnd: (details) {
            if (_timer != null && _timer!.isActive) {
              _timer!.cancel();
            }
          },
          child: TextButton(
            style: TextButton.styleFrom(
              splashFactory: NoSplash.splashFactory, // Disables the animation
              backgroundColor: Colors.transparent, // Optional styling
            ),
            onPressed: () {},
            child: Text(
              "Home",
              style: GoogleFonts.sora(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //                 builder: (context) => const NotificationPage()));
        //       },
        //       icon: const Icon(
        //         Icons.notifications_active,
        //         color: Color.fromARGB(255, 255, 102, 0),
        //       ))
        // ],
      ),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Stack(
                    children: [
                      Consumer<FunctionProvider>(
                        builder: (context, provider, child) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(1),
                                  blurRadius: 15,
                                  spreadRadius: 0,
                                ),
                              ],
                              color: Colors.white,
                            ),
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.89,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  if (provider.imageUrl != null &&
                                      provider.imageUrl!.isNotEmpty)
                                    ImageFiltered(
                                      imageFilter: ImageFilter.blur(
                                          sigmaX: 1.5, sigmaY: 1.5),
                                      child: Image.network(
                                        provider.imageUrl!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  Center(
                                    child: Text(
                                      "EVERY DISH IS A CHAPTER, AND EVERY CONCEPT UNFOLDS A NEW CULINARY ADVENTURE.",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.anton(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 25,
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
                                    // if (selected== 0) {
                                    //   Navigator.(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           navigation[index],
                                    //     ),
                                    //   );
                                    // }
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
                                      "InterNational Brand"), // Fetch data from Firestore
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
                                        child: Text(
                                            'Failed to load images or brand names.'),
                                      );
                                    }

                                    if (!snapshot.hasData ||
                                        snapshot.data!.isEmpty) {
                                      return const Center(
                                        child: Text('No data available.'),
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
                                                  isAdmin: false,
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
                                                        style:
                                                            GoogleFonts.poppins(
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
                                admin: false,
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
            const SizedBox(height: 10),
            selectedindex == 2
                ? const Text("")
                : TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllRestaurantPage()));
                    },
                    child: Text(
                      "View all Restaurant",
                      style: GoogleFonts.nunito(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
