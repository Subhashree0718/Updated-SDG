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
        title: const Text("Food Waste Tracker", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
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

  /// **📌 Section Title**
  Widget _buildHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  /// **📊 Summary Card for Total Waste**
  Widget _buildSummaryCard() {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Total Waste Today: 30%", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.redAccent)),
            const SizedBox(height: 8),
            const Text("Weekly Average: 28%", style: TextStyle(fontSize: 16, color: Colors.white70)),
          ],
        ),
      ),
    );
  }

  /// **🥧 Pie Chart for Meal-wise Waste Breakdown**
  Widget _buildPieChart() {
    final List<_PieData> pieData = [
      _PieData("Breakfast", 25),
      _PieData("Lunch", 40),
      _PieData("Dinner", 35),
    ];

    return SizedBox(
      height: 250,
      child: SfCircularChart(
        legend: const Legend(isVisible: true, textStyle: TextStyle(color: Colors.white)),
        series: <CircularSeries<_PieData, String>>[
          PieSeries<_PieData, String>(
            dataSource: pieData,
            xValueMapper: (_PieData data, _) => data.meal,
            yValueMapper: (_PieData data, _) => data.waste,
            dataLabelSettings: const DataLabelSettings(isVisible: true, textStyle: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }
}

/// **📊 Pie Chart Data Model**
class _PieData {
  final String meal;
  final double waste;
  _PieData(this.meal, this.waste);
}
