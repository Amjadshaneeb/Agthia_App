// ignore_for_file: avoid_print

import 'dart:io';
import 'package:agthia_slot_booking/admin_pages/admin_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
final TextEditingController aboutusController = TextEditingController();
final FirebaseStorage storage = FirebaseStorage.instance;

class FunctionProvider extends ChangeNotifier {
  List<String> picsList = [];
  String? imageUrl;

  Future<void> getImage(ImageSource source, String filename) async {
    final XFile? pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      imagefile = pickedImage;
      notifyListeners();
      bannerUploadFile();
    }
  }

  Future<void> bannerUploadFile() async {
    if (imagefile == null) {
      const Text("No image selected");
      return;
    }

    final File file = File(imagefile!.path);
    const filename = "Banners";
    const destination = 'files/$filename';

    try {
      final ref = storage.ref(destination);
      final uploadFile = ref.putFile(file);

      uploadFile.snapshotEvents.listen((event) {
        double progress = event.bytesTransferred / event.totalBytes;
        print("Upload progress: $progress");
      });

      final snapshot = await uploadFile;
      if (snapshot.state == TaskState.success) {
        print("Upload successful");
        await getBannerImageUrl();
      } else {
        print("Upload failed");
      }
    } catch (e) {
      print('Error occurred while uploading: $e');
    }
  }

  Future<void> getBannerImageUrl() async {
    try {
      final ListResult result = await storage.ref("files").listAll();
      for (var ref in result.items) {
        if (ref.name == "Banners") {
          final bannerUrl = await ref.getDownloadURL();
          imageUrl = bannerUrl;
          notifyListeners();
          return;
        }
      }
      print("No matching file found in Banners directory.");
      imageUrl = "";
      notifyListeners();
    } catch (e) {
      print('Failed to get image URL: $e');
    }
  }

  Future<void> pickImage(BuildContext context, String filename) async {
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
                  getImage(ImageSource.gallery, filename);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class BrandProvider extends ChangeNotifier {
  Future<bool> isValidUrl(String url) async {
    final Uri? uri = Uri.tryParse(url);
    
    if (uri == null || (uri.scheme != 'http' && uri.scheme != 'https')) {
      return false;
    }

    try {
      final response = await http.head(uri).timeout(const Duration(seconds: 5));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<List<Map<String, String>>> getMergedBrandsData() async {
    try {
      // References to Firestore collections
      final CollectionReference collection1 =
          FirebaseFirestore.instance.collection("InterNational Brand");
      final CollectionReference collection2 =
          FirebaseFirestore.instance.collection("Local Brand");

      // Fetch data from both collections concurrently
      final results = await Future.wait([
        collection1.get(),
        collection2.get(),
      ]);

      // Combine data from both collections
      List<Map<String, String>> mergedData = [];

      for (var snapshot in results) {
        for (var doc in snapshot.docs) {
          final data = doc.data() as Map<String, dynamic>;
          mergedData.add({
            'Name': data['Name']?.toString() ?? 'No Name',
            'Url': data['Url']?.toString() ?? '',
            'Facebook': data['Facebook']?.toString() ?? '',
            'Instagram': data['Instagram']?.toString() ?? '',
            'Reservation': data['Reservation']?.toString() ?? '',
            'Twitter': data['Twitter']?.toString() ?? '',
            'Description': data['Description']?.toString() ?? 'No Description'
          });
        }
      }

      return mergedData;
    } catch (e, stacktrace) {
      // Log the error and return an empty list
      print('Error fetching data: $e');
      print(stacktrace);
      return [];
    }
  }

  Future<List<Map<String, String>>> getBrandsWithImages(
      String collectionName) async {
    try {
      final CollectionReference collection =
          FirebaseFirestore.instance.collection(collectionName);

      final QuerySnapshot snapshot = await collection.get();

      List<Map<String, String>> brandData = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        return {
          'Name': data['Name']?.toString() ?? 'No Name',
          'Index': data['Index']?.toString() ?? '',
          'Url': data['Url']?.toString() ?? '',
          'Facebook': data['Facebook']?.toString() ?? '',
          'Instagram': data['Instagram']?.toString() ?? '',
          'Reservation': data['Reservation']?.toString() ?? '',
          'Twitter': data['Twitter']?.toString() ?? '',
          'Description': data['Description']?.toString() ?? 'No Description'
        };
      }).toList();

      brandData.sort((a, b) {
        int indexA = int.tryParse(a['Index'] ?? '0') ?? 0;
        int indexB = int.tryParse(b['Index'] ?? '0') ?? 0;
        return indexA.compareTo(indexB);
      });

      return brandData;
    } catch (e, stacktrace) {
      print('Error getting brand data from Firestore: $e');
      print(stacktrace);
      return [];
    }
  }
}

class ImagePickerProvider extends ChangeNotifier {
  File? get pickedImage => _imageFile;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
      notifyListeners();
    } else {
      print('No image selected.');
    }
  }

  Future<void> pickAndUploadImage(BuildContext context, String fileName) async {
    if (_imageFile != null) {
      try {
        final String filePath = 'uploads/$fileName';
        final Reference storageRef = FirebaseStorage.instance.ref(filePath);

        final UploadTask uploadTask = storageRef.putFile(_imageFile!);
        final TaskSnapshot downloadUrl = await uploadTask;
        final String url = await downloadUrl.ref.getDownloadURL();

        print('Image uploaded successfully. URL: $url');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              duration: Duration(milliseconds: 500),
              backgroundColor: Color.fromARGB(255, 255, 102, 0),
              content: Text('Image uploaded successfully!')),
        );
      } catch (e) {
        print('Failed to upload image: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              duration: Duration(milliseconds: 500),
              backgroundColor: Color.fromARGB(255, 255, 102, 0),
              content: Text('Failed to upload image')),
        );
      }
    } else {
      print('No image selected.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            duration: Duration(milliseconds: 500),
            backgroundColor: Color.fromARGB(255, 255, 102, 0),
            content: Text('Please select an image first')),
      );
    }
  }
}

