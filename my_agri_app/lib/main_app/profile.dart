import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State createState() => _ProfileState();
}

class _ProfileState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('This is your Profile'),
        leading: const Icon(Icons.logout),
      ),
      body: const Center(
        child: Text('My Profile'),
      ),
    );
  }
}