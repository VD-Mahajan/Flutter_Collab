import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_agri_app/firebase_options.dart';
import 'package:my_agri_app/login_module/login.dart';
import 'package:my_agri_app/login_module/register.dart';
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
        '/': (context) => Register(),
        '/login':(context) => LoginPage(),
        '/profile':(context) => PersonalDetails(),
      },
    );
  }
}
