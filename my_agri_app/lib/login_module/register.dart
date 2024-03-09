import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_agri_app/personal_details/profile.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //CONTROLLERS
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //GLOBALKEY
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool validated = false;

  UserCredential? userCredential;

  bool flag = false;
  bool result = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {});
    _emailController.addListener(() {});
  }

  _insertData(String email, String password) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential!.user!.uid)
        .set({
      'Email': email,
      'password': password,
    });
  }

  registerUser(String email, String password) async {
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential != null) {
        await _insertData(email, password);
        // Navigator.pushNamed(context, '/profile');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const PersonalDetails(),
          ),
        );
      }
    } catch (e) {
      flag = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(
            height: 70,
          ),
          Center(
            child: Image.asset(
              'assets/register.jpg',
              height: 210,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 18.0,
                  bottom: 15,
                ),
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    maxLines: null,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.mail,
                        color: Colors.grey,
                      ),
                      // hintText: "Enter Email",
                      label: const Text(
                        "Enter Email",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      hintStyle: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.normal,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.normal,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Email";
                      } else if (!value.endsWith("@gmail.com")) {
                        return "Email format not supported";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    obscuringCharacter: '*',
                    controller: _passwordController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.grey,
                      ),
                      // hintText: "Password",
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.remove_red_eye,
                          color: Colors.grey,
                        ),
                      ),
                      label: const Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      hintStyle: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.normal,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.normal,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Enter Password";
                      } else if (value.length < 6) {
                        return "Password must contain 6 character";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SizedBox(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  validated = _formKey.currentState!.validate();

                  if (flag) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "User already present",
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      ),
                    );
                  } else if (validated) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Registration successful"),
                      ),
                    );
                    setState(() {
                      registerUser(_emailController.text.toString(),
                          _passwordController.text.toString());
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Enter valid credentials",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          // Center(
          //   child: RichText(
          //     text: TextSpan(
          //       text: '----------- Already have an account? ',
          //       style: const TextStyle(
          //           color: Colors.grey, fontWeight: FontWeight.bold),
          //       children: [
          //         TextSpan(
          //           text: 'Log in',
          //           style: const TextStyle(
          //             color:
          //                 Colors.blue, // Customize the color of the hyperlink
          //             decoration: TextDecoration
          //                 .underline, // Add underline to simulate hyperlink
          //           ),
          //           recognizer: TapGestureRecognizer()
          //             ..onTap = () {
          //               Navigator.pushNamed(context, '/login');
          //             },
          //         ),
          //         const TextSpan(
          //           text: ' ----------',
          //           style: TextStyle(
          //               color: Colors.grey, fontWeight: FontWeight.bold),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
