import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart' as flutter;
import 'package:flutter/material.dart';
import 'package:agthia_slot_booking/widgets/List/list.dart'; 

final controller2 = flutter.CarouselController();

class CarousalContainer extends StatefulWidget {
  const CarousalContainer({super.key});

  @override
  State<CarousalContainer> createState() => AdvContainerState();
}

class AdvContainerState extends State<CarousalContainer> {
  int activePage = 0; // This tracks the current page index

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double containerHeight = constraints.maxWidth * 16 / 9; // 16:9 aspect ratio

        return SizedBox(
          height: containerHeight,
          width: constraints.maxWidth,
          child: CarouselSlider.builder(
            itemCount: pics.length,
            itemBuilder: (context, index, realIndex) {
            // scale activePage larger and others default size
              double scale = activePage == index ? 1.1 : 0.9;
          
              return Transform.scale(
                scale: scale, // This adjusts the scale based on the active page
                child: flutter.Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    width: constraints.maxWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black,
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            pics[index], // Image list source
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
              
            },
            options: CarouselOptions(
              height: containerHeight,
              viewportFraction: 0.8, // Adjusts to show part of next/previous item
              enlargeCenterPage: false,
              autoPlay: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 300),
              onPageChanged: (index, reason) {
                setState(() {
                  activePage = index; // Update active page index on change
                });
              },
            ),
          ),
        );
      },
    );
  }
}
