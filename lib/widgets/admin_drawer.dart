import 'package:agthia_slot_booking/admin_pages/about_us.dart';
import 'package:agthia_slot_booking/admin_pages/add_restaurant.dart';
import 'package:agthia_slot_booking/admin_pages/career_edit.dart';
import 'package:agthia_slot_booking/admin_pages/edit_word_of_chairman.dart';
import 'package:agthia_slot_booking/admin_pages/news_editpage.dart';
import 'package:agthia_slot_booking/admin_pages/our_people.dart';
import 'package:agthia_slot_booking/admin_pages/subscribers.dart';
import 'package:flutter/material.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF302c34),
      shape: const LinearBorder(),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(
            height: 245,
            child: DrawerHeader(
              decoration: BoxDecoration(
                  color: Color(0xFF0f172b),
                  image: DecorationImage(
                      image: AssetImage("assets/Agthia_logo.png"))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              color: Color.fromARGB(255, 255, 102, 0),
            ),
            title: const Text('Home', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.newspaper,
              color: Color.fromARGB(255, 255, 102, 0),
            ),
            title: const Text('Latest News',
                style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NewsEditpage()));
            },
          ),

          ListTile(
            leading: const Icon(
              Icons.group,
              color: Color.fromARGB(255, 255, 102, 0),
            ),
            title:
                const Text('Our People', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const OurPeopleEditPage()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.info,
              color: Color.fromARGB(255, 255, 102, 0),
            ),
            title:
                const Text('About Us', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AboutUsEdit()));
              // context,
              // CustomPageRoute(
              //     builder: (context) => ContactUsClass(),
              //     duration: Duration(seconds: 1)));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.add_box,
              color: Color.fromARGB(255, 255, 102, 0),
            ),
            title:
                const Text('Add brand', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddRestaurantPage()));
              // context,
              // CustomPageRoute(
              //     builder: (context) => ContactUsClass(),
              //     duration: Duration(seconds: 1)));
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.call_outlined),
          //   title: const Text('Contact Us'),
          //   onTap: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => ContactUsPage()));
          //   },
          // ),
          ListTile(
            leading: const Icon(
              Icons.work_outline,
              color: Color.fromARGB(255, 255, 102, 0),
            ),
            title: const Text('Career', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CareerEdit()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.supervisor_account_outlined,
              color: Color.fromARGB(255, 255, 102, 0),
            ),
            title: const Text('Word of chairman',
                style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditWordOfChairman()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.subscriptions,
              color: Color.fromARGB(255, 255, 102, 0),
            ),
            title: const Text('Subscribers',
                style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SubscribersPage()));
            },
          ),
          // SizedBox(height: MediaQuery.of(context).size.height * 0.28),
          // ListTile(
          //   leading: const Icon(
          //     Icons.logout,
          //     color: Colors.red,
          //   ),
          //   title: const Text(
          //     'LogOut',
          //     style: TextStyle(color: Colors.red),
          //   ),
          //   onTap: () {
          //     signOut(context);
          //   },
          // ),
        ],
      ),
    );
  }
}
