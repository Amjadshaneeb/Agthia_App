import 'package:agthia_slot_booking/firebase_services/services.dart';
import 'package:agthia_slot_booking/user_pages/login_page.dart';
import 'package:agthia_slot_booking/widgets/Neumorphic.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';

// SignIn TexteditingControllers
TextEditingController emailController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController passwordController = TextEditingController();

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
              const SizedBox(height: 20),
              const CircleAvatar(
                backgroundImage: AssetImage("assets/Agthia.png"),
                radius: 60,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
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
                          capwords: TextCapitalization.words,
                          controller: nameController,
                          obscure: false,
                          color: const Color(0xFFE0E5EC),
                          depth: -3,
                          hinttext: "Name",
                          icon: const Icon(Icons.person_2_outlined),
                        ),
                        NuemTextfield(
                          capwords: TextCapitalization.none,
                          controller: emailController,
                          obscure: false,
                          icon: const Icon(Icons.mail_outlined),
                          color: const Color(0xFFE0E5EC),
                          depth: -3,
                          hinttext: "Mail",
                        ),
                        NuemTextfield(
                          capwords: TextCapitalization.none,
                          controller: passwordController,
                          obscure: true,
                          icon: const Icon(Icons.lock_outline),
                          color: const Color(0xFFE0E5EC),
                          depth: -3,
                          hinttext: "Password",
                        ),
                        NeumorphicButton(
                          margin: const EdgeInsets.all(15),
                          onPressed: () {
                            var mail = emailController.text;
                            var name = nameController.text;
                            var password = passwordController.text;
                            signup(context, name, mail, password);
                          },
                          style: NeumorphicStyle(
                              color: const Color.fromARGB(237, 0, 0, 0),
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(25)),
                              depth: -4,
                              intensity: 10,
                              shadowLightColor: Colors.red,
                              shadowDarkColor: Colors.red),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "SignUp",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        // const SizedBox(height: 8),
                        // const Text("Or"),
                        // const SizedBox(height: 8),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     SignInButton(Buttons.Google,
                        //         elevation: 10,
                        //         shape: Border.all(),
                        //         text: "   Sign in with Google", onPressed: () {
                        //       signinwithGoogle(context);
                        //     }),
                        //     // CircleAvatar(
                        //     //   backgroundColor: Colors.transparent,
                        //     //   radius: 20,
                        //     //   child: IconButton(
                        //     //       onPressed: () {},
                        //     //       icon: Image.asset(
                        //     //         "assets/pngwing.com (12).png",
                        //     //         fit: BoxFit.contain,
                        //     //       )),
                        //     // ),
                        //     // const Text("Google",
                        //     //     style: TextStyle(fontWeight: FontWeight.bold))
                        //   ],
                        // ),
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
