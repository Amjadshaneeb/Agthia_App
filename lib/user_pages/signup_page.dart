import 'package:agthia_slot_booking/widgets/Neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Neumorphic(
                style: const NeumorphicStyle(
                    //circle avatar
                    shape: NeumorphicShape.convex,
                    depth: -5,
                    boxShape: NeumorphicBoxShape.circle(),
                    color: Colors.white,
                    shadowLightColor: Colors.black),
                child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Image.asset(
                      "assets/Agthia.png",
                      scale: 5,
                    )),
              ),
              Text(
                "Signup",
                style: GoogleFonts.halant(
                    fontWeight: FontWeight.bold, fontSize: 32),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.93,
                child: Column(
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          'Get your free account',
                          style: GoogleFonts.dmSerifDisplay(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        NuemTextfield(
                          color: const Color(0xFFE0E5EC),
                          depth: -3,
                          hinttext: "Name",
                          icon: const Icon(Icons.person_2_outlined),
                        ),
                        NuemTextfield(
                          icon: const Icon(Icons.mail_outlined),
                          color: const Color(0xFFE0E5EC),
                          depth: -3,
                          hinttext: "Mail",
                        ),
                        NuemTextfield(
                          icon: const Icon(Icons.lock_outline),
                          color: const Color(0xFFE0E5EC),
                          depth: -3,
                          hinttext: "Password",
                        ),
                        NeumorphicButton(
                          margin: const EdgeInsets.all(15),
                          onPressed: () {},
                          style: NeumorphicStyle(
                              color: const Color.fromARGB(237, 0, 0, 0),
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(25)),
                              depth: -4,
                              intensity: 10,
                              shadowLightColor: Colors.red,
                              shadowDarkColor: Colors.red),
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Text(
                                "SignUp",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                " Already have an account?",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.white,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Image.asset(
                                    "assets/pngwing.com (12).png",
                                    fit: BoxFit.contain,
                                  )),
                            ),
                            Text("Google",
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                        const SizedBox(height: 15),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
