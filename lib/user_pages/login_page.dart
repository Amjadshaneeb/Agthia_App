import 'package:agthia_slot_booking/user_pages/homeBottomNavigation.dart';
import 'package:agthia_slot_booking/user_pages/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';

TextEditingController loginmailcontroller = TextEditingController();
TextEditingController loginpasscontroller = TextEditingController();

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<void> login(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: loginmailcontroller.text.trim(),
          password: loginpasscontroller.text.trim());

      const CircularProgressIndicator();

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(milliseconds: 500),
          backgroundColor: Color.fromARGB(255, 255, 102, 0),
          content: Text("Login Successfully")));

      Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const Homepage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == "Wrong password") {
        showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (context) =>
                const AlertDialog(title: Text("Wrong password")));
      } else {
        showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (context) => const AlertDialog(title: Text("Not a User")));
      }
    }
  }

  @override
  void initState() {
    loginmailcontroller = TextEditingController();
    loginpasscontroller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    loginmailcontroller.dispose();
    loginpasscontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        physics: const ScrollPhysics(parent: FixedExtentScrollPhysics()),
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25),
                Neumorphic(
                  style: const NeumorphicStyle(
                      //circle avatar
                      shape: NeumorphicShape.convex,
                      depth: 8,
                      boxShape: NeumorphicBoxShape.circle(),
                      color: Colors.white,
                      shadowLightColor: Colors.black),
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(
                      Icons.account_circle,
                      size: 80,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.85,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            'Welocome Back!',
                            style: GoogleFonts.dmSerifDisplay(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Made easy!',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          const SizedBox(height: 20),
                          Neumorphic(
                            //username textfield
                            margin: const EdgeInsets.all(15),
                            style: NeumorphicStyle(
                              depth: -3,
                              shadowLightColorEmboss:
                                  Colors.white.withOpacity(0.5),
                              lightSource: LightSource.topLeft,
                              intensity: 20,
                              color: const Color(0xFFE0E5EC),
                              boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(25),
                              ),
                            ),
                            child: TextField(
                              controller: loginmailcontroller,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.person_2_outlined),
                                hintText: "Mail",
                                hintStyle: TextStyle(
                                    color: Colors.grey.withOpacity(0.6)),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 18, horizontal: 12),
                              ),
                            ),
                          ),
                          Neumorphic(
                            //password textfield
                            margin: const EdgeInsets.all(15),
                            style: NeumorphicStyle(
                              depth: -3,
                              lightSource: LightSource.topLeft,
                              intensity: 20,
                              surfaceIntensity: 1,
                              color: const Color(0xFFE0E5EC),
                              boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(25),
                              ),
                            ),
                            child: TextField(
                              controller: loginpasscontroller,
                              obscureText: true,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.lock_outline),
                                hintText: "password",
                                hintStyle: TextStyle(
                                    color: Colors.grey.withOpacity(0.6)),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 18, horizontal: 12),
                              ),
                            ),
                          ),
                          NeumorphicButton(
                            margin: const EdgeInsets.all(15),
                            onPressed: () {
                              login(context);
                            },
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
                                  "Login",
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
                              const Text(
                                "Forgot password?",
                                style: TextStyle(color: Colors.grey),
                              ),
                              TextButton(
                                style: const ButtonStyle(
                                    splashFactory: NoSplash.splashFactory),
                                onPressed: () {
                                  setState(() {
                                    isLogin = false;
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  " or Sign Up",
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
                              const Text("Google",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
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
      ),
    );
  }
}
