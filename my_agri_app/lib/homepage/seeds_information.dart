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
          .where('name'.toLowerCase(), isEqualTo: search)
          .get();
    }
    final data = querySnapshot.docs.map((doc) => doc.data()).toList();
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        toolbarHeight: 65,
        title: (flag != true)
            ? SizedBox(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_rounded),
                    ),
                    const SizedBox(
                      width: 45,
                    ),
                    const Text(
                      'Seeds Information',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              )
            : SizedBox(
                height: 55,
                child: TextField(
                  controller: _searchBarController,
                  textAlignVertical: TextAlignVertical.center,
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
                          _searchBarController.text = '';
                        });
                      },
                      icon: const Icon(
                        Icons.cancel_rounded,
                      ),
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                flag = !flag;
              });
            },
            icon: const Icon(
              Icons.search_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getDataFromFirestore(
            _searchBarController.text.toLowerCase().toString()),
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
