import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_agri_app/main_app/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool? _flag;
  bool showPassword = true;

  void changeIcon() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  // final _formKey = GlobalKey<FormState>();

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
    TextEditingController _emailController = TextEditingController();
    // FocusNode _emailFocusNode = FocusNode();
    TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      body: FutureBuilder(
          future: _initFireBase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SingleChildScrollView(
                child: Form(
                  // key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        // child: Image.network(
                        //   'https://cdni.iconscout.com/illustration/premium/thumb/login-page-4468581-3783954.png',
                        //   // fit: BoxFit.cover,
                        //   // color: Colors.green,
                        //   height: 270,
                        // ),
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
                      Container(
                        width: 350,
                        height: 70,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 7.0),
                          child: TextFormField(
                            controller: _emailController,
                            // focusNode: _emailFocusNode,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Colors.grey,
                              ),
                              contentPadding: EdgeInsets.only(left: 20),
                              hintText: 'Enter registered Email',
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 23,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 350,
                        height: 70,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 7.0),
                          child: TextFormField(
                            obscureText: true,
                            controller: _passwordController,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.grey,
                              ),
                              suffixIcon: Icon(
                                Icons.remove_red_eye_outlined,
                                color: Colors.grey,
                              ),
                              contentPadding: EdgeInsets.only(left: 20),
                              hintText: 'Enter password',
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 23,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        child: (_flag == null)
                            ? const Text('')
                            : (_flag == false)
                                ? const Text(
                                    'Enter valid details',
                                    style: TextStyle(color: Colors.red),
                                  )
                                : const Text(
                                    'Login successfuly',
                                    style: TextStyle(
                                      color: Colors.green,
                                    ),
                                  ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 60,
                        width: 360,
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
                              context: context,
                            );
                            setState(() {
                              if (user != null) {
                                _flag = true;
                                // Navigator.pushNamed(context, '/homepage');
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const HomePage(),
                                  ),
                                );
                              } else {
                                _flag = false;
                              }
                            });
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
