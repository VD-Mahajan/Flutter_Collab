import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:my_agri_app/main_app/home.dart';

import '../main_app/bottomnavigationbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //CONTROLLERS
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //GLOBALKEYS
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool validated = false;
  bool showPassword = true;

  void changeIcon() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  static Future<FirebaseApp> _initFireBase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
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
    @override
    void initState() {
      super.initState();
      _emailController.addListener(() {});
      _passwordController.addListener(() {});
    }

    return Scaffold(
      body: FutureBuilder(
          future: _initFireBase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        child: Image.asset(
                          'assets/login.jpg',
                          height: 270,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: TextFormField(
                          controller: _emailController,
                          maxLines: null,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: Colors.grey,
                            ),
                            label: const Text(
                              "Enter Email",
                              style: TextStyle(
                                // color: Colors.grey,
                                fontSize: 23,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            // hintText: 'Enter Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintStyle: const TextStyle(
                              // color: Colors.grey,
                              fontSize: 23,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.normal,
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Enter username";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: TextFormField(
                          obscureText: true,
                          obscuringCharacter: '*',
                          controller: _passwordController,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.grey,
                            ),
                            suffixIcon: const Icon(
                              Icons.remove_red_eye_outlined,
                              color: Colors.grey,
                            ),
                            label: const Text(
                              "Enter password",
                              style: TextStyle(
                                // color: Colors.grey,
                                fontSize: 23,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            // hintText: 'Enter password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintStyle: const TextStyle(
                              // color: Colors.grey,
                              fontSize: 23,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.normal,
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Enter password";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: SizedBox(
                          height: 60,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () async {
                              await _initFireBase();
                              // ignore: use_build_context_synchronously
                              User? user = await loginUsingEmailPassword(
                                email: _emailController.text,
                                password: _passwordController.text,
                                // ignore: use_build_context_synchronously
                                context: context,
                              );

                              validated = _formKey.currentState!.validate();

                              if (validated) {
                                if (user == null) {
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Invalid details"),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Login Successful"),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const BottomNavBarWrapper(),
                                    ),
                                  );
                                }
                              } else {
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Enter Credentials"),
                                  ),
                                );
                              }
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: '----------- Create new account?  ',
                            style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: 'Sign up',
                                style: const TextStyle(
                                  color: Colors
                                      .blue, // Customize the color of the hyperlink
                                  decoration: TextDecoration
                                      .underline, // Add underline to simulate hyperlink
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context, '/');
                                  },
                              ),
                              const TextSpan(
                                text: ' ----------',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Scaffold();
            }
          }),
    );
  }
}
