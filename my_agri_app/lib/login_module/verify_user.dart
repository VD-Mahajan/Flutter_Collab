import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerifyUser extends StatefulWidget {
  const VerifyUser({super.key});

  @override
  State<VerifyUser> createState() => _VerifyUserState();
}

class _VerifyUserState extends State<VerifyUser> {
  bool isMailSent = false;

  //METHODS
  _restartApplication() {
    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.green[100],
      backgroundColor: Colors.grey.shade200,
      // appBar: AppBar(
      //   backgroundColor: Colors.green[100],
      // ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Before proceeding, we kindly ask all users to verify their email addresses. Verification helps ensure the security of your account and allows us to communicate important updates and information effectively. To verify your email, simply click on the link we've sent to your inbox. If you haven't received the verification email, please check your spam or junk folder. Once your email is verified, you'll gain full access to our application and its features. Thank you for your cooperation in keeping our platform safe and secure.",
                  textAlign: TextAlign.justify,
                ),
              ),
              (!isMailSent)
                  ? ElevatedButton(
                      onPressed: () {
                        FirebaseAuth.instance.currentUser!
                            .sendEmailVerification();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('verification mail is sent')),
                        );
                        setState(() {
                          isMailSent = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Verify Email address'),
                    )
                  : const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Verification mail sent, please check your gmail.',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
              ElevatedButton(
                onPressed: () {
                  _restartApplication();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Exit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
