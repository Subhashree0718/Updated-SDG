import 'package:flutter/material.dart';

class CalorieTracker extends StatelessWidget {
  const CalorieTracker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calorie Tracker")),
      body: const Center(child: Text("Calorie Tracker Content Here")),
    );
  }
}
