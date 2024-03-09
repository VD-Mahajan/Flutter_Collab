import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State createState() => _ProfileState();
}

class _ProfileState extends State {
  signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('This is your Profile'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              await signOut();
            },
            child: const Text("Sign out")),
      ),
    );
  }
}
