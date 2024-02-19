import 'package:flutter/material.dart';

class SeedsInformation extends StatefulWidget {
  const SeedsInformation({super.key});

  @override
  State createState() => _SeedsInformationState();
}

class _SeedsInformationState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const Center(
        child: Text('Weocome to seeds information'),
      ),
    );
  }
}
