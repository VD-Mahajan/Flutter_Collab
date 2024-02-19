import 'package:flutter/material.dart';

class FertilizerInformation extends StatefulWidget {
  const FertilizerInformation({super.key});

  @override
  State createState() => _FertilizerInformationState();
}

class _FertilizerInformationState extends State {
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
        child: Text('Weocome to fertilizer information'),
      ),
    );
  }
}
