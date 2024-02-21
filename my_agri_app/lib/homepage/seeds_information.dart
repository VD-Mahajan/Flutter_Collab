import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SeedsInformation extends StatefulWidget {
  const SeedsInformation({super.key});

  @override
  State createState() => _SeedsInformationState();
}

class _SeedsInformationState extends State {
  bool flag = false;
  final TextEditingController _searchBarController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchBarController.addListener(() {});
  }

  Future<List<Map<String, dynamic>>> getDataFromFirestore(String search) async {
    final collectionReference = FirebaseFirestore.instance.collection('seeds');
    final QuerySnapshot<Map<String, dynamic>> querySnapshot;

    if (search.isEmpty) {
      querySnapshot = await collectionReference.get();
    } else {
      querySnapshot = await collectionReference
          .where('name', isEqualTo: search)
          .get();
    }
    final data = querySnapshot.docs.map((doc) => doc.data()).toList();
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.green,
        title:Container(
              // alignment: Alignment.center,
              // height: 50,
                child: TextField(
                  controller: _searchBarController,
                  // textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    
                    hintText: 'search seeds',
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          
                        });
                      },
                      icon: const Icon(
                        Icons.search,
                      ),
                      color: Colors.black,
                    ),
                    
                  ),
                ),
              ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getDataFromFirestore(
            _searchBarController.text.toStrin),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final data = snapshot.data!.toList();
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 300,
                    width: 300,
                    child: Image.network(
                      data[index]["image"].toString(),
                    ),
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
