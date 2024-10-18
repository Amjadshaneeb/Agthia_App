import 'package:agthia_slot_booking/user_pages/details.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:agthia_slot_booking/widgets/List/list.dart';

final controller2 = CarouselController();

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
        double containerHeight = constraints.maxWidth * 16 / 7;

        return SizedBox(
          height: containerHeight,
          width: constraints.maxWidth,
          child: CarouselSlider.builder(
            itemCount: pics.length,
            itemBuilder: (context, index, realIndex) {
              double scale = activePage == index ? 1.0 : 0.9;
              return Transform.scale(
                scale: scale,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsPage()));
                    },
                    child: Container(
                      width: constraints.maxWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black,
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Image.asset(
                              pics[index],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            options: CarouselOptions(
              height: containerHeight,
              viewportFraction: 0.85,
              disableCenter: false,
              enableInfiniteScroll: false,
              autoPlay: true,
              onPageChanged: (index, reason) {
                setState(() {
                  activePage = index;
                });
              },
            ),
          ),
        );
      },
    );
  }
}
