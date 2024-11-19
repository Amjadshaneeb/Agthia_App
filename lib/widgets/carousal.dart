// import 'package:agthia_slot_booking/user_pages/details.dart';
// import 'package:agthia_slot_booking/widgets/provider.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:agthia_slot_booking/widgets/List/list.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// final controller2 = CarouselController();

// class CarousalContainer extends StatefulWidget {
//   const CarousalContainer({super.key});

//   @override
//   State<CarousalContainer> createState() => AdvContainerState();
// }

// class AdvContainerState extends State<CarousalContainer> {
//   int activePage = 0; // Tracks the current page index

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<FunctionProvider>(
//       builder: (context, provider, child) {
//         return LayoutBuilder(
//           builder: (context, constraints) {
//             double containerHeight = constraints.maxWidth * 16 / 7;
//             return SizedBox(
//               height: containerHeight,
//               width: constraints.maxWidth,
//               child: provider.picsList.isEmpty
//                   ? const Center(
//                       child: CircularProgressIndicator(), // Loading indicator
//                     )
//                   : CarouselSlider.builder(
//                       key: ValueKey(provider.picsList.length),
//                       itemCount: provider.picsList.length,
//                       itemBuilder: (context, index, realIndex) {
//                         double scale = activePage == index ? 1.0 : 0.9;
//                         return Transform.scale(
//                           scale: scale,
//                           child: GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           const DetailsPage(brandName: "",
//                                           imageUrl: "",
//                                                               description: "",
//                                                               location: "",)));
//                             },
//                             child: Container(
//                               width: constraints.maxWidth,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 color: Colors.black,
//                               ),
//                               child: Stack(
//                                 children: [
//                                   ClipRRect(
//                                     borderRadius: BorderRadius.circular(40),
//                                     child: Image.network(
//                                       provider.picsList[index],
//                                       fit: BoxFit.cover,
//                                       width: double.infinity,
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                               0.5,
//                                       loadingBuilder:
//                                           (context, child, loadingProgress) {
//                                         if (loadingProgress == null) {
//                                           return child;
//                                         }
//                                         return const Center(
//                                             child: CircularProgressIndicator());
//                                       },
//                                       errorBuilder:
//                                           (context, error, stackTrace) {
//                                         return const Icon(Icons.error,
//                                             color: Colors.red);
//                                       },
//                                     ),
//                                   ),
//                                   Positioned(
//                                     bottom: 2,
//                                     left: 10,
//                                     child: Text(
//                                       brands[index],
//                                       style: GoogleFonts.abhayaLibre(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 20),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                       options: CarouselOptions(
//                         padEnds: false,
//                         height: containerHeight,
//                         autoPlay: true,
//                         viewportFraction: 0.6,
//                         disableCenter: false,
//                         onPageChanged: (index, reason) {
//                           setState(() {
//                             activePage = index;
//                           });
//                         },
//                       ),
//                     ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
