import 'package:agthia_slot_booking/admin_pages/admin_home.dart';
import 'package:agthia_slot_booking/user_pages/company_Pages/contact_us.dart';
import 'package:agthia_slot_booking/user_pages/company_Pages/subscribe.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage(
      {super.key,
      required this.imageUrl,
      required this.brandName,
      required this.description,
      required this.reservationLink,
      required this.instagramLink,
      required this.twitterLink,
      required this.facebookLink,
      required this.isAdmin});
  final String imageUrl;
  final String brandName;
  final String description;
  final String reservationLink;
  final String instagramLink;
  final String twitterLink;
  final String facebookLink;
  final bool isAdmin;
  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          forceMaterialTransparency: true,
          backgroundColor: Colors.transparent,
          leading: Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFF302c34),
              ),
              child: Center(
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context, isAdmin ? 'AdminHome' : 'Homepage');
                  },
                  icon: const Icon(Icons.arrow_back_ios_new),
                  color: const Color.fromARGB(255, 255, 102, 0),
                ),
              ),
            ),
          )),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.imageUrl), fit: BoxFit.cover)),
              height: MediaQuery.of(context).size.height * 0.5,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: const BoxDecoration(color: Color(0xFF302c34)),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        widget.brandName,
                        style: GoogleFonts.ptSerif(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                            onTap: () {
                              _launchUrl(widget.facebookLink);
                            },
                            child: Image.asset(
                              "assets/pngwing.com (14).png",
                              scale: 17,
                            )),
                        GestureDetector(
                            onTap: () {
                              _launchUrl(widget.instagramLink);
                            },
                            child: Image.asset(
                              "assets/Instagram.png",
                              scale: 30,
                            )),
                        GestureDetector(
                          onTap: () {
                            _launchUrl(widget.twitterLink);
                          },
                          child: Image.asset(
                            "assets/ebe2b20b859a8d346bcb27d17e941e7d.png",
                            scale: 30,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.15,
                        ),
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextButton(
                            onPressed: () {
                              _launchUrl(widget.reservationLink);
                            },
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 102, 0),
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
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        widget.description,
                        style: GoogleFonts.breeSerif(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF302c34),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      backgroundColor: const Color(0xFF302c34),
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      builder: (context) => const SubscribeBottomSheet(),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 102, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  child: const Text(
                    "Subscribe",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    showContactUs(context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 102, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  child: const Text(
                    "About Us",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [

      //   ],
      // ),
    );
  }

  void showContactUs(BuildContext context) {
    showModalBottomSheet(
      scrollControlDisabledMaxHeightRatio: 0.5,
      backgroundColor: const Color(0xFF302c34),
      context: context,
      builder: (context) {
        return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const CompanyDetails());
      },
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.inAppWebView,
    )) {
      throw Exception('Could not launch ${url}');
    }
  }
}
