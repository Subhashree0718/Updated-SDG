// import 'package:flutter/material.dart';

// class FoodWasteTracker extends StatelessWidget {
//   const FoodWasteTracker({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Food Waste Tracker")),
//       body: const Center(child: Text("Food Waste Tracker Page")),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class FoodWasteTracker extends StatelessWidget {
//   const FoodWasteTracker({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Food Waste Tracker")),
//       body: const Center(child: Text("Food Waste Tracker Page")),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FoodWasteTracker extends StatelessWidget {
  const FoodWasteTracker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Food Waste Tracker",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.black,
        elevation: 5,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.blueGrey],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader("📉 Total Food Waste Overview"),
            _buildSummaryCard(),
            const SizedBox(height: 20),
            _buildHeader("🍽 Meal-wise Waste Breakdown"),
            _buildPieChart(),
          ],
        ),
      ),
    );
  }

  /// **📌 Section Title with Styling**
  Widget _buildHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  /// **📊 Improved Summary Card**
  Widget _buildSummaryCard() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.grey[850],
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Total Waste Today: 30%",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Weekly Average: 28%",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// **🥧 Enhanced Pie Chart**
  Widget _buildPieChart() {
    final List<_PieData> pieData = [
      _PieData("Breakfast", 25, Colors.orangeAccent),
      _PieData("Lunch", 40, Colors.lightBlueAccent),
      _PieData("Dinner", 35, Colors.purpleAccent),
    ];

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.grey[850],
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          height: 250,
          child: SfCircularChart(
            legend: const Legend(
              isVisible: true,
              textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            series: <CircularSeries<_PieData, String>>[
              PieSeries<_PieData, String>(
                dataSource: pieData,
                xValueMapper: (_PieData data, _) => data.meal,
                yValueMapper: (_PieData data, _) => data.waste,
                pointColorMapper: (_PieData data, _) => data.color,
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// **📊 Updated Pie Chart Data Model with Colors**
class _PieData {
  final String meal;
  final double waste;
  final Color color;
  _PieData(this.meal, this.waste, this.color);
}
