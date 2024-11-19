import 'package:agthia_slot_booking/admin_pages/admin_home.dart';
import 'package:agthia_slot_booking/user_pages/home_page_content.dart';
import 'package:agthia_slot_booking/widgets/controllers.dart';
import 'package:agthia_slot_booking/widgets/provider.dart';
import 'package:agthia_slot_booking/widgets/textField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

final firestore = FirebaseFirestore.instance;

class CareerEdit extends StatefulWidget {
  const CareerEdit({super.key});

  @override
  State<CareerEdit> createState() => _CareerEditState();
}

class _CareerEditState extends State<CareerEdit> {
  @override
  void initState() {
    super.initState();
    loadCareer();
  }

  Future<void> loadCareer() async {
    try {
      // Fetch the existing data from Firestore
      DocumentSnapshot doc =
          await firebaseFirestore.collection("Career").doc("career").get();
      if (doc.exists && doc.data() != null) {
        setState(() {
          careerController.text =
              doc['career'] ?? ''; // Set the retrieved data to the controller
          isLoading = false;
        });
      } else {
        print("Document not found or empty");
      }
    } catch (e) {
      print("Failed to load data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> editCareer() async {
    try {
      // Trigger loading indicator

      await firebaseFirestore
          .collection("Career")
          .doc("career")
          .set({"career": careerController.text});

      print("Document successfully updated!");
    } catch (e) {
      print("Failed to update document: $e");
    } finally {
      // Turn off loading indicator
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AdminHome()));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color.fromARGB(255, 255, 102, 0),
            )),
        centerTitle: true,
        title: const Text("Career"),
      ),
      body: Consumer<ImagePickerProvider>(builder: (context, provider, child) {
        return Column(
          children: [
            if (provider.pickedImage != null) ...[
              SizedBox(
                height: 20,
              ),
              Image.file(
                provider.pickedImage!,
                height: 200,
                fit: BoxFit.cover,
              ),
            ] else
              Text(
                'No image selected',
                style: TextStyle(color: Colors.white),
              ),

            SizedBox(
              height: 40,
            ),

            ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                        Color.fromARGB(255, 255, 102, 0))),
                onPressed: () {
                  provider.pickImage();
                },
                child: Text(
                  "Upload New Image",
                  style: TextStyle(color: Colors.white),
                )),

            Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Mytextfield(
                  maxlines: 6,
                  textStyle: const TextStyle(color: Colors.white),
                  hinttext: "Content",
                  obscure: false,
                  controller: careerController,
                ),
              ),
            ),
            TextButton(
              style: const ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(Color.fromARGB(255, 255, 102, 0))),
              onPressed: () {
                setState(() {
                  editCareer();
                  provider.pickAndUploadImage(context, "Career Banner");
                  dispose();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => AdminHome()));
                });
              },
              child: const Text("Save", style: TextStyle(color: Colors.white)),
            )
            // Center(
            //   child: Mytextfield(
            //     hinttext: "Content",
            //     obscure: false,
            //     controller: aboutusController,
            //   ),
            // ),
          ],
        );
      }),
    );
  }
}
