import 'package:agthia_slot_booking/user_pages/company_Pages/about_us.dart';
import 'package:agthia_slot_booking/user_pages/company_Pages/contact_us.dart';
import 'package:agthia_slot_booking/user_pages/company_Pages/ourpeople.dart';
import 'package:agthia_slot_booking/user_pages/company_Pages/subscribe.dart';
import 'package:agthia_slot_booking/user_pages/company_Pages/word_of_chairman.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

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
            leading: const Icon(Icons.home, color: Colors.white),
            title: const Text('Home', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading:
                const Icon(Icons.import_contacts_outlined, color: Colors.white),
            title: const Text(
              'Word of chairman',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WordOfChairman()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.group,
              color: Colors.white,
            ),
            title: const Text(
              'Our People',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => OurpeoplePage()));
            },
          ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.group,
          //     color: Colors.white,
          //   ),
          //   title: const Text(
          //     'Subscribe',
          //     style: TextStyle(color: Colors.white),
          //   ),
          //   onTap: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => SubscribeBottomSheetDemo()));
          //   },
          // ),
        ],
      ),
    );
  }
}
