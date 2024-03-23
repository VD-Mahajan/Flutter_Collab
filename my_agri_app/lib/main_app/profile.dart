import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../firebase_data/methods.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State createState() => _ProfileState();
}

class _ProfileState extends State {
  //VARIABLES
  bool editProfile = false;
  String? name;
  String? phoneNumber;
  String? address;

  //CONTROLLERS
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  //KEYS
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //METHODS
  signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  fetchData() async {
    setState(() {
      _nameController.text = data[0]['Name'].toString();
      _numberController.text = data[0]['phoneNumber'].toString();
      _addressController.text = data[0]['Address'].toString();
    });
  }

  updateProfile() async {
    final reff = FirebaseFirestore.instance
        .collection('Personal info')
        .doc(FirebaseAuth.instance.currentUser!.email);

    await reff.update({
      'Name': _nameController.text.toString(),
      'phoneNumber': _numberController.text.toString(),
      'Address': _addressController.text.toString(),
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    // print('${FirebaseAuth.instance.currentUser!.email}');
    name = _nameController.text;
    phoneNumber = _numberController.text;
    address = _addressController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        width: 200,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 30),
          child: Column(
            children: [
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () async {
                    await signOut();
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Logout'),
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              editProfile = true;
              setState(() {});
              // print(editProfile);
            },
            child: const Text(
              'Edit',
              style: TextStyle(color: Colors.purple),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/user1.png'),
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: TextFormField(
                          controller: _nameController,
                          focusNode: FocusNode(),
                          readOnly: (editProfile) ? false : true,
                          decoration: InputDecoration(
                            hintText: name,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Name cannot be empty';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Phone Number',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: TextFormField(
                          controller: _numberController,
                          readOnly: (editProfile) ? false : true,
                          decoration: InputDecoration(
                            hintText: phoneNumber,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter phone number';
                            } else if (value.length != 10) {
                              return 'invalid phone number';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Address',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          controller: _addressController,
                          readOnly: (editProfile) ? false : true,
                          decoration: InputDecoration(
                            hintText: address,
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
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                (editProfile)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  editProfile = false;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text('Cancel'),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: ElevatedButton(
                              onPressed: () async {
                                bool flag = _formKey.currentState!.validate();
                                if (flag) {
                                  await updateProfile();
                                  setState(() {
                                    editProfile = false;
                                  });
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.green,
                                    content:
                                        Text('Profile updated successfully'),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text('Update Profile'),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
