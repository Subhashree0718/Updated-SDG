/*import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class BillScreen extends StatelessWidget {
  final List<Map<String, dynamic>> selectedItems;
  final int totalCalories;

  const BillScreen({Key? key, required this.selectedItems, required this.totalCalories}) : super(key: key);

  /// Generates and saves the bill as a text file
  Future<void> downloadBill(BuildContext context) async {
    try {
      final directory = await getExternalStorageDirectory();
      final file = File('${directory?.path}/bill.txt');

      String billContent = "Your Selected Menu:\n";
      for (var item in selectedItems) {
        billContent += "${item['name']} x${item['quantity']} - ${item['calories'] * item['quantity']} cal\n";
      }
      billContent += "\nTotal Calories: $totalCalories cal";

      await file.writeAsString(billContent);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Bill downloaded at: ${file.path}"),
          duration: Duration(seconds: 3),
        ),
      );

      print("Bill downloaded at: ${file.path}");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to download bill")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        cardTheme: CardTheme(
          color: Colors.grey[900],
          elevation: 4,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(title: Text("Your Bill", style: TextStyle(fontWeight: FontWeight.bold))),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: selectedItems.length,
                  itemBuilder: (context, index) {
                    var item = selectedItems[index];
                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.fastfood, color: Colors.orangeAccent),
                        title: Text(
                          "${item['name']} x${item['quantity']}",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "${item['calories'] * item['quantity']} cal",
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Divider(color: Colors.grey[700]),
              Text(
                "Total Calories: $totalCalories cal",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => downloadBill(context),
                icon: Icon(Icons.download, color: Colors.white),
                label: Text("Download Bill", style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BillScreen extends StatelessWidget {
  final List<Map<String, dynamic>> selectedItems;
  final int totalCalories;

  const BillScreen({Key? key, required this.selectedItems, required this.totalCalories}) : super(key: key);

  /// Save bill to local storage
  Future<void> saveBillToLocalStorage(String billContent) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> bills = prefs.getStringList('bills') ?? [];
    bills.add(billContent);
    await prefs.setStringList('bills', bills);
  }

  /// Generates and saves the bill as a text file
  Future<void> downloadBill(BuildContext context) async {
    try {
      final directory = await getExternalStorageDirectory();
      final file = File('${directory?.path}/bill.txt');

      String billContent = "Your Selected Menu:\n";
      for (var item in selectedItems) {
        billContent += "${item['name']} x${item['quantity']} - ${item['calories'] * item['quantity']} cal\n";
      }
      billContent += "\nTotal Calories: $totalCalories cal";

      await file.writeAsString(billContent);

      // Save bill locally
      await saveBillToLocalStorage(billContent);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Bill downloaded and saved!"),
          duration: Duration(seconds: 3),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to save bill")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        cardTheme: CardTheme(
          color: Colors.grey[900],
          elevation: 4,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(title: Text("Your Bill", style: TextStyle(fontWeight: FontWeight.bold))),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: selectedItems.length,
                  itemBuilder: (context, index) {
                    var item = selectedItems[index];
                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.fastfood, color: Colors.orangeAccent),
                        title: Text(
                          "${item['name']} x${item['quantity']}",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "${item['calories'] * item['quantity']} cal",
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Divider(color: Colors.grey[700]),
              Text(
                "Total Calories: $totalCalories cal",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => downloadBill(context),
                icon: Icon(Icons.download, color: Colors.white),
                label: Text("Download Bill", style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


