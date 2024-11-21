import 'package:agthia_slot_booking/admin_pages/about_us.dart';
import 'package:agthia_slot_booking/admin_pages/admin_home.dart';
import 'package:agthia_slot_booking/widgets/controllers.dart';
import 'package:agthia_slot_booking/widgets/provider.dart';
import 'package:agthia_slot_booking/widgets/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsEditpage extends StatefulWidget {
  const NewsEditpage({super.key});

  @override
  State<NewsEditpage> createState() => _NewsEditpageState();
}

class _NewsEditpageState extends State<NewsEditpage> {
  @override
  void initState() {
    super.initState();
    loadNewsData();
  }

  Future<void> loadNewsData() async {
    try {
      // Fetch the existing data from Firestore
      DocumentSnapshot doc =
          await firebaseFirestore.collection("Latest News").doc("News").get();
      if (doc.exists && doc.data() != null) {
        setState(() {
          newsController.text =
              doc['News'] ?? ''; // Set the retrieved data to the controller
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

  Future<void> editNews() async {
    try {
      // Trigger loading indicator

      await firebaseFirestore
          .collection("Latest News")
          .doc("News")
          .set({"News": newsController.text});

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
                  MaterialPageRoute(builder: (context) => const AdminHome()));
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color.fromARGB(255, 255, 102, 0),
            )),
        centerTitle: true,
        title: const Text("News"),
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
                  controller: newsController,
                ),
              ),
            ),
            TextButton(
              style: const ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(Color.fromARGB(255, 255, 102, 0))),
              onPressed: () {
                setState(() {
                  editNews();
                  provider.pickAndUploadImage(context, "News Banner");
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
