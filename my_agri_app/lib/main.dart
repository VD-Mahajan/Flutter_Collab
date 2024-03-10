import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_agri_app/firebase_options.dart';
import 'package:my_agri_app/login_module/Wrapper.dart';
import 'package:my_agri_app/homepage/cultivation_tips.dart';
import 'package:my_agri_app/homepage/feritizer.dart';
import 'package:my_agri_app/main_app/home.dart';
import 'package:my_agri_app/homepage/seeds_information.dart';
import 'package:my_agri_app/homepage/weather_report.dart';
// import 'package:my_agri_app/homepage/weather_report.dart';
import 'package:my_agri_app/main_app/marketplace.dart';
import 'package:my_agri_app/personal_details/profile.dart';
import 'package:my_agri_app/splash_screen.dart';

import 'homepage/crop_disease.dart';

// import 'main_app/bottomnavigationbar.dart';

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
        // '/':(context)=>const CropDisease(),
        // '/': (context) => const Wrapper(),
        '/': (context) => const SplashScreen(),
        // '/': (context) => const PersonalDetails(),
        '/profile': (context) => const PersonalDetails(),
        '/homepage': (context) => const HomePage(),
        '/market': (context) => const MarketPlace(),
        '/weather': (context) => const WeatherReport(),
        '/seedsinfo': (context) => const SeedsInformation(),
        '/fertilizer': (context) => const FertilizerInformation(),
        '/cultivationtips': (context) => const CultivationTips(),
        '/cropdisease': (context) => const CropDisease(),
      },
    );
  }
}
