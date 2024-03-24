import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

fetchProfileData() async {
  final collectionReference =
      FirebaseFirestore.instance.collection('Personal info');
  final QuerySnapshot<Map<String, dynamic>> querySnapshot;

  querySnapshot = await collectionReference
      .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
      .get();
  return querySnapshot.docs.map((doc) => doc.data()).toList();
}

fetchData() async {
  final collectionReference =
      FirebaseFirestore.instance.collection('Personal info');
  final QuerySnapshot<Map<String, dynamic>> querySnapshot;

  querySnapshot = await collectionReference
      .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
      .get();
  final data = await querySnapshot.docs.map((doc) => doc.data()).toList();

  return data[0]['Name'];
}
