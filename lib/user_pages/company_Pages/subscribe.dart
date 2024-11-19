import 'package:agthia_slot_booking/widgets/textField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SubscribeBottomSheet extends StatefulWidget {
  const SubscribeBottomSheet({super.key});

  @override
  SubscribeBottomSheetState createState() => SubscribeBottomSheetState();
}

class SubscribeBottomSheetState extends State<SubscribeBottomSheet> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  

  Future<void> _subscribe() async {
    final email = _emailController.text.trim();
    if (email.isEmpty || !email.endsWith('@gmail.com')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(milliseconds: 1500),
          backgroundColor: Color.fromARGB(255, 255, 102, 0),
          content: Text(
            'Please enter a valid email',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseFirestore.instance
          .collection('subscribers')
          .doc(_emailController.text)
          .set({
        'email': email,
        'timestamp': FieldValue.serverTimestamp(), // Optional: Add timestamp
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            duration: Duration(milliseconds: 500),
            backgroundColor: Color.fromARGB(255, 255, 102, 0),
            content: Text(
              'Subscribed',
              style: TextStyle(color: Colors.white),
            )),
      );
      Navigator.pop(context); // Close the bottom sheet
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            duration: Duration(milliseconds: 500),
            backgroundColor: Color.fromARGB(255, 255, 102, 0),
            content: Text(
              'Failed to subscribe',
              style: TextStyle(color: Colors.white),
            )),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 16.0,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Subscribe to our Newsletter",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Mytextfield(
                hinttext: "Enter your email",
                obscure: false,
                controller: _emailController,
                maxlines: 1),
            const SizedBox(height: 16),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 102, 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                    onPressed: _subscribe,
                    child: const Text(
                      "Subscribe",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
