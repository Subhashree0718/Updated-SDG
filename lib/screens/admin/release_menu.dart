// import 'package:flutter/material.dart';

// class ReleaseMenu extends StatelessWidget {
//   const ReleaseMenu({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Release Menu")),
//       body: const Center(child: Text("Release Menu Page")),
//     );
//   }
// }
import 'package:flutter/material.dart';

class ReleaseMenu extends StatefulWidget {
  const ReleaseMenu({Key? key}) : super(key: key);

  @override
  _ReleaseMenuState createState() => _ReleaseMenuState();
}

class _ReleaseMenuState extends State<ReleaseMenu> {
  // Admin food menu items
  final List<Map<String, dynamic>> menuItems = [
    {"name": "Pizza", "calories": 250, "quantity": 0},
    {"name": "Pasta", "calories": 200, "quantity": 0},
    {"name": "Sandwich", "calories": 180, "quantity": 0},
    {"name": "Burger", "calories": 300, "quantity": 0},
    {"name": "Fries", "calories": 400, "quantity": 0},
  ];

  // Function to update quantity
  void updateQuantity(int index, int change) {
    setState(() {
      menuItems[index]["quantity"] =
          (menuItems[index]["quantity"] + change).clamp(0, 99);
    });
  }

  // Function to release the menu (You can integrate API calls or database updates here)
  void releaseMenu() {
    List<Map<String, dynamic>> selectedItems =
        menuItems.where((item) => item["quantity"] > 0).toList();
    
    if (selectedItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select at least one item.")),
      );
      return;
    }
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Menu Released Successfully!")),
    );
    
    // Here, you can send `selectedItems` to a database or another screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Release Menu", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  var item = menuItems[index];
                  return Card(
                    color: Colors.grey[900],
                    child: ListTile(
                      title: Text(item["name"], style: const TextStyle(color: Colors.white)),
                      subtitle: Text("${item["calories"]} kcal", style: const TextStyle(color: Colors.grey)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle, color: Colors.redAccent),
                            onPressed: () => updateQuantity(index, -1),
                          ),
                          Text("${item["quantity"]}", style: const TextStyle(color: Colors.white)),
                          IconButton(
                            icon: const Icon(Icons.add_circle, color: Colors.greenAccent),
                            onPressed: () => updateQuantity(index, 1),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: releaseMenu,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
              child: const Text("Release Menu", style: TextStyle(color: Colors.black, fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}

