import 'package:flutter/material.dart';

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

// class BottomNavBar

class _HomePageState extends State {
  int number = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "Krushi Mitra",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const Notifications();
              }));
            },
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          )
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.green[200],
        child: ListView(
          children: [
            const SizedBox(
              height: 100,
              child: CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/logo1.png'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: ListTile(
                leading: const Icon(Icons.contact_emergency_rounded),
                title: const Text(
                  "About Us",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                // tileColor: Colors.red,
                onTap: () {
                  // print("hello");
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 45.0),
              child: Text('work in progress.....'),
            ),
          ],
        ),
      ),
      //=========================== BODY ===================================================
      body: ListView(
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              //--------------------------- WEATHER REPORT ------------------------------
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 20, right: 5),
                child: GestureDetector(
                  onTap: () => {
                    Navigator.pushNamed(context, '/weather'),
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green[400],
                    ),
                    height: 230,
                    width: 180,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              'assets/weather.jpg',
                              height: 150,
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
              ),
              //----------------------------- CULTAVATION TIPS -----------------------------------
              Padding(
                padding: const EdgeInsets.only(left: 5.0, top: 20, right: 10),
                child: GestureDetector(
                  onTap: () => {
                    Navigator.pushNamed(context, '/cultivationtips'),
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green[400],
                    ),
                    height: 230,
                    width: 180,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              'assets/tips.jpg',
                              height: 150,
                            ),
                          ),
                          const SizedBox(
                            height: 13,
                          ),
                          const Text(
                            "Cultivation Tips",
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
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          //-------------------------- Seeds Section ------------------------------
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 20, right: 5),
                child: GestureDetector(
                  onTap: () => {
                    Navigator.pushNamed(context, '/cropdisease'),
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green[400],
                    ),
                    height: 230,
                    width: 180,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              'assets/seeds.jpg',
                              height: 150,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Disease Info",
                            maxLines: null,
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
              ),
              //----------------------------------------------------------------------------------
              Padding(
                padding: const EdgeInsets.only(left: 5.0, top: 20, right: 10),
                child: GestureDetector(
                  onTap: () => {
                    Navigator.pushNamed(context, '/fertilizer'),
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green[400],
                    ),
                    height: 230,
                    width: 180,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              'assets/fertilizer.jpg',
                              height: 150,
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
