import 'package:agthia_slot_booking/user_pages/details.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({super.key});

  @override
  BrandSearchPageState createState() => BrandSearchPageState();
}

class BrandSearchPageState extends State<Searchpage> {
  String searchQuery = '';
  List<Map<String, dynamic>> searchResults = [];

  bool isLoading = false; // State to track loading

  void searchBrands() async {
    setState(() {
      isLoading = true; // Show loading indicator
    });

    try {
      // Fetch data from Firestore for international brands
      final internationalResults = await FirebaseFirestore.instance
          .collection('InterNational Brand')
          .where('Name', isEqualTo: searchQuery)
          .get();

      // Fetch data from Firestore for local brands
      final localResults = await FirebaseFirestore.instance
          .collection('Local Brand')
          .where('Name', isEqualTo: searchQuery)
          .get();

      // Combine results from both collections
      final allResults = [
        ...internationalResults.docs
            .map((doc) => {
                  'Name': doc['Name']?.toString() ?? 'No Name',
                  'Url': doc['Url']?.toString() ?? '',
                  'Facebook': doc['Facebook']?.toString() ?? '',
                  'Instagram': doc['Instagram']?.toString() ?? '',
                  'Reservation': doc['Reservation']?.toString() ?? '',
                  'Twitter': doc['Twitter']?.toString() ?? '',
                  'Description':
                      doc['Description']?.toString() ?? 'No Description'
                })
            .toList(),
        ...localResults.docs
            .map((doc) => {
                  'Name': doc['Name']?.toString() ?? 'No Name',
                  'Url': doc['Url']?.toString() ?? '',
                  'Facebook': doc['Facebook']?.toString() ?? '',
                  'Instagram': doc['Instagram']?.toString() ?? '',
                  'Reservation': doc['Reservation']?.toString() ?? '',
                  'Twitter': doc['Twitter']?.toString() ?? '',
                  'Description':
                      doc['Description']?.toString() ?? 'No Description'
                })
            .toList(),
      ];

      // Update the state with the combined results
      setState(() {
        searchResults = allResults;
      });
    } catch (e) {
      // Handle any errors that occur during the query process
      print('Error occurred while fetching brand data: $e');

      // Optionally show an error message in the UI (e.g., using a SnackBar or AlertDialog)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No Brand Found')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF302c34),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "What are you looking for?",
              style: GoogleFonts.ubuntu(
                  color: Colors.white,
                  wordSpacing: 5,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              inputFormatters: [UpperCaseTextFormatter()],
              decoration: InputDecoration(
                  labelText: 'Enter brand name',
                  labelStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                  focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 255, 102, 0)))),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          ElevatedButton(
            style: const ButtonStyle(
                backgroundColor:
                    WidgetStatePropertyAll(Color.fromARGB(255, 255, 102, 0))),
            onPressed: () {
              if (searchQuery.isNotEmpty) {
                searchBrands();
              } else {
                setState(() {
                  searchResults.clear();
                });
              }
            },
            child: isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Text(
                    'Search',
                    style: TextStyle(color: Colors.white),
                  ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final brandData = searchResults[index];

                String imageUrl = brandData['Url'] ?? '';
                String brandName = brandData['Name'] ?? 'No brand found';
                String reservationLink = brandData['Reservation'] ?? '';
                String twitterLink = brandData['Twitter'] ?? '';
                String instagramLink = brandData['Instagram'] ?? '';
                String facebookLink = brandData['Facebook'] ?? '';
                String description = brandData['Description'] ?? '';

                return ListTile(
                  title: Text(
                    brandName,
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(
                          isAdmin: false,
                          brandName: brandName,
                          imageUrl: imageUrl,
                          description: description,
                          reservationLink: reservationLink,
                          instagramLink: instagramLink,
                          twitterLink: twitterLink,
                          facebookLink: facebookLink,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
