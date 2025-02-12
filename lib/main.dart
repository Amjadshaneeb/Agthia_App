import 'package:agthia_slot_booking/user_pages/splash_screen.dart';
import 'package:agthia_slot_booking/widgets/provider.dart';
import 'package:agthia_slot_booking/widgets/theme_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FunctionProvider()),
        ChangeNotifierProvider(create: (_) => BrandProvider()),
        ChangeNotifierProvider(create: (_) => ImagePickerProvider()),
        ChangeNotifierProvider(create: (_) => BannerProvider()),
        ChangeNotifierProvider(create: (_) => DeleteBrandProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Agthia',
        themeMode: ThemeMode.system,
        theme: lightTheme(),
        darkTheme: darkTheme(),
        home: const SplashScreen(),
      ),
    );
  }
}
