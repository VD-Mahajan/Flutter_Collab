import 'package:flutter/material.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State createState() => _PersonalDetails();
}

class _PersonalDetails extends State<PersonalDetails> {
  final TextEditingController _personal_name_Controller =
      TextEditingController();
  final FocusNode _personal_name_FocusNode = FocusNode();

  final TextEditingController _personal_address_Controller =
      TextEditingController();
  final FocusNode _personal_address_focus = FocusNode();

  final TextEditingController _personal_postCode_Controller =
      TextEditingController();
  final FocusNode _personal_postCode_focus = FocusNode();

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
            controller: _personal_name_Controller,
            focusNode: _personal_name_FocusNode,
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
            controller: _personal_address_Controller,
            focusNode: _personal_address_focus,
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
            controller: _personal_postCode_Controller,
            focusNode: _personal_postCode_focus,
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
              onPressed: () {},
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
