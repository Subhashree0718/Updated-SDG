import 'package:flutter/material.dart';

class ReleaseMenu extends StatefulWidget {
  const ReleaseMenu({Key? key}) : super(key: key);

  @override
  _ReleaseMenuState createState() => _ReleaseMenuState();
}

class _ReleaseMenuState extends State<ReleaseMenu> {
  // List of available menu items
   final List<String> availableItems = ["Idli", "Dosa", "Biryani", "Chapati", "Pongal", "Upma", "Paniyaram", "Uthappam", "Parotta", "Vada", "Sambar", "Rasam", "Kootu", "Kuzhambu", "Thayir Sadam", "Lemon Rice", "Puliyodarai", "Tomato Rice", "Coconut Rice", "Sakkarai Pongal"];
  // Admin-selected menu items
  final List<String> selectedItems = [];

  // Function to add an item to the menu
  void addItem(String item) {
    if (!selectedItems.contains(item)) {
      setState(() {
        selectedItems.add(item);
      });

      // Show a confirmation snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("$item added!", style: const TextStyle(color: Colors.white)),
          backgroundColor: Colors.green,
          duration: const Duration(milliseconds: 700),
        ),
      );
    }
  }

  // Function to remove an item from the menu
  void removeItem(String item) {
    setState(() {
      selectedItems.remove(item);
    });

    // Show a confirmation snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$item removed!", style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        duration: const Duration(milliseconds: 700),
      ),
    );
  }

  // Function to release the menu
  void releaseMenu() {
    if (selectedItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select at least one item.", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Menu Released: ${selectedItems.join(', ')}", style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
      ),
    );

    // Here, you can send `selectedItems` to a database or another screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Release Menu",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        elevation: 4,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.blueGrey],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("📌 Available Items"),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: availableItems.map((item) {
                return ElevatedButton(
                  onPressed: () => addItem(item),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent[700],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  ),
                  child: Text(item, style: const TextStyle(color: Colors.black, fontSize: 16)),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle("✅ Selected Menu"),
            Expanded(
              child: selectedItems.isEmpty
                  ? const Center(
                      child: Text(
                        "No items selected",
                        style: TextStyle(color: Colors.white54, fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: selectedItems.length,
                      itemBuilder: (context, index) {
                        var item = selectedItems[index];
                        return _buildSelectedItemCard(item);
                      },
                    ),
            ),
            _buildReleaseButton(),
          ],
        ),
      ),
    );
  }

  /// **📌 Section Title with Styling**
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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

  /// **📋 Stylish Card for Selected Items**
  Widget _buildSelectedItemCard(String item) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.grey[900],
      child: ListTile(
        title: Text(
          item,
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.remove_circle, color: Colors.redAccent, size: 28),
          onPressed: () => removeItem(item),
        ),
      ),
    );
  }

  /// **🚀 Release Menu Button**
  Widget _buildReleaseButton() {
    return ElevatedButton(
      onPressed: releaseMenu,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.greenAccent[700],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      child: const Center(
        child: Text(
          "Release Menu",
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
