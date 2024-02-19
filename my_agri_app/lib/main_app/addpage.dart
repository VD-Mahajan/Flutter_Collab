import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State createState() => _AddPageState();
}

class _AddPageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('This is Add Page'),
      // ),
      body: const Center(
        child: Text('Add Page'),
      ),
    );
  }
}
