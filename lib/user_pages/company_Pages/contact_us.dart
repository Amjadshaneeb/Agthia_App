import 'package:agthia_slot_booking/user_pages/company_Pages/feedback.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF302c34),
      appBar: AppBar(
        forceMaterialTransparency: true,
        // leading: IconButton(
        //     onPressed: () {
        //       Navigator.push(context,
        //           MaterialPageRoute(builder: (context) => const Homepage()));
        //     },
        //     icon: const Icon(
        //       Icons.arrow_back_ios_outlined,
        //     ),
        //     color: const Color.fromARGB(255, 255, 102, 0)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Feedpage(),
            Container(
              height: 2.0, // Height of the divider
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.white,
                    Colors.transparent,
                  ], // Define your gradient colors
                ),
              ),
            ),
            const CompanyDetails()
          ],
        ),
      ),
    );
  }
}

class CompanyDetails extends StatelessWidget {
  const CompanyDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF302c34),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              IconButton(
                  iconSize: 1,
                  onPressed: () {},
                  enableFeedback: false,
                  icon: Image.asset(
                    scale: 10,
                    'assets/Agthia.png',
                  )),
              Text(
                'Agthia',
                style: GoogleFonts.signikaNegative(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: Colors.white),
              ),
            ],
          ),
          // const SizedBox(
          //   height: 30,
          // ),
          const Row(
            children: [
              SizedBox(width: 10),
              Text(
                'Address',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(width: 10),
              Flexible(
                  child: Text(
                "AL-SHARQIA TOWER\nFLOOR 7 JABER AL MUBARAK\nSTREET, BLOCK 2\nKUWAIT CITY",
                style: GoogleFonts.signika(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                height: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      '   Contact',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.mail,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            children: [
                              TextSpan(
                                text: "Mail",
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    const String email =
                                        'petmeofficial.in@gmail.com';
                                    const String body =
                                        'I wanted to reach out because...';
                                    const String subject = 'Hello!';
                                    final Uri emailUri = Uri(
                                        scheme: 'mailto',
                                        path: email,
                                        query:
                                            'subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}');
                                    try {
                                      if (await canLaunchUrl(emailUri)) {
                                        await launchUrl(emailUri,
                                            mode:
                                                LaunchMode.externalApplication);
                                      } else {
                                        throw 'Could not launch $emailUri';
                                      }
                                      // ignore: empty_catches
                                    } catch (e) {}
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                height: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      '    Soicial',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Image.asset(
                              'assets/Instagram.png',
                              height: 30,
                              width: 30,
                            )),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: "Instagram",
                                
                                style: const TextStyle(
                                  color: Colors.white,overflow: TextOverflow.clip
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    final Uri url = Uri.parse(
                                        'https://www.instagram.com/pet.me_official');
                                    try {
                                      if (await canLaunchUrl(url)) {
                                        await launchUrl(url,
                                            mode: LaunchMode.inAppBrowserView);
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                      // ignore: empty_catches
                                    } catch (e) {}
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
