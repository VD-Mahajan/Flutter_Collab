// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:my_agri_app/main_app/home.dart';

// class OTPScreen extends StatefulWidget {
//   String verificationId;
//   OTPScreen({super.key, required this.verificationId});

//   @override
//   State<OTPScreen> createState() => _OTPScreenState();
// }

// class _OTPScreenState extends State<OTPScreen> {
//   final TextEditingController _otpController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextFormField(
//               controller: _otpController,
//               validator: (value) {},
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 try {
//                   PhoneAuthCredential credential = PhoneAuthProvider.credential(
//                     verificationId: widget.verificationId,
//                     smsCode: _otpController.text.toString(),
//                   );

//                   FirebaseAuth.instance
//                       .signInWithCredential(credential)
//                       .then((value) {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const HomePage(),
//                       ),
//                     );
//                   });
//                 } catch (ex) {}
//               },
//               child: const Text("verify"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
