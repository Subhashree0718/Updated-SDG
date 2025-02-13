// import 'package:flutter/material.dart';

// class StockManagement extends StatelessWidget {
//   const StockManagement({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Stock Management")),
//       body: const Center(child: Text("Stock Management Page")),
//     );
//   }
// }
import 'package:flutter/material.dart';

class StockManagement extends StatefulWidget {
  const StockManagement({Key? key}) : super(key: key);

  @override
  _StockManagementState createState() => _StockManagementState();
}

class _StockManagementState extends State<StockManagement> {
  // Food stock list (Sample Data)
  final List<Map<String, dynamic>> stockItems = [
    {"name": "Pizza", "quantity": 10},
    {"name": "Pasta", "quantity": 5},
    {"name": "Sandwich", "quantity": 2},
    {"name": "Burger", "quantity": 12},
    {"name": "Fries", "quantity": 4},
  ];

  // Function to update stock quantity
  void updateStock(int index, int change) {
    setState(() {
      stockItems[index]["quantity"] =
          (stockItems[index]["quantity"] + change).clamp(0, 999);
    });
  }

  // Function to remove an item from stock
  void removeItem(int index) {
    setState(() {
      stockItems.removeAt(index);
    });
  }

  // Function to add a new item to stock
  void addNewItem(String itemName) {
    if (itemName.isNotEmpty && !stockItems.any((item) => item["name"] == itemName)) {
      setState(() {
        stockItems.add({"name": itemName, "quantity": 0});
      });
    }
  }

  // Text Controller for adding new item
  final TextEditingController _newItemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Stock Management", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Add New Stock Item Section
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _newItemController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Enter food item",
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey[900],
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle, color: Colors.greenAccent, size: 30),
                  onPressed: () {
                    addNewItem(_newItemController.text);
                    _newItemController.clear();
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Stock List
            Expanded(
              child: ListView.builder(
                itemCount: stockItems.length,
                itemBuilder: (context, index) {
                  var item = stockItems[index];
                  bool isLowStock = item["quantity"] < 5; // Low stock warning

                  return Card(
                    color: Colors.grey[900],
                    child: ListTile(
                      title: Text(
                        item["name"],
                        style: TextStyle(color: isLowStock ? Colors.redAccent : Colors.white),
                      ),
                      subtitle: Text("Stock: ${item["quantity"]} units",
                          style: TextStyle(color: isLowStock ? Colors.redAccent : Colors.grey)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle, color: Colors.redAccent),
                            onPressed: () => updateStock(index, -1),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_circle, color: Colors.greenAccent),
                            onPressed: () => updateStock(index, 1),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.white),
                            onPressed: () => removeItem(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
