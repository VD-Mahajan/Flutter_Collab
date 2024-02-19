import 'package:flutter/material.dart';

class CultivationTips extends StatefulWidget {
  const CultivationTips({super.key});

  @override
  State createState() => _CultivationTipsState();
}

class _CultivationTipsState extends State {
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
        child: Text('Welcome to Cultivation tips report'),
      ),
    );
  }
}