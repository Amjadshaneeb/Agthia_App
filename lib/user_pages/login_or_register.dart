import 'package:agthia_slot_booking/user_pages/login_page.dart';
import 'package:agthia_slot_booking/user_pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

  bool isLogin = true;

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: isLogin ? const LoginPage() : const SignupPage(),
        );
      },
    );
  }
class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            color: const Color(0xFF0f172b),
          ),
          Positioned.fill(
            child: CustomPaint(
              painter: CirclePainter(),
            ),
          ),
          const Positioned(
            top: 160,
            child: CircleAvatar(
              radius: 130,
              backgroundImage: AssetImage('assets/Agthia.png'),
            ),
          ),
          // ..._buildProfileIcons(context),
          // Text and Buttons
          Positioned(
            bottom: 320,
            child: Text(' The experience of\nbuying food quickly',
                style: GoogleFonts.ptSerif(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  height: 1.4,
                )),
          ),
          Positioned(
            bottom: 270,
            child: Text(
              'The experience of buying food quickly',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.8),
                fontSize: 16,
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            child: Column(
              children: [
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(370, 45),
                    backgroundColor: const Color.fromARGB(
                        255, 255, 102, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      isLogin = false;
                    });
                    showBottomSheet(context);
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size(370, 45),
                    backgroundColor: Colors.white,
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
                        color: Color(
                          0xFF0f172b,
                        ),
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

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    double centerX = size.width / 2;
    double centerY = size.height / 3;

    // Draw concentric circles
    for (int i = 1; i <= 4; i++) {
      canvas.drawCircle(Offset(centerX, centerY), 65.0 * i, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
