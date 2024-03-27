import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State {
  int number = 1;
  int _currentIndex = 0;
  String? userName;

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
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  fetchUserName() async {
    final data = await fetchData();
    setState(() {
      userName = data[0]['Name'].toString();
    });
  }

  final CarouselController _carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (userName == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            top: 30.0,
                          ),
                          child: Text(
                            'Hello 👋',
                            style: GoogleFonts.quicksand(
                              fontSize: 30,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            // top: 30.0,
                          ),
                          child: Text(
                            '$userName',
                            style: GoogleFonts.quicksand(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: CarouselSlider(
                            items: List.generate(images.length, (index) {
                              return Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(images[index]),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              );
                            }),
                            options: CarouselOptions(
                              height: 200,
                              autoPlay: true,
                              enlargeCenterPage: true,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              viewportFraction: 1,
                              aspectRatio: 16 / 9,
                              enableInfiniteScroll: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentIndex = index;
                                });
                              },
                            ),
                            carouselController: _carouselController,
                          ),
                        ),
                        const SizedBox(),
                        Center(
                          child: DotsIndicator(
                            dotsCount: images.length,
                            position: _currentIndex,
                            decorator: const DotsDecorator(
                              activeColor: Colors.green,
                              // size: Size.square(8.0),
                            ),
                          ),
                        ),
                      ],
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
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
                                        "हवामान अहवाल",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
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
                                  Navigator.pushNamed(
                                      context, '/cultivationtips'),
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
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
                                        "लागवडीच्या टिप्स",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
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
                                        "रोग संबंधित माहिती",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
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
                                        "खते माहिती",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
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
              );
            }
          }),
    );
  }
}
