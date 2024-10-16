import 'package:agthia_slot_booking/user_pages/homeBottomNavigation.dart';
import 'package:agthia_slot_booking/widgets/List/list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          physics: const ScrollPhysics(parent: FixedExtentScrollPhysics()),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/bbq-grill-cooked-with-hot-spicy-sichuan-pepper-sauce-is-chinese-herb.jpg"),
                        fit: BoxFit.cover)),
                height: MediaQuery.of(context).size.height * 0.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.4)),
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Homepage()));
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new, // Back arrow
                            ),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      brands[0],
                      style: GoogleFonts.ptSerif(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const SizedBox(width: 15),
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        Text(
                          "4.3 ",
                          style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "(432 Reviews)",
                          style: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.withOpacity(0.6)),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("xedfrcgtvhybjnkml\nrtfgyhbunjcfvgbhnj"),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.13,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFF0f172b),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        child: const Text(
                          "Reserve",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
