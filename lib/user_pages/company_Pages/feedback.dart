import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Feedpage extends StatefulWidget {
  const Feedpage({super.key});

  @override
  FeedPageState createState() => FeedPageState();
}

class FeedPageState extends State<Feedpage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surenameController = TextEditingController();
  final TextEditingController gmailController = TextEditingController();
  final TextEditingController adressController = TextEditingController();
  final TextEditingController messageeController = TextEditingController();

  String emailError = '';
  bool isSending = false;

  @override
  void dispose() {
    nameController.dispose();
    surenameController.dispose();
    gmailController.dispose();
    adressController.dispose();
    messageeController.dispose();
    super.dispose();
  }

  void validateEmail() {
    setState(() {
      if (EmailValidator.validate(gmailController.text)) {
        emailError = '';
      } else {
        emailError = 'Invalid email address';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double textFontSize = (screenWidth * 0.05).clamp(16.0, 24.0);

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Get in touch',
                  style: GoogleFonts.outfit(
                    fontSize: 34,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Call us, contact our team via the form below directly on the App.',
                  style: TextStyle(
                    fontSize: textFontSize,
                    height: 1.2,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                            labelText: 'First Name *',
                            labelStyle: TextStyle(
                                color: Colors.white.withOpacity(0.4))),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: surenameController,
                        decoration: InputDecoration(
                            labelText: 'Last Name *',
                            labelStyle: TextStyle(
                                color: Colors.white.withOpacity(0.4))),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: gmailController,
                        decoration:  InputDecoration(
                          labelText: 'Email *',
                          labelStyle: TextStyle( color: Colors.white.withOpacity(0.4))
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          validateEmail();
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: adressController,
                        decoration:  InputDecoration(
                          labelText: 'Address',
                          labelStyle: TextStyle( color: Colors.white.withOpacity(0.4))
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: messageeController,
                  decoration:  InputDecoration(
                    labelText: 'Message',
                          labelStyle: TextStyle( color: Colors.white.withOpacity(0.4))
                  ),
                  maxLines: 4,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Color.fromARGB(255, 255, 102, 0),
                        ),
                      ),
                      onPressed: isSending ||
                              !EmailValidator.validate(gmailController.text)
                          ? null
                          : () async {
                              setState(() {
                                isSending = true;
                              });

                              var name = nameController.text;
                              var name2 = surenameController.text;
                              var mail = gmailController.text;
                              var address = adressController.text;
                              var message = messageeController.text;

                              try {
                                // ignore: unused_local_variable
                                String documentId = await savedata(
                                  name,
                                  name2,
                                  mail,
                                  address,
                                  message,
                                );

                                nameController.clear();
                                surenameController.clear();
                                gmailController.clear();
                                adressController.clear();
                                messageeController.clear();

                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor:
                                          Color.fromARGB(255, 255, 102, 0),
                                      content: Text(
                                          'Message sent successfully!',
                                          style:
                                              TextStyle(color: Colors.white))),
                                );
                              } catch (e) {
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor:
                                          Color.fromARGB(255, 255, 102, 0),
                                      content: Text(
                                          'Failed to send message. Please try again.',
                                          style:
                                              TextStyle(color: Colors.white))),
                                );
                              } finally {
                                if (mounted) {
                                  setState(() {
                                    isSending = false;
                                  });
                                }
                              }
                            },
                      child: const Text(
                        'Send',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Future<String> savedata(
  String name,
  String name2,
  String mail,
  String address,
  String message,
) async {
  try {
    final feed = FirebaseFirestore.instance;
    DocumentReference documentRef = await feed.collection('FeedBack').add({
      'Name': name,
      'Second Name': name2,
      'Mail': mail,
      'Address': address,
      'Message': message,
    });

    String documentId = documentRef.id;

    await documentRef.update({"id": documentId});

    return documentId;
  } catch (e) {
    rethrow;
  }
}