class BannerProvider extends ChangeNotifier {
  String? careerBanner;
  String? newsBanner;
  String? chairmanBanner;
  String? ourpeopleBanner;
  String? aboutUsBanner;

  Future<void> getCareerImages() async {
    try {
      final ListResult result = await storage.ref("uploads/").listAll();
      for (var ref in result.items) {
        if (ref.name == "Career Banner") {
          final bannerUrl = await ref.getDownloadURL();
          careerBanner = bannerUrl;
          notifyListeners();
          print("Banner image URL: $careerBanner");
          return;
        }
      }
      careerBanner = "";
      notifyListeners();
    } catch (e) {
      print('Failed to get image URL: $e');
    }
  }

  Future<void> getNewsImages() async {
    try {
      final ListResult result = await storage.ref("uploads/").listAll();
      for (var ref in result.items) {
        if (ref.name == "News Banner") {
          final bannerUrl = await ref.getDownloadURL();
          newsBanner = bannerUrl;
          notifyListeners();
          print("Banner image URL: $newsBanner");
          return;
        }
      }
      newsBanner = "";
      notifyListeners();
    } catch (e) {
      print('Failed to get image URL: $e');
    }
  }

  Future<void> getOurpeopleImages() async {
    try {
      final ListResult result = await storage.ref("uploads/").listAll();
      for (var ref in result.items) {
        if (ref.name == "OurPeople Banner") {
          final bannerUrl = await ref.getDownloadURL();
          ourpeopleBanner = bannerUrl;
          notifyListeners();
          print("Banner image URL: $ourpeopleBanner");
          return;
        }
      }
      ourpeopleBanner = "";
      notifyListeners();
    } catch (e) {
      print('Failed to get image URL: $e');
    }
  }

  Future<void> getChairmanImages() async {
    try {
      final ListResult result = await storage.ref("uploads/").listAll();
      for (var ref in result.items) {
        if (ref.name == "Chairman Banner") {
          final bannerUrl = await ref.getDownloadURL();
          chairmanBanner = bannerUrl;
          notifyListeners();
          print("Banner image URL: $chairmanBanner");
          return;
        }
      }
      chairmanBanner = "";
      notifyListeners();
    } catch (e) {
      print('Failed to get image URL: $e');
    }
  }

  Future<void> getAboutUsImages() async {
    try {
      final ListResult result = await storage.ref("uploads/").listAll();
      for (var ref in result.items) {
        if (ref.name == "AboutUs Banner") {
          final bannerUrl = await ref.getDownloadURL();
          aboutUsBanner = bannerUrl;
          notifyListeners();
          print("Banner image URL: $aboutUsBanner");
          return;
        }
      }
      aboutUsBanner = "";
      notifyListeners();
    } catch (e) {
      print('Failed to get image URL: $e');
    }
  }
}

class DeleteBrandProvider extends ChangeNotifier {
  Future<void> deleteBrand(
      String docId, BuildContext context, String collectionName) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(docId)
          .delete();
    } catch (e) {}
  }
}
