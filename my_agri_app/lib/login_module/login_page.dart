// import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_agri_app/login_module/register.dart';
// import 'package:my_agri_app/main_app/home.dart';

// import '../main_app/bottomnavigationbar.dart';

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

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {});
    _passwordController.addListener(() {});
  }

  signIn() async {
    try {
      // UserCredential userCredential = await FirebaseAuth.instance
      //     .signInWithEmailAndPassword(
      //         email: _emailController.text, password: _passwordController.text);
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);

      // User? user = userCredential.user;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text("User not present"),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                    } else if (value.length < 6) {
                      return "Password length must be 6";
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
                      validated = _formKey.currentState!.validate();

                      if (validated) {
                        await signIn();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Invalid Data"),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      }

                      // if (validated) {
                      //   if (user == null) {
                      //     // ignore: use_build_context_synchronously
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //       const SnackBar(
                      //         content: Text("Invalid details"),
                      //       ),
                      //     );
                      //   } else {
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //       const SnackBar(
                      //         content: Text("Login Successful"),
                      //         duration: Duration(seconds: 1),
                      //       ),
                      //     );
                      //     Navigator.of(context).pushReplacement(
                      //       MaterialPageRoute(
                      //         builder: (context) =>
                      //             const BottomNavBarWrapper(),
                      //       ),
                      //     );
                      //   }
                      // } else {
                      //   // ignore: use_build_context_synchronously
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(
                      //       content: Text("Enter Credentials"),
                      //     ),
                      // );
                      // }
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
                        color: Colors.grey, fontWeight: FontWeight.bold),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Register(),
                              ),
                            );
                          },
                      ),
                      const TextSpan(
                        text: ' ----------',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
