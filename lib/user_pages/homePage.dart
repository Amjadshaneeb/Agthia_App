import 'package:agthia_slot_booking/Admin_pages/admin_Home.dart';
import 'package:agthia_slot_booking/user_pages/notification_page.dart';
import 'package:agthia_slot_booking/widgets/List/list.dart';
import 'package:agthia_slot_booking/widgets/carousal.dart';
import 'package:agthia_slot_booking/widgets/drawer.dart';
import 'package:flutter/material.dart';

int selectedindex = 0;

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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
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
                            blurRadius: 15,
                            spreadRadius: 0,
                          ),
                        ],
                        color: Colors.white,
                        image: imageUrl != null && imageUrl!.isNotEmpty
                            ? DecorationImage(
                                image: NetworkImage(imageUrl!),
                                fit: BoxFit.fitWidth,
                              )
                            : null,
                      ),
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width * 0.89,
                      child: imageUrl == null || imageUrl!.isEmpty
                          ? Center(
                              child: Text(
                                  'No Image Available')) 
                          : null, 
                    ),
                  ]),
                )
              ],
            ),
            // const SizedBox(
            //   height: 10,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.96,
                  child: ListView.builder(
                      controller: _pageController,
                      scrollDirection: Axis.horizontal,
                      itemCount: sorting.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
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
                                        : const Color.fromARGB(
                                            255, 134, 133, 133),
                                  ),
                                )),
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
                    child: const SizedBox(
                      height: 350,
                      child: CarousalContainer(),

                      // child: ListView.builder(
                      //   clipBehavior: Clip.none,
                      //   scrollDirection: Axis.horizontal,
                      //   itemCount: 4,
                      //   itemBuilder: (context, index) {
                      //     return Padding(
                      //         padding: const EdgeInsets.all(20),
                      //         child:Container(
                      //         height: 301,
                      //         width: 270,
                      //         decoration: BoxDecoration(
                      //           color: Colors.black,
                      //           image: DecorationImage(
                      //             image: AssetImage(pics[index]),
                      //             fit: BoxFit.cover,
                      //           ),
                      //           boxShadow: [
                      //             BoxShadow(
                      //               color: Colors.grey.withOpacity(1),
                      //               blurRadius: 60,
                      //               offset: const Offset(10, 30),
                      //               spreadRadius: 0,
                      //             ),
                      //           ],
                      //           borderRadius: BorderRadius.circular(8),
                      //         ),
                      //         child: Column(
                      //           mainAxisAlignment: MainAxisAlignment.end,
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Text(
                      //               brands[index],
                      //               style: GoogleFonts.notoSerifGeorgian(
                      //                   color: Colors.white,
                      //                   fontWeight: FontWeight.bold,
                      //                   fontSize: 20),
                      //             ),
                      //             const SizedBox(height: 15)
                      //           ],
                      //         ),
                      //       )
                      //         );
                      //   },
                      // ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
