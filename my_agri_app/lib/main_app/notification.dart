import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
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

  Future<List<Map<String, dynamic>>> getNotifications() async {
    final collectionReference =
        FirebaseFirestore.instance.collection('notifications');
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await collectionReference.get();
    final data = querySnapshot.docs.map((doc) => doc.data()).toList();
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder(
        future: getNotifications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final data = snapshot.data!.toList();
            return ListView.builder(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ListTile(
                          title: Text(data[index]['message']),
                          tileColor: Colors.green,
                          textColor: Colors.white,
                          // Text(data[index]['message']),
                        ),
                      ),
                    ],
                  );
                });
          } else {
            return Center();
          }
        },
      ),
    );
  }
}
