import 'dart:io';
import 'package:agthia_slot_booking/Admin_pages/admin_Home.dart';
import 'package:agthia_slot_booking/user_pages/search_page.dart';
import 'package:agthia_slot_booking/widgets/provider.dart';
import 'package:agthia_slot_booking/widgets/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

String? brandType;

final ImagePicker _picker = ImagePicker();

File? _selectedImage;

class AddRestaurantPage extends StatefulWidget {
  const AddRestaurantPage({super.key});

  @override
  State<AddRestaurantPage> createState() => _EditRestaurantScreenState();
}

class _EditRestaurantScreenState extends State<AddRestaurantPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController homePageOrderController = TextEditingController();
  TextEditingController facebookLinkController = TextEditingController();
  TextEditingController reservationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController twitterLinkController = TextEditingController();
  TextEditingController instagramLinkController = TextEditingController();

  bool isDropdownOpen = false;
  bool isLoading = false;

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }

  Future<void> saveImageAndText() async {
    setState(() {
      isLoading = true;
    });

    final urlValidator = Provider.of<BrandProvider>(context, listen: false);

    // Validate URLs
    final urls = {
      'Reservation': reservationController.text.trim(),
      'Facebook': facebookLinkController.text.trim(),
      'Instagram': instagramLinkController.text.trim(),
      'Twitter': twitterLinkController.text.trim(),
    };

    for (final entry in urls.entries) {
      if (entry.value.isNotEmpty) {
        final isValid = await urlValidator.isValidUrl(entry.value);
        if (!isValid) {
          setState(() {
            isLoading = false;
          });

          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: const Color(0xFF302c34),
              title: const Text('Invalid URL',
                  style: TextStyle(color: Colors.white)),
              content: Text(
                'The ${entry.key} URL is not valid. Please provide a correct URL.',
                style: const TextStyle(color: Colors.white),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 255, 102, 0)),
                  ),
                ),
              ],
            ),
          );

          return; // Exit the function early if a URL is invalid
        }
      }
    }

    // Check if Index already exists in the Firestore collection
    final collectionName =
        brandType == 'Local' ? "Local Brand" : 'InterNational Brand';

    final querySnapshot = await FirebaseFirestore.instance
        .collection(collectionName)
        .where("Index", isEqualTo: homePageOrderController.text.trim())
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      setState(() {
        isLoading = false;
      });

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: const Color(0xFF302c34),
          title: const Text('Index already exists',
              style: TextStyle(color: Colors.white)),
          content: const Text(
            'This index is already saved. Please choose a different index.',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'OK',
                style: TextStyle(color: const Color.fromARGB(255, 255, 102, 0)),
              ),
            ),
          ],
        ),
      );
      return; // Exit the function early if index exists
    }

    // Proceed with saving the image and text if the index doesn't exist
    if (_selectedImage != null && nameController.text.isNotEmpty) {
      final filename = 'image_${nameController.text}.jpg';
      final destination = 'Brands/$filename';
      final storageRef = FirebaseStorage.instance.ref(destination);

      await storageRef.putFile(_selectedImage!);

      final imageUrl = await storageRef.getDownloadURL();

      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(nameController.text)
          .set({
        "Name": nameController.text.trim(),
        "Index": homePageOrderController.text.trim(),
        "Reservation": reservationController.text.trim(),
        "Facebook": facebookLinkController.text.trim(),
        "Instagram": instagramLinkController.text.trim(),
        "Twitter": twitterLinkController.text.trim(),
        "Description": descriptionController.text.trim(),
        "Url": imageUrl,
        "BrandType": brandType,
      });

      setState(() {
        _selectedImage = null;
        nameController.clear();
        homePageOrderController.clear();
        reservationController.clear();
        facebookLinkController.clear();
        descriptionController.clear();
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(milliseconds: 500),
          backgroundColor: Color.fromARGB(255, 255, 102, 0),
          content: Text('Brand Added successfully!'),
        ),
      );

      // Navigate to Admin Home
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AdminHome()),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      print('Please select an image and enter text before saving.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF302c34),
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AdminHome()));
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color.fromARGB(255, 255, 102, 0),
            )),
        title: Text(
          'Add Restaurant',
          style: GoogleFonts.sora(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        Column(
                          children: [
                            if (_selectedImage != null) ...[
                              const SizedBox(
                                height: 20,
                              ),
                              Image.file(
                                _selectedImage!,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ] else
                              const Text(
                                'No image selected',
                                style: TextStyle(color: Colors.white),
                              ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                  Color.fromARGB(255, 255, 102, 0))),
                          onPressed: () async {
                            if (brandType != null) {
                              await pickImage();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor:
                                      Color.fromARGB(255, 255, 102, 0),
                                  content: Text(
                                      'Please select a Brand Type before proceeding!'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            "Choose File",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          items: ['International', 'Local']
                              .map((String category) =>
                                  DropdownMenuItem<String>(
                                    value: category,
                                    child: Text(
                                      category,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            brandType = value;
                            ValueNotifier(brandType);
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 255, 102, 0))),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 18, horizontal: 12),
                            hintStyle: TextStyle(color: Colors.white),
                            hintText: "Brand Type",
                          ),
                          value: brandType,
                          selectedItemBuilder: (BuildContext context) {
                            return ['International', 'Local']
                                .map<Widget>((String category) {
                              return Text(
                                category,
                                style: const TextStyle(color: Colors.white),
                              );
                            }).toList();
                          },
                        ),
                        const SizedBox(height: 16),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Mytextfield(
                                  inputFormatters: [UpperCaseTextFormatter()],
                                  hinttext: "Brand Name",
                                  obscure: false,
                                  controller: nameController,
                                  maxlines: 2),
                              const SizedBox(height: 16),
                              Mytextfield(
                                  numbers:
                                      const TextInputType.numberWithOptions(),
                                  hinttext: "Home page order",
                                  obscure: false,
                                  controller: homePageOrderController,
                                  maxlines: 2),
                              const SizedBox(height: 16),
                              Mytextfield(
                                  hinttext: "Reservation URL",
                                  obscure: false,
                                  controller: reservationController,
                                  maxlines: 2),
                              const SizedBox(height: 16),
                              Mytextfield(
                                  hinttext: "Facebook URL",
                                  obscure: false,
                                  controller: facebookLinkController,
                                  maxlines: 2),
                              const SizedBox(height: 16),
                              Mytextfield(
                                  hinttext: "Instagram URL",
                                  obscure: false,
                                  controller: instagramLinkController,
                                  maxlines: 2),
                              const SizedBox(height: 16),
                              Mytextfield(
                                  hinttext: "Twitter URL",
                                  obscure: false,
                                  controller: twitterLinkController,
                                  maxlines: 2),
                              const SizedBox(height: 16),
                              Mytextfield(
                                  hinttext: "Description",
                                  obscure: false,
                                  controller: descriptionController,
                                  maxlines: 2),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                      Color.fromARGB(255, 255, 102, 0),
                    )),
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        await saveImageAndText();
                      } else {
                        print("One or more fields are invalid");
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
                        : const Text("Save",
                            style: TextStyle(color: Colors.white)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
