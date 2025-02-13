import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalorieTracker extends StatefulWidget {
  const CalorieTracker({Key? key}) : super(key: key);

  @override
  _CalorieTrackerState createState() => _CalorieTrackerState();
}

class _CalorieTrackerState extends State<CalorieTracker> {
  List<String> bills = [];
  int totalWeeklyCalories = 0;

  @override
  void initState() {
    super.initState();
    _loadBills();
  }

  Future<void> _loadBills() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> storedBills = prefs.getStringList('bills') ?? [];
    int totalCalories = _calculateTotalCalories(storedBills);

    setState(() {
      bills = storedBills;
      totalWeeklyCalories = totalCalories;
    });
  }

  int _calculateTotalCalories(List<String> billList) {
    int total = 0;
    for (String bill in billList) {
      total += _extractCalories(bill);
    }
    return total;
  }

  int _extractCalories(String bill) {
    RegExp regex = RegExp(r"Total Calories: (\d+) cal");
    Match? match = regex.firstMatch(bill);
    return match != null ? int.parse(match.group(1)!) : 0;
  }

  Future<void> _clearBills() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black87,
        content: Text(
          "Are you sure? This action cannot be undone.",
          style: TextStyle(color: Colors.white),
        ),
        action: SnackBarAction(
          label: "CLEAR",
          textColor: Colors.redAccent,
          onPressed: () async {
            await prefs.remove('bills');
            setState(() {
              bills.clear();
              totalWeeklyCalories = 0;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0F0F1A), // Deep Navy
              Color(0xFF1C1C27), // Charcoal Gray
            ],
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Calorie Tracker",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (bills.isNotEmpty)
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: _clearBills,
                      tooltip: "Clear All Bills",
                    ),
                ],
              ),
            ),
            Expanded(
              child: bills.isEmpty
                  ? Center(
                      child: Text(
                        "No bills recorded yet",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.all(12),
                      itemCount: bills.length,
                      itemBuilder: (context, index) {
                        int billCalories = _extractCalories(bills[index]);

                        return AnimatedContainer(
                          duration: Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Color(0xFF23233A), // Darker Box
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8,
                                spreadRadius: 1,
                                offset: Offset(0, 4),
                              ),
                            ],
                            border: Border.all(color: Colors.grey.shade800, width: 1.2),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                bills[index],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                "Calories: $billCalories cal",
                                style: TextStyle(
                                  color: Colors.green.shade400,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),

            /// **Weekly Calories Section**
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(18),
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xFF23233A), // Matching card color
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: Offset(0, -3),
                  ),
                ],
                border: Border.all(color: Colors.grey.shade700, width: 1.2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "This Week's Calories:",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "$totalWeeklyCalories cal",
                    style: TextStyle(
                      color: totalWeeklyCalories > 2000
                          ? Colors.redAccent
                          : Colors.green.shade400,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
