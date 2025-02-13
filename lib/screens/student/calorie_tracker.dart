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

  /// Load saved bills and calculate total weekly calories
  Future<void> _loadBills() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> storedBills = prefs.getStringList('bills') ?? [];
    int totalCalories = _calculateTotalCalories(storedBills);

    setState(() {
      bills = storedBills;
      totalWeeklyCalories = totalCalories;
    });
  }

  /// Calculate the total calories from all bills
  int _calculateTotalCalories(List<String> billList) {
    int total = 0;
    for (String bill in billList) {
      total += _extractCalories(bill);
    }
    return total;
  }

  /// Extract calories from a bill string
  int _extractCalories(String bill) {
    RegExp regex = RegExp(r"Total Calories: (\d+) cal");
    Match? match = regex.firstMatch(bill);
    if (match != null) {
      return int.parse(match.group(1)!);
    }
    return 0;
  }

  /// Clear all saved bills with confirmation
  Future<void> _clearBills() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Are you sure? This action cannot be undone."),
        action: SnackBarAction(
          label: "CLEAR",
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
    return Theme(
      data: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardTheme: CardTheme(
          color: Colors.grey[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Calorie Tracker",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          actions: [
            if (bills.isNotEmpty)
              IconButton(
                icon: Icon(Icons.delete, color: Colors.redAccent),
                onPressed: _clearBills,
                tooltip: "Clear All Bills",
              ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: bills.isEmpty
                  ? Center(
                      child: Text(
                        "No bills recorded yet",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: bills.length,
                      itemBuilder: (context, index) {
                        int billCalories = _extractCalories(bills[index]);

                        return AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blueAccent.withOpacity(0.3),
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset: Offset(0, 4),
                              ),
                            ],
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
                              SizedBox(height: 8),
                              Text(
                                "Calories: $billCalories cal",
                                style: TextStyle(
                                  color: Colors.greenAccent,
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

            // Weekly Calories Bar (Updated Total Calculation)
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blueGrey[900],
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.4),
                    blurRadius: 12,
                    spreadRadius: 1,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "This Week's Calories:",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  Text(
                    "$totalWeeklyCalories cal",
                    style: TextStyle(
                      color: totalWeeklyCalories > 2000
                          ? Colors.redAccent
                          : Colors.greenAccent,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
