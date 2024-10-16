import 'package:agthia_slot_booking/user_pages/details.dart';
import 'package:agthia_slot_booking/user_pages/homePage.dart';
import 'package:agthia_slot_booking/user_pages/profile.dart';
import 'package:agthia_slot_booking/user_pages/searchPage.dart';
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
    const DetailsPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: pages[tappedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
                        size: 28,

                color: tappedIndex == 0
                    ? const Color.fromARGB(255, 255, 102, 0)
                    : Colors.grey),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search,
                        size: 28,

                color: tappedIndex == 1
                    ? const Color.fromARGB(255, 255, 102, 0)
                    : Colors.grey),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite,
            size: 28,
                color: tappedIndex == 2
                    ? const Color.fromARGB(255, 255, 102, 0)
                    : Colors.grey),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2,
                        size: 28,

                color: tappedIndex == 3
                    ? const Color.fromARGB(255, 255, 102, 0)
                    : Colors.grey),
            label: "",
          ),
        ],
        currentIndex: tappedIndex,
        selectedItemColor: const Color.fromARGB(255, 255, 102, 0),
        selectedIconTheme:
            const IconThemeData(color: Color.fromARGB(255, 255, 102, 0)),
        onTap: itemTapped,
      ),
    ));
  }
}
