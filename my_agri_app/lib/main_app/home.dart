import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'notification.dart';
// import 'package:flutter/services.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:my_agri_app/main_app/bottomnavigationbar.dart';
// import 'package:my_agri_app/main_app/marketplace.dart';
// import 'package:my_agri_app/main_app/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State {
  int number = 1;
  String? name;

  //LIST
  List images = [
    'assets/image_1.png',
    'assets/image_2.png',
    'assets/image_3.png',
  ];

  fetchData() async {
    final collectionReference =
        FirebaseFirestore.instance.collection('Personal info');
    final QuerySnapshot<Map<String, dynamic>> querySnapshot;

    querySnapshot = await collectionReference
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get();
    final data = querySnapshot.docs.map((doc) => doc.data()).toList();
    name = data[0]['Name'];
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.green[100],
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.green,
      //   title: const Text(
      //     "Krushi Mitra",
      //     style: TextStyle(
      //       fontSize: 25,
      //       fontWeight: FontWeight.bold,
      //       color: Colors.white,
      //     ),
      //   ),
      //   centerTitle: true,
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         Navigator.push(context, MaterialPageRoute(builder: (context) {
      //           return const Notifications();
      //         }));
      //       },
      //       icon: const Icon(
      //         Icons.notifications,
      //         color: Colors.white,
      //       ),
      //     )
      //   ],
      // ),
      // drawer: Drawer(
      //   backgroundColor: Colors.green[200],
      //   child: ListView(
      //     children: [
      //       const SizedBox(
      //         height: 100,
      //         child: CircleAvatar(
      //           radius: 70,
      //           backgroundImage: AssetImage('assets/logo1.png'),
      //         ),
      //       ),
      //       const SizedBox(
      //         height: 10,
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.only(left: 30.0),
      //         child: ListTile(
      //           leading: const Icon(Icons.contact_emergency_rounded),
      //           title: const Text(
      //             "About Us",
      //             style: TextStyle(
      //               fontSize: 20,
      //             ),
      //           ),
      //           // tileColor: Colors.red,
      //           onTap: () {
      //             // print("hello");
      //           },
      //         ),
      //       ),
      //       const SizedBox(
      //         height: 10,
      //       ),
      //       const Padding(
      //         padding: EdgeInsets.only(left: 45.0),
      //         child: Text('work in progress.....'),
      //       ),
      //     ],
      //   ),
      // ),
      //=========================== BODY ===================================================
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                top: 30.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello 👋',
                    style: GoogleFonts.quicksand(
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    '$name',
                    style: GoogleFonts.quicksand(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CarouselSlider(
                    items: images.map((e) {
                      return Container(
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage(e)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      height: 200,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      viewportFraction: 1,
                      aspectRatio: 16 / 9,
                      enableInfiniteScroll: true,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    //--------------------------- WEATHER REPORT ------------------------------
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: GestureDetector(
                        onTap: () => {
                          Navigator.pushNamed(context, '/weather'),
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width * 0.45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.green[400],
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 4,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  'assets/weather.jpg',
                                  height: 130,
                                ),
                              ),
                              const SizedBox(
                                height: 13,
                              ),
                              const Text(
                                "Weather Report",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //----------------------------- CULTAVATION TIPS -----------------------------------
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: GestureDetector(
                        onTap: () => {
                          Navigator.pushNamed(context, '/cultivationtips'),
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width * 0.45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.green[400],
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 4,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  'assets/tips.jpg',
                                  height: 130,
                                ),
                              ),
                              const SizedBox(
                                height: 13,
                              ),
                              const Text(
                                "Cultivation tips",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                //-------------------------- Disease Section ------------------------------
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: GestureDetector(
                        onTap: () => {
                          Navigator.pushNamed(context, '/cropdisease'),
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width * 0.45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.green[400],
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 4,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  'assets/seeds.jpg',
                                  height: 130,
                                ),
                              ),
                              const SizedBox(
                                height: 13,
                              ),
                              const Text(
                                "Disease Info",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //---------------------------------------Fertilizer Section-----------------------------------------
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: GestureDetector(
                        onTap: () => {
                          Navigator.pushNamed(context, '/fertilizer'),
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width * 0.45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.green[400],
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 4,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  'assets/fertilizer.jpg',
                                  height: 130,
                                ),
                              ),
                              const SizedBox(
                                height: 13,
                              ),
                              const Text(
                                "Fertilizers Info",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
