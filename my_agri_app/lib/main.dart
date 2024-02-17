import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_agri_app/firebase_options.dart';
import 'package:my_agri_app/login_module/login.dart';
import 'package:my_agri_app/login_module/register.dart';
import 'package:my_agri_app/main_app/homepage.dart';
import 'package:my_agri_app/personal_details/profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Register(),
        '/login': (context) => const LoginPage(),
        '/profile': (context) => const PersonalDetails(),
        '/homepage':(context) => const HomePage(),
      },
    );
  }
}
