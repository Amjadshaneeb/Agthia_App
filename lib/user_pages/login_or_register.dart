import 'package:agthia_slot_booking/user_pages/home_bottom_navigation.dart';
import 'package:agthia_slot_booking/user_pages/login_page.dart';
import 'package:flutter/material.dart';

bool isLogin = true;

void showBottomSheet(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: const Color(0xFF0f172b),
    scrollControlDisabledMaxHeightRatio: 0.9,
    isScrollControlled: false,
    context: context,
    builder: (context) {
      return const LoginPage();
    },
  );
}

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister>
    with SingleTickerProviderStateMixin {
  
   late AnimationController controller;
  late Animation<double> fadeAnimation;
 

  @override
  void initState() {
    super.initState(); // Call this first
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    fadeAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {

    double buttonWidth = MediaQuery.of(context).size.width * 0.9;
    double buttonHeight = MediaQuery.of(context).size.height * 0.05;
    
    return Scaffold(
    backgroundColor: const Color(0xFF0f172b),
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Background Container extending outside Scaffold bounds
          Positioned(
            top: -MediaQuery.of(context).size.height * 0.50, // Move it upwards
            left: -MediaQuery.of(context).size.width *
                0.50, // Move it to the left
            child: FadeTransition(
              opacity: fadeAnimation,
              child: Container(
                height: MediaQuery.of(context).size.height * 2,
                width: MediaQuery.of(context).size.width * 2,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                    )),
              ),
            ),
          ),
          Positioned(
            top: -MediaQuery.of(context).size.height * 0.375, // Move it upwards
            left: -MediaQuery.of(context).size.width *
                0.375, // Move it to the left
            child: FadeTransition(
              opacity: fadeAnimation,
              child: Container(
                height: MediaQuery.of(context).size.height * 1.75,
                width: MediaQuery.of(context).size.width * 1.75,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                    )),
              ),
            ),
          ),
          Positioned(
            top: -MediaQuery.of(context).size.height * 0.25, // Move it upwards
            left: -MediaQuery.of(context).size.width *
                0.25, // Move it to the left
            child: FadeTransition(
              opacity: fadeAnimation,
              child: Container(
                height: MediaQuery.of(context).size.height * 1.5,
                width: MediaQuery.of(context).size.width * 1.5,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                    )),
              ),
            ),
          ),
          Positioned(
            top: -MediaQuery.of(context).size.height * 0.125, // Move it upwards
            left: -MediaQuery.of(context).size.width *
                0.12, // Move it to the left
            child: FadeTransition(
              opacity: fadeAnimation,
              child: Container(
                height: MediaQuery.of(context).size.height * 1.25,
                width: MediaQuery.of(context).size.width * 1.25,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                    )),
              ),
            ),
          ),
          Positioned(
            top: -MediaQuery.of(context).size.height * 0.0, // Move it upwards
            left:
                -MediaQuery.of(context).size.width * 0.0, // Move it to the left
            child: FadeTransition(
              opacity: fadeAnimation,
              child: Container(
                height: MediaQuery.of(context).size.height * 1.0,
                width: MediaQuery.of(context).size.width * 1.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                    )),
              ),
            ),
          ),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Middle circle
                FadeTransition(
                  opacity: fadeAnimation,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width * 0.77,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
                // Logo circle
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.7),
                    ),
                    image: const DecorationImage(
                      image: AssetImage("assets/Agthia_logo.png"),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ],
            ),
          ),
                    Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Column(
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    fixedSize: Size(buttonWidth, buttonHeight),
                    backgroundColor: const Color.fromARGB(255, 255, 102, 0),
                    side: const BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      isLogin = true;
                    });
                    showBottomSheet(context);
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 15),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    fixedSize: Size(buttonWidth, buttonHeight),
                    backgroundColor: const Color.fromARGB(255, 255, 102, 0),
                    side: const BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Homepage(),
                      ),
                    );
                  },
                  child: const Text(
                    'Home',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

