import 'dart:io';
import 'package:agthia_slot_booking/firebase_services/services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

final ImagePicker picker = ImagePicker();

XFile? imagefile;

String? imageUrl;

final storage = FirebaseStorage.instance;

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  bool isLoading = false;

  Future uploadFile() async {
    if (imagefile == null) return;
    final File file = File(imagefile!.path);
    final fileName = basename("Banner1");
    final destination = 'files/$fileName';

    try {
      setState(() {
        isLoading = true;
      });

      final ref = FirebaseStorage.instance.ref(destination);
      final uploadTask = ref.putFile(file);

      // Track upload progress (optional)
      uploadTask.snapshotEvents.listen((event) {
        double progress = event.bytesTransferred / event.totalBytes;
        print("Upload progress: $progress");
      });

      await uploadTask;
      await getimageUrl();
    } catch (e) {
      print('Error occurred while uploading: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> pickImage(context) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Gallery'),
                  onTap: () {
                    getimage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  Future<void> getimage(ImageSource source) async {
    final XFile? pickedimage = await picker.pickImage(source: source);
    if (pickedimage != null) {
      setState(() {
        imagefile = pickedimage;
        uploadFile();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getimageUrl();
  }

  Future<void> getimageUrl() async {
    try {
      final reff = storage.ref("files").child("Banner1");
      final url = await reff.getDownloadURL();
      setState(() {
        imageUrl = url;
      });
    } catch (e) {
      print('Failed to get image URL: $e');
      setState(() {
        imageUrl = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                signOut(context);
              },
              icon: const Icon(
                Icons.logout_sharp,
                color: Colors.white,
                size: 54,
              )),
        ],
      ),
      backgroundColor: Colors.amber,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () {
              pickImage(context);
            },
            child: const SizedBox(
                height: 100,
                child: Icon(
                  Icons.file_upload_outlined,
                  size: 50,
                )),
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            height: 300,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            alignment: Alignment.center,
            child: isLoading
                ? const CircularProgressIndicator()
                : (imageUrl != null && imageUrl!.isNotEmpty)
                    ? Image.network(imageUrl!)
                    : const Text('No Image Available'),
          ),
        ],
      ),
    );
  }
}
