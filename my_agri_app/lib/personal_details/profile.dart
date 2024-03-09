import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:my_agri_app/main_app/home.dart';

import '../main_app/bottomnavigationbar.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  // ignore: no_logic_in_create_state
  State createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  final TextEditingController _personalNameController = TextEditingController();
  final FocusNode _personalNameFocusNode = FocusNode();

  final TextEditingController _personalAddressController =
      TextEditingController();
  final FocusNode _personalAddressFocusNode = FocusNode();

  final TextEditingController _personalPostCodeController =
      TextEditingController();
  final FocusNode _personalPostCodeFocusNode = FocusNode();

  addPersonalDetails(String name, String address, String pincode) async {
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
          .doc('_${name}_$address')
          .set({
        'Name': name,
        'Address': address,
        'Pincode': pincode,
      });
      // ignore: use_build_context_synchronously
      // Navigator.pushNamed(context, '/homepage');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const BottomNavBarWrapper(),
        ),
      );
      // print('Data inserted successfully');
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
          padding:
              const EdgeInsets.only(bottom: 8.0, left: 15, right: 15, top: 10),
          child: TextField(
            controller: _personalNameController,
            focusNode: _personalNameFocusNode,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.person),
              hintText: "Full Name",
              prefixIconColor: Colors.grey,
              hintStyle: const TextStyle(
                fontSize: 23,
              ),
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 2,
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
        //====================================================================
        Padding(
          padding:
              const EdgeInsets.only(bottom: 8.0, left: 15, right: 15, top: 10),
          child: TextField(
            controller: _personalAddressController,
            focusNode: _personalAddressFocusNode,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.list_alt_rounded),
              hintText: "Address",
              prefixIconColor: Colors.grey,
              hintStyle: const TextStyle(
                fontSize: 23,
              ),
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 2,
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
        //======================================================================
        Padding(
          padding:
              const EdgeInsets.only(bottom: 8.0, left: 15, right: 15, top: 10),
          child: TextField(
            controller: _personalPostCodeController,
            focusNode: _personalPostCodeFocusNode,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.confirmation_number_outlined),
              hintText: "Post Code",
              prefixIconColor: Colors.grey,
              hintStyle: const TextStyle(
                fontSize: 23,
              ),
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 2,
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
            keyboardType: TextInputType.phone,
            style: const TextStyle(
              fontSize: 23,
            ),
          ),
        ),
        const SizedBox(
          height: 100,
        ),
        //============================================================
        Padding(
          padding:
              const EdgeInsets.only(bottom: 8.0, left: 15, right: 15, top: 12),
          child: SizedBox(
            height: 60,
            width: 360,
            child: ElevatedButton(
              onPressed: () {
                addPersonalDetails(
                  _personalNameController.text.toString(),
                  _personalAddressController.text.toString(),
                  _personalPostCodeController.text.toString(),
                );
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
      ]),
    );
  }
}
