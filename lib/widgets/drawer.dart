import 'package:agthia_slot_booking/User_pages/homePage.dart';
import 'package:agthia_slot_booking/user_pages/company_Pages/about_us.dart';
import 'package:agthia_slot_booking/user_pages/company_Pages/contact_us.dart';
import 'package:agthia_slot_booking/user_pages/settings.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const LinearBorder(),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 245,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF0f172b),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CircleAvatar(radius: 40),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ))
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Amjad Shaneeb',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    'amjadshaneeb@gmail.com',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.diversity_1_sharp),
            title: const Text('About Us'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AboutUsPage()));
            },
          ),
          ListTile(
            leading: Hero(tag: "call", child: const Icon(Icons.call_sharp)),
            title: Hero(tag: "Text", child: const Text('Contact Us')),
            onTap: () {
              Navigator.push(
                  context,
                  CustomPageRoute(
                      builder: (context) => ContactUsPage(),
                      duration: Duration(seconds: 1)));
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.28),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: const Text(
              'LogOut',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              signOut(context);
            },
          ),
        ],
      ),
    );
  }
}
