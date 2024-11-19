import 'package:agthia_slot_booking/admin_pages/admin_home.dart';
import 'package:agthia_slot_booking/widgets/provider.dart';
import 'package:agthia_slot_booking/widgets/textField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

bool isLoading = false;

class AboutUsEdit extends StatefulWidget {
  const AboutUsEdit({super.key});

  @override
  State<AboutUsEdit> createState() => _AboutUsEditState();
}

class _AboutUsEditState extends State<AboutUsEdit> {
  @override
  void initState() {
    super.initState();
    loadAboutUs();
  }

  Future<void> loadAboutUs() async {
    try {
      // Fetch the existing data from Firestore
      DocumentSnapshot doc =
          await firebaseFirestore.collection("Company").doc("AboutUs").get();
      if (doc.exists && doc.data() != null) {
        setState(() {
          aboutusController.text =
              doc['AboutUs'] ?? ''; // Set the retrieved data to the controller
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

  Future<void> editAboutUs() async {
    try {
      setState(() {
        isLoading = true;
      });

      await firebaseFirestore
          .collection("Company")
          .doc("AboutUs")
          .set({"AboutUs": aboutusController.text});

      print("Document successfully updated!");
    } catch (e) {
      print("Failed to update document: $e");
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AdminHome()));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color.fromARGB(255, 255, 102, 0),
            )),
        centerTitle: true,
        title: const Text("About Us"),
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
                  controller: aboutusController,
                ),
              ),
            ),
            TextButton(
              style: const ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(Color.fromARGB(255, 255, 102, 0))),
              onPressed: () {
                setState(() {
                  editAboutUs();
                  provider.pickAndUploadImage(context, "AboutUs Banner");
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
