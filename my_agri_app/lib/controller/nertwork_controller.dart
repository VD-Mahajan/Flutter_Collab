// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class NetworkController extends GetxController {
//   final Connectivity _connectivity = Connectivity();

//   @override
//   void onInit() {
//     super.onInit();
//     _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
//   }

//   void _updateConnectionStatus(ConnectivityResult connectivityResult) {
//     // bool noConnection = connectivityResult.contains(ConnectivityResult.none);
//     if (connectivityResult == ConnectivityResult.none) {
//       Get.rawSnackbar(
//         messageText: const Text('Please connect to the internet'),
//         isDismissible: false,
//         duration: const Duration(days: 1),
//         backgroundColor: Colors.red,
//         icon: const Icon(
//           Icons.wifi_off,
//           color: Colors.white,
//         ),
//         snackStyle: SnackStyle.FLOATING,
//       );
//     } else {
//       if (Get.isSnackbarOpen) {
//         Get.closeCurrentSnackbar();
//       }
//     }
//   }
// }
