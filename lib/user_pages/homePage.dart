import 'package:agthia_slot_booking/user_pages/login_or_register.dart';
import 'package:agthia_slot_booking/user_pages/notification_page.dart';
import 'package:agthia_slot_booking/widgets/List/list.dart';
import 'package:agthia_slot_booking/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

int selectedindex = 0;

Future<void> signOut(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      duration: Duration(milliseconds: 500),
        backgroundColor: Color.fromARGB(255, 255, 102, 0),
        content: Text("Logout successfully")));

    Navigator.push(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => const LoginOrRegister()),
    );
  } on FirebaseAuthException catch (e) {
    showDialog(
      // ignore: use_build_context_synchronously
      context: context,
      builder: (context) => AlertDialog(title: Text(e.toString())),
    );
  }
}

class HomepageContent extends StatefulWidget {
  const HomepageContent({super.key});

  @override
  State<HomepageContent> createState() => _HomepageState();
}

class _HomepageState extends State<HomepageContent> {
  final PageController _pageController = PageController(viewportFraction: 0.7);
  double currentPageValue = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentPageValue = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            icon:
                const Icon(Icons.menu_open_rounded, color: Color(0xFF0f172b))),
        title: const Text(
          "Home",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationPage()));
              },
              icon: const Icon(
                Icons.notifications_active,
                color: Color(0xFF0f172b),
              ))
        ],
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Stack(children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(1),
                              blurRadius: 60,
                              offset: const Offset(10, 30),
                              spreadRadius: 0)
                        ],
                        color: Colors.white,
                        image: const DecorationImage(
                            image:
                                AssetImage('assets/pexels-photo-1099680.jpeg'),
                            fit: BoxFit.fitWidth)),
                    height: MediaQuery.of(context).size.height * 0.11,
                    width: MediaQuery.of(context).size.width * 0.89,
                    child: Row(
                      children: [
                        SizedBox(width: 17,),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.8,
                          height: 50,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            height: 200,
                            width: double.infinity,
                            child: const Center(
                              child: Text(
                                '     Hi, user!',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                child: ListView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    itemCount: sorting.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: ChoiceChip(
                                showCheckmark: false,
                                label: Text(sorting[index]),
                                selected: selectedindex == index,
                                onSelected: (bool selected) {
                                  setState(() {
                                    selectedindex = index;
                                  });
                                },
                                selectedColor:
                                    const Color.fromARGB(255, 255, 102, 0),
                                backgroundColor: Colors.grey.shade200,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                side: BorderSide.none,
                                labelStyle: TextStyle(
                                  color: selectedindex == index
                                      ? Colors.white
                                      : const Color.fromARGB(255, 134, 133, 133),
                                ),
                              )),
                              const SizedBox(width: 40)
                        ],
                      );
                    }),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.55,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      height: 350,
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.60,
                          ),
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 301,
                              width: 270,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                image: DecorationImage(
                                  image: AssetImage(pics[index]),
                                  fit: BoxFit.cover,
                                ),
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.grey.withOpacity(1),
                                //     blurRadius: 60,
                                //     offset: const Offset(10, 30),
                                //     spreadRadius: 0,
                                //   ),
                                // ],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    brands[index],
                                    style: GoogleFonts.notoSerifGeorgian(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  const SizedBox(height: 15)
                                ],
                              ),
                            );
                          }),
                      // child: ListView.builder(
                      //   clipBehavior: Clip.none,
                      //   scrollDirection: Axis.horizontal,
                      //   itemCount: 3,
                      //   itemBuilder: (context, index) {
                      //     return Padding(
                      //         padding: const EdgeInsets.all(20),
                      //         child:
                      //         );
                      //   },
                      // ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
