import 'package:flutter/material.dart';

class ReleaseMenu extends StatefulWidget {
  const ReleaseMenu({Key? key}) : super(key: key);

  @override
  _ReleaseMenuState createState() => _ReleaseMenuState();
}

class _ReleaseMenuState extends State<ReleaseMenu> {
  // List of available menu items
  final List<String> availableItems = ["Pizza", "Pasta", "Sandwich", "Burger", "Fries", "Salad", "Soup"];

  // Admin-selected menu items
  final List<String> selectedItems = [];

  // Function to add an item to the menu
  void addItem(String item) {
    if (!selectedItems.contains(item)) {
      setState(() {
        selectedItems.add(item);
      });
    }
  }

  // Function to remove an item from the menu
  void removeItem(String item) {
    setState(() {
      selectedItems.remove(item);
    });
  }

  // Function to release the menu
  void releaseMenu() {
    if (selectedItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select at least one item.")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Menu Released: ${selectedItems.join(', ')}")),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Available Items:", style: TextStyle(color: Colors.white, fontSize: 18)),
            Wrap(
              spacing: 8,
              children: availableItems.map((item) {
                return ElevatedButton(
                  onPressed: () => addItem(item),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
                  child: Text(item, style: const TextStyle(color: Colors.black)),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text("Selected Menu:", style: TextStyle(color: Colors.white, fontSize: 18)),
            Expanded(
              child: ListView.builder(
                itemCount: selectedItems.length,
                itemBuilder: (context, index) {
                  var item = selectedItems[index];
                  return Card(
                    color: Colors.grey[900],
                    child: ListTile(
                      title: Text(item, style: const TextStyle(color: Colors.white)),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove_circle, color: Colors.redAccent),
                        onPressed: () => removeItem(item),
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
