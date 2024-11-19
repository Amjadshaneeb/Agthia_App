import 'package:agthia_slot_booking/user_pages/company_Pages/about_us.dart';
import 'package:agthia_slot_booking/user_pages/company_Pages/contact_us.dart';
import 'package:agthia_slot_booking/user_pages/company_Pages/word_of_chairman.dart';
import 'package:agthia_slot_booking/user_pages/home_page_content.dart';
import 'package:agthia_slot_booking/user_pages/search_page.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

int tappedIndex = 0;

class _HomepageState extends State<Homepage> {
  void itemTapped(int index) {
    setState(() {
      tappedIndex = index;
    });
  }

  final List<Widget> pages = [
    const HomepageContent(),
    const Searchpage(),
    const AboutUs(),
    const ContactUsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: pages[tappedIndex],
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF302c34),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(4, (index) {
            bool isSelected = tappedIndex == index;

            return ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      tappedIndex = index;
                    });
                  },
                  splashColor:
                      const Color.fromARGB(255, 255, 102, 0).withOpacity(0.3),
                  child: AnimatedContainer(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    padding: EdgeInsets.all(isSelected ? 13.0 : 9.0),
                    child: Icon(
                      _getIconForIndex(index),
                      size: 28,
                      color: isSelected
                          ? const Color.fromARGB(255, 255, 102, 0)
                          : Colors.grey,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    ));
  }

  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.home;
      case 1:
        return Icons.search;
      case 2:
        return Icons.info;
      case 3:
        return Icons.person_2;
      default:
        return Icons.home;
    }
  }
}
