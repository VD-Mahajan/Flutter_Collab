import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class CropDisease extends StatefulWidget {
  const CropDisease({super.key});

  @override
  State<StatefulWidget> createState() => _CropDiseaseState();
}

class _CropDiseaseState extends State {
  //VARIABLES
  String type = '';

  //LIST
  List cropNames = ['सोयाबीन', 'ऊस', 'गहू'];

  int selectedIndex = -1;

  //METHODS
  Future<List<Map<String, dynamic>>> getCropDiseaseDataFromFireStore(
      String type) async {
    final collectionReference =
        FirebaseFirestore.instance.collection('cropDiseaseData');
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

  showBottomSheet(String name, String image, String info) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(image),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(info),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      drawer: Drawer(
        elevation: 5,
        width: 230,
        backgroundColor: Colors.green[300],
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 80,
          ),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            itemCount: cropNames.length,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cropNames[index],
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      (index != selectedIndex)
                          ? Icons.check_box_outline_blank
                          : Icons.check_box,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        if (index == selectedIndex) {
                          selectedIndex = -1;
                        } else {
                          selectedIndex = index;
                        }
                        if (selectedIndex == -1) {
                          type = '';
                        } else {
                          type = cropNames[selectedIndex];
                        }
                      });
                    },
                  )
                ],
              );
            },
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text(
          "Disease Treatement",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder(
        future: getCropDiseaseDataFromFireStore(type),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final data = snapshot.data!.toList();
            return ListView.builder(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 10,
                  ),
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    elevation: 5,
                    color: Colors.green[300],
                    child: Row(
                      children: [
                        Column(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                              ),
                              child: Image.network(
                                data[index]['image'],
                                height: 130,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            // vertical: 5,
                            horizontal: 10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data[index]['name'],
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  // color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: SizedBox(
                                  width: 180,
                                  child: Text(
                                    data[index]['information'],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green[600],
                                  ),
                                  onPressed: () {
                                    showBottomSheet(
                                        data[index]["name"],
                                        data[index]["image"],
                                        data[index]["information"]);
                                  },
                                  child: const Text(
                                    "तपशील वाचा",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              // ),
            );
          } else {
            return Center();
          }
        },
      ),
    );
  }
}
