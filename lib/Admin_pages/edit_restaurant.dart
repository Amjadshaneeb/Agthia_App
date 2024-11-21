import 'dart:io';
import 'package:agthia_slot_booking/Admin_pages/admin_Home.dart';
import 'package:agthia_slot_booking/user_pages/search_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:agthia_slot_booking/widgets/controllers.dart';
import 'package:agthia_slot_booking/widgets/text_field.dart';

String? brandType;
final ImagePicker _picker = ImagePicker();
File? _selectedImage;
String? _imageUrl;

class EditRestaurantScreen extends StatefulWidget {
  const EditRestaurantScreen({super.key, required this.brand});

  final Map<String, String> brand;
  @override
  State<EditRestaurantScreen> createState() => _EditRestaurantScreenState();
}

class _EditRestaurantScreenState extends State<EditRestaurantScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    // Pre-fill the form fields with the existing brand data
    nameController.text = widget.brand['Name'] ?? '';
    homePageOrderController.text = widget.brand['Index'] ?? '';
    reservationController.text = widget.brand['Reservation'] ?? '';
    facebookLinkController.text = widget.brand['Facebook'] ?? '';
    instagramLinkController.text = widget.brand['Instagram'] ?? '';
    twitterLinkController.text = widget.brand['Twitter'] ?? '';
    descriptionController.text = widget.brand['Description'] ?? '';

    if (widget.brand['Url'] != null && widget.brand['Url']!.isNotEmpty) {
      _imageUrl = widget.brand['Url'];
    }
  }

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

  Future<String> uploadImage(File imageFile) async {
    // Create a reference to Firebase Storage
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('brand_images/${DateTime.now().millisecondsSinceEpoch}.jpg');

    // Upload the image
    final uploadTask = storageRef.putFile(imageFile);

    // Wait for upload to complete and get the download URL
    final snapshot = await uploadTask.whenComplete(() {});
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> saveBrandData() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Use existing image URL if no new image is selected
      String imageUrl = widget.brand['Url'] ?? '';

      if (_selectedImage != null) {
        imageUrl = await uploadImage(_selectedImage!);
      }

      // Prepare updated data
      final updatedData = {
        "Name": nameController.text.trim(),
        "Index": homePageOrderController.text.trim(),
        "Reservation": reservationController.text.trim(),
        "Facebook": facebookLinkController.text.trim(),
        "Description": descriptionController.text.trim(),
        "Twitter": twitterLinkController.text.trim(),
        "Instagram": instagramLinkController.text.trim(),
        "Brand Type": brandType,
      };

      // Always include the image URL (existing or newly uploaded)
      updatedData["Url"] = imageUrl;

      // Determine collection based on brandType
      final collectionName =
          brandType == 'Local' ? "Local Brand" : 'InterNational Brand';
      final originalDocId = widget.brand['Name']; // Original docId
      final newDocId = nameController.text.trim(); // New docId

      final firestore = FirebaseFirestore.instance;
      final collectionRef = firestore.collection(collectionName);

      if (originalDocId != newDocId) {
        // Get original document's data
        final originalDocSnapshot =
            await collectionRef.doc(originalDocId).get();
        if (originalDocSnapshot.exists) {
          // Create new document with updated ID and data
          await collectionRef.doc(newDocId).set(updatedData);

          // Delete original document
          await collectionRef.doc(originalDocId).delete();
        } else {
          throw 'Original document does not exist';
        }
      } else {
        // Simply update the document if ID hasn't changed
        await collectionRef.doc(originalDocId).update(updatedData);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(milliseconds: 500),
          backgroundColor: Color.fromARGB(255, 255, 102, 0),
          content: Text('Brand updated successfully!'),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AdminHome()),
      );
    } catch (error) {
      print("Error updating brand: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: 500),
          backgroundColor: Color.fromARGB(255, 255, 102, 0),
          content: Text('Failed to update brand: $error'),
        ),
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
        forceMaterialTransparency: true,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AdminHome()),
            );
          },
          icon: const Icon(Icons.arrow_back_ios,
              color: Color.fromARGB(255, 255, 102, 0)),
        ),
        title: Text('Edit Restaurant',
            style: GoogleFonts.sora(fontWeight: FontWeight.bold)),
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
                        if (_selectedImage != null) ...[
                          const SizedBox(height: 20),
                          Image.file(
                            _selectedImage!,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ] else if (_imageUrl != null &&
                            _imageUrl!.isNotEmpty) ...[
                          const SizedBox(height: 20),
                          Image.network(
                            _imageUrl!,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ] else ...[
                          const SizedBox(height: 20),
                          const Text(
                            'No image selected',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                                Color.fromARGB(255, 255, 102, 0)),
                          ),
                          onPressed: pickImage,
                          child: const Text("Choose File",
                              style: TextStyle(color: Colors.white)),
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
              const SizedBox(height: 10),
              Center(
                child: SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            Color.fromARGB(255, 255, 102, 0))),
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        await saveBrandData();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AdminHome()),
                        );
                      } else {
                        print("One or more fields are invalid");
                      }
                    },
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                                color: Color.fromARGB(255, 255, 102, 0), strokeWidth: 2),
                          )
                        : const Text("Save",
                            style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
