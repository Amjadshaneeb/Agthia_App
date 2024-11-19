import 'package:agthia_slot_booking/firebase_services/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
        child: Builder(
          builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25),
                const CircleAvatar(
                  backgroundImage: AssetImage("assets/Agthia.png"),
                  radius: 60,
                ),
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
                              shadowLightColorEmboss: Colors.white.withOpacity(0.5),
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
                                hintStyle:
                                    TextStyle(color: Colors.grey.withOpacity(0.6)),
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
                                hintStyle:
                                    TextStyle(color: Colors.grey.withOpacity(0.6)),
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
                              TextButton(
                                  onPressed: () {
                                    resetpassword(context);
                                  },
                                  child: const Text(
                                    "Forgot password?",
                                    style: TextStyle(color: Colors.grey),
                                  )),
                            ],
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     SignInButton(Buttons.Google,
                          //         elevation: 10,
                          //         shape: Border.all(),
                          //         text: "   Sign in with Google", onPressed: () {
                          //       signinwithGoogle(context);
                          //     }),
                          //   ],
                          // ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            );
          }
        ),
      ),
    );
  }
  // Sign in with Google
}

// signinwithGoogle(context) async {
//   GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();
//   GoogleSignInAuthentication? googlAauth = await googleuser?.authentication;

//   try {
//     AuthCredential credential = GoogleAuthProvider.credential(
//       accessToken: googlAauth?.accessToken,
//       idToken: googlAauth?.idToken,
//     );

//     UserCredential userCredential =
//         await FirebaseAuth.instance.signInWithCredential(credential);
//     print(userCredential.user?.displayName);
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => const Homepage()));
//   } catch (e) {
//     print(e);
//   }
// }
