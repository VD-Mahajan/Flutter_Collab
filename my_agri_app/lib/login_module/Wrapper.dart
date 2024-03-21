import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_agri_app/login_module/verify_user.dart';
import 'package:my_agri_app/select_type.dart';
// import 'package:my_agri_app/login_module/user_login_page.dart';
import 'package:my_agri_app/main_app/bottomnavigationbar.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  // User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (FirebaseAuth.instance.currentUser!.emailVerified) {
              return const BottomNavBarWrapper();
            } else {
              return const VerifyUser();
            }
          } else {
            return const SelectType();
          }
        });
  }
}
