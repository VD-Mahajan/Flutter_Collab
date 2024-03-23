import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String? name;
dynamic data;

fetchProfileData() async {
  final collectionReference =
      FirebaseFirestore.instance.collection('Personal info');
  final QuerySnapshot<Map<String, dynamic>> querySnapshot;

  querySnapshot = await collectionReference
      .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
      .get();
  data = querySnapshot.docs.map((doc) => doc.data()).toList();
}

fetchData() async {
  final collectionReference =
      FirebaseFirestore.instance.collection('Personal info');
  final QuerySnapshot<Map<String, dynamic>> querySnapshot;

  querySnapshot = await collectionReference
      .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
      .get();
  final data = await querySnapshot.docs.map((doc) => doc.data()).toList();

  name = data[0]['Name'];
}
