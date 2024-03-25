import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:my_agri_app/login_module/Wrapper.dart';
import 'package:my_agri_app/login_module/user_login_page.dart';
import 'package:sqflite/sqflite.dart';

import '../main.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  // ignore: no_logic_in_create_state
  State createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  //KEYS
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _personalNameController = TextEditingController();
  final FocusNode _personalNameFocusNode = FocusNode();

  final TextEditingController _personalAddressController =
      TextEditingController();
  final FocusNode _personalAddressFocusNode = FocusNode();

  final TextEditingController _personalPostCodeController =
      TextEditingController();
  final FocusNode _personalPostCodeFocusNode = FocusNode();

  final TextEditingController _phoneNumberCodeController =
      TextEditingController();
  final FocusNode _phoneNumberFocusNode = FocusNode();

  addPersonalDetails(
      String name, String address, String pincode, String phoneNumber) async {
    if (name.isEmpty ||
        address.isEmpty ||
        pincode.isEmpty ||
        pincode.length < 6) {
      // print("Enter Required/valid field");
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('Personal info')
          .doc('${FirebaseAuth.instance.currentUser!.email}')
          .set({
        'Name': name,
        'Address': address,
        'Pincode': pincode,
        'phoneNumber': phoneNumber,
        'email': FirebaseAuth.instance.currentUser!.email,
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
      print('Data inserted successfully');
    } catch (e) {
      // print('Error adding data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Personal Details",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(children: [
        const SizedBox(
          height: 20,
        ),
        const Center(
          child: Text(
            "Your personal information will helps our",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Center(
          child: Text(
            "service to reach you easily",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Image.asset(
          'assets/profile.jpg',
          height: 150,
        ),
        //================================================================
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 15,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: TextFormField(
                    controller: _personalNameController,
                    focusNode: _personalNameFocusNode,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      hintText: "Full Name",
                      prefixIconColor: Colors.grey,
                      hintStyle: const TextStyle(
                        fontSize: 23,
                      ),
                      border: OutlineInputBorder(
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter name';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                //================================================================
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: TextFormField(
                    controller: _phoneNumberCodeController,
                    focusNode: _phoneNumberFocusNode,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone),
                      hintText: "Phone Number",
                      prefixIconColor: Colors.grey,
                      hintStyle: const TextStyle(
                        fontSize: 23,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 2,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(
                      fontSize: 23,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter number';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                //====================================================================
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: TextFormField(
                    controller: _personalAddressController,
                    focusNode: _personalAddressFocusNode,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.list_alt_rounded),
                      hintText: "Address",
                      prefixIconColor: Colors.grey,
                      hintStyle: const TextStyle(
                        fontSize: 23,
                      ),
                      border: OutlineInputBorder(
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter address';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                //======================================================================
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: TextFormField(
                    controller: _personalPostCodeController,
                    focusNode: _personalPostCodeFocusNode,
                    decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.confirmation_number_outlined),
                      hintText: "Pincode",
                      prefixIconColor: Colors.grey,
                      hintStyle: const TextStyle(
                        fontSize: 23,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 2,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(
                      fontSize: 23,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Pincode';
                      } else if (value.length != 6) {
                        return 'Enter valid Pincode';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                //============================================================
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        bool validated = _formKey.currentState!.validate();

                        if (validated) {
                          addPersonalDetails(
                            _personalNameController.text.toString(),
                            _personalAddressController.text.toString(),
                            _personalPostCodeController.text.toString(),
                            _phoneNumberCodeController.text.toString(),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                      child: const Text(
                        "Save",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
