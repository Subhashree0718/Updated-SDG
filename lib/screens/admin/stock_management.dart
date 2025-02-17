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
  final List<Map<String, dynamic>> stockItems = [
    {"name": "Rice", "quantity": 50},
    {"name": "Urad Dal", "quantity": 20},
    {"name": "Toor Dal", "quantity": 15},
    {"name": "Wheat Flour", "quantity": 30},
    {"name": "Coconut", "quantity": 15},
    {"name": "Tomato", "quantity": 20},
    {"name": "Onion", "quantity": 25},
    {"name": "Milk", "quantity": 20},
    {"name": "Ghee", "quantity": 10},
    {"name": "Oil", "quantity": 30}
  ];

  void updateStock(int index, int change) {
    setState(() {
      stockItems[index]["quantity"] =
          (stockItems[index]["quantity"] + change).clamp(0, 999);
    });
  }

  void setStock(int index, String value) {
    int? newQuantity = int.tryParse(value);
    if (newQuantity != null && newQuantity >= 0) {
      setState(() {
        stockItems[index]["quantity"] = newQuantity.clamp(0, 999);
      });
    }
  }

  void removeItem(int index) {
    setState(() {
      stockItems.removeAt(index);
    });
  }

  void addNewItem(String itemName) {
    if (itemName.isNotEmpty && !stockItems.any((item) => item["name"] == itemName)) {
      setState(() {
        stockItems.add({"name": itemName, "quantity": 0});
      });
    }
  }

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
            Expanded(
              child: ListView.builder(
                itemCount: stockItems.length,
                itemBuilder: (context, index) {
                  var item = stockItems[index];
                  bool isLowStock = item["quantity"] < 5;

                  return Card(
                    color: Colors.grey[900],
                    child: ListTile(
                      title: Text(
                        item["name"],
                        style: TextStyle(color: isLowStock ? Colors.redAccent : Colors.white),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle, color: Colors.redAccent),
                            onPressed: () => updateStock(index, -1),
                          ),
                          SizedBox(
                            width: 50,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white),
                              controller: TextEditingController()
                                ..text = item["quantity"].toString(),
                              onSubmitted: (value) => setStock(index, value),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
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