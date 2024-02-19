import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_agri_app/main_app/bottomnavigationbar.dart';

class MarketPlace extends StatefulWidget {
  const MarketPlace({super.key});

  @override
  State createState() => _MarketPlaceState();
}

class _MarketPlaceState extends State {
  Future<List<Map<String, dynamic>>> getDataFromFirestore(String type) async {
    final collectionReference = FirebaseFirestore.instance.collection('market');
    final QuerySnapshot<Map<String, dynamic>> querySnapshot;
    if (type.isEmpty) {
      querySnapshot = await collectionReference.get();
    } else {
      querySnapshot =
          await collectionReference.where('type', isEqualTo: type).get();
    }
    final data = querySnapshot.docs.map((doc) => doc.data()).toList();

    return data;
  }

  String type = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        elevation: 5,
        width: 250,
        backgroundColor: Colors.green[400],
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Filter with ',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  'Flowers',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (type.isEmpty) {
                        type = 'flower';
                      } else {
                        type = '';
                      }
                    });
                  },
                  icon: (type == 'flower')
                      ? const Icon(Icons.check_box)
                      : const Icon(Icons.check_box_outline_blank),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  'Fertilizers',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (type.isEmpty) {
                        type = 'fertilizer';
                      } else {
                        type = '';
                      }
                    });
                  },
                  icon: (type == 'fertilizer')
                      ? const Icon(Icons.check_box)
                      : const Icon(Icons.check_box_outline_blank),
                ),
              ],
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'Market Place',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 5, right: 15),
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.shopping_cart_rounded,
                  color: Colors.white,
                )),
          ),
        ],
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder(
        future: getDataFromFirestore(type),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final data = snapshot.data!.toList();
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Image.network(
                            data[index]["image"].toString(),
                            height: 180,
                            // fit: BoxFit.contain,
                          ),
                          Text(
                            'name : ${data[index]["name"].toString()} \nPrice : ${data[index]["price"]}',
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            child: const Text(
                              'Add to Cart',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center();
          }
        },
      ),
    );
  }
}
