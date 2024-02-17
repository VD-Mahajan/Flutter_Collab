import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();

  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();

  UserCredential? userCredential;

  bool flag = false;
  bool result = false;

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
    if (email.isEmpty || password.isEmpty) {
      result = true;
    } else {
      try {
        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        if (userCredential != null) {
          await _insertData(email, password);
          Navigator.pushNamed(context, '/profile');
        }
      } catch (e) {
        flag = true;
      }
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
              height: 200,
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
            padding: const EdgeInsets.only(bottom: 8.0, left: 15, right: 15),
            child: TextField(
              controller: _emailController,
              focusNode: _phoneFocusNode,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.mail),
                hintText: "Enter your Email",
                prefixIconColor: Colors.grey,
                hintStyle: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.normal,
                ),
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
              ),
              // keyboardType: TextInputType.phone,
              style: const TextStyle(
                fontSize: 23,
              ),
            ),
          ),
          //=========================================================
          Padding(
            padding: const EdgeInsets.only(
                bottom: 8.0, left: 15, right: 15, top: 12),
            child: TextField(
              obscureText: true,
              controller: _passwordController,
              focusNode: _passwordFocusNode,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock),
                hintText: "Password",
                suffixIcon: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.remove_red_eye)),
                prefixIconColor: Colors.grey,
                suffixIconColor: Colors.grey,
                hintStyle: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.normal,
                ),
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
              ),
              keyboardType: TextInputType.text,
              style: const TextStyle(
                fontSize: 23,
              ),
            ),
          ),
          //=====================================================
          Center(
            child: (flag)
                ? const SizedBox(
                    height: 25,
                    child: Text(
                      'User already present',
                      style: TextStyle(
                        color: Colors.cyan,
                      ),
                    ),
                  )
                : const SizedBox(
                    height: 10,
                  ),
          ),
          Center(
            child: (result)
                ? const SizedBox(
                    height: 25,
                    child: Text(
                      'Please enter required field',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  )
                : const SizedBox(
                    height: 10,
                  ),
          ),

          Padding(
            padding: const EdgeInsets.only(
                bottom: 8.0, left: 15, right: 15, top: 12),
            child: SizedBox(
              height: 60,
              width: 360,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    registerUser(_emailController.text.toString(),
                        _passwordController.text.toString());
                  });
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
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

          Center(
            child: RichText(
              text: TextSpan(
                text: '----------- Already have an account? ',
                style: const TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: 'Log in',
                    style: const TextStyle(
                      color:
                          Colors.blue, // Customize the color of the hyperlink
                      decoration: TextDecoration
                          .underline, // Add underline to simulate hyperlink
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushNamed(context, '/login');
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
    );
  }
}
