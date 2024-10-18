import 'package:agthia_slot_booking/user_pages/homeBottomNavigation.dart';
import 'package:agthia_slot_booking/widgets/List/list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

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
                child: SingleChildScrollView(
                  
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 10,
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
                          IconButton(
                              onPressed: () {
                                _launchUrl(0);
                              },
                              icon: const Icon(
                                Icons.facebook,
                                size: 42,
                                color: Colors.black,
                              )),
                          IconButton(
                              onPressed: () {
                                _launchUrl(1);
                              },
                              icon: Image.asset(
                                "assets/Instagram.png",
                                scale: 30,
                              )),
                          IconButton(
                            onPressed: () {
                              _launchUrl(2);
                            },
                            icon: Image.asset(
                              "assets/ebe2b20b859a8d346bcb27d17e941e7d.png",
                              scale: 30,
                            ),
                          ),
                        ],
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          "Born in Monte-Carlo, full of contrasts, our brand breaks with rigid, traditional codes. Through its glamorous architectural lines & bold menu, we re-think food and incorporate a modern luxury feel while offering a complete and more accessible experience. From the kitchen, our executive chef Thierry Paludetto works closely with Riccardo Giraudi to create incredible, tasty yet simple dishes.",
                          style: GoogleFonts.breeSerif(),
                        ),
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
                            "Subscribe",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Future<void> _launchUrl(int index) async {
    final Uri uri = Uri.parse(url[index]);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.inAppWebView,
    )) {
      throw Exception('Could not launch ${url[index]}');
    }
  }
}
