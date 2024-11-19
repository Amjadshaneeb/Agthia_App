// ignore_for_file: use_build_context_synchronously

import 'package:agthia_slot_booking/firebase_services/auth_gate.dart';
import 'package:agthia_slot_booking/widgets/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<FunctionProvider>(context, listen: false).getBannerImageUrl();
      Provider.of<BannerProvider>(context, listen: false).getCareerImages();
      Provider.of<BannerProvider>(context, listen: false).getAboutUsImages();
      Provider.of<BannerProvider>(context, listen: false).getChairmanImages();
      Provider.of<BannerProvider>(context, listen: false).getOurpeopleImages();
      Provider.of<BrandProvider>(context, listen: false).getBrandsWithImages("InterNational Brand");
  
    });

    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    fadeAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => const AuthGate()));
    });
  }

  @override
  void dispose() {
    controller.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        ],
      ),
    );
  }
}
