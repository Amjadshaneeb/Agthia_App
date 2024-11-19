import 'package:agthia_slot_booking/user_pages/details.dart';
import 'package:agthia_slot_booking/user_pages/home_bottom_navigation.dart';
import 'package:agthia_slot_booking/widgets/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllRestaurantPage extends StatefulWidget {
  const AllRestaurantPage({super.key});

  @override
  State<AllRestaurantPage> createState() => _AllRestaurantPageState();
}

class _AllRestaurantPageState extends State<AllRestaurantPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF302c34),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Homepage()));
            },
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
            ),
            color: const Color.fromARGB(255, 255, 102, 0)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Consumer<BrandProvider>(
                builder: (context, provider, child) {
                  return FutureBuilder<List<Map<String, String>>>(
                    future: provider.getMergedBrandsData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Display a loading indicator while the future is in progress
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        // Display an error message if the future fails
                        return Center(
                          child: Text(
                            'Error: ${snapshot.error}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        // Handle the case where there is no data
                        return const Center(
                          child: Text(
                            'No data available',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }

                      // Safely use snapshot.data after confirming it's not null
                      List<Map<String, String>> brandData = snapshot.data!;
                      return ListView.builder(
                        itemCount: brandData.length,
                        itemBuilder: (context, index) {
                          String? imageUrl = brandData[index]['Url'] ?? '';
                          String brandName = brandData[index]['Name'] ?? '';
                          String reservationLink =
                              brandData[index]['Reservation'] ?? '';
                          String twitterLink =
                              brandData[index]['Twitter'] ?? '';
                          String instagramLink =
                              brandData[index]['Instagram'] ?? '';
                          String facebookLink =
                              brandData[index]['Facebook'] ?? '';
                          String description =
                              brandData[index]['Description'] ?? '';

                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: imageUrl.isNotEmpty
                                  ? NetworkImage(imageUrl)
                                  : const AssetImage('assets/default_image.png')
                                      as ImageProvider, // Fallback image if URL is empty
                            ),
                            title: Text(
                              brandName,
                              style: const TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsPage(
                                    imageUrl: imageUrl,
                                    brandName: brandName,
                                    description: description,
                                    reservationLink: reservationLink,
                                    instagramLink: instagramLink,
                                    twitterLink: twitterLink,
                                    facebookLink: facebookLink,
                                    isAdmin: false,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
