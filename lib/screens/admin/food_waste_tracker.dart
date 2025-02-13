
import 'package:flutter/material.dart';

class FoodWasteTracker extends StatelessWidget {
  const FoodWasteTracker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Food Waste Tracker")),
      body: const Center(child: Text("Food Waste Tracker Page")),
    );
  }
}
