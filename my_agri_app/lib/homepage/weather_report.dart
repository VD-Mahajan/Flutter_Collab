import 'package:flutter/material.dart';

class WeatherReport extends StatefulWidget {
  const WeatherReport({super.key});

  @override
  State createState() => _WeatherReportState();
}

class _WeatherReportState extends State {
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
        child: Text('Welcome to Weather report'),
      ),
    );
  }
}
