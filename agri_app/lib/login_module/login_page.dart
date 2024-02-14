import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static Future<FirebaseApp> _initFireBase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

//   FirebaseOptions options = FirebaseOptions(
//   apiKey: 'YOUR_API_KEY',
//   appId: 'YOUR_APP_ID',
//   projectId: 'YOUR_PROJECT_ID',
//   messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
//   storageBucket: 'YOUR_STORAGE_BUCKET',
// );


  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    // await _initFireBase();
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print('No user found with this email');
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      body: FutureBuilder(
          future: _initFireBase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: Image.network(
                      'https://cdni.iconscout.com/illustration/premium/thumb/login-page-4468581-3783954.png',
                      // fit: BoxFit.cover,
                      // color: Colors.green,
                      height: 300,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 18),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 350,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.black54,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _emailController,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.black54,
                        ),
                        contentPadding: EdgeInsets.only(left: 20),
                        hintText: 'email',
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 350,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.black54,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _passwordController,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.black54,
                        ),
                        suffixIcon: Icon(
                          Icons.remove_red_eye_outlined,
                          color: Colors.black54,
                        ),
                        contentPadding: EdgeInsets.only(left: 20),
                        hintText: 'Enter password',
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        await _initFireBase();
                        User? user = await loginUsingEmailPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                            context: context);
                        print('BUTTON CLICKED');
                        if (user != null) {
                          print('USER IS PRESENT');
                        } else {
                          print('USER IS NOT PRESENT');
                        }
                      },
                      child: const Text('Login'),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text('Ram Ram'),
              );
            }
          }),
    );
  }
}
