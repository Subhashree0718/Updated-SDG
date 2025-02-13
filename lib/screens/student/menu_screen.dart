import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  // Food menu items
  final List<Map<String, dynamic>> menuItems = [
    {"name": "Pizza", "calories": 250, "quantity": 0, "image": null},
    {"name": "Pizza", "calories": 250, "quantity": 0, "image": null},
    {"name": "Pasta", "calories": 200, "quantity": 0, "image": null},
    {"name": "Sandwich", "calories": 180, "quantity": 0, "image": null},
    {"name": "Burger", "calories": 300, "quantity": 0, "image": null},
    {"name": "Fries", "calories": 400, "quantity": 0, "image": null},
    {"name": "Salad", "calories": 120, "quantity": 0, "image": null},
    {"name": "Noodles", "calories": 350, "quantity": 0, "image": null},
    {"name": "Rice Bowl", "calories": 500, "quantity": 0, "image": null},
    {"name": "Sushi", "calories": 220, "quantity": 0, "image": null},
    {"name": "Tacos", "calories": 280, "quantity": 0, "image": null},
    {"name": "Ice Cream", "calories": 150, "quantity": 0, "image": null},
    {"name": "Cake", "calories": 320, "quantity": 0, "image": null},
    {"name": "Donut", "calories": 270, "quantity": 0, "image": null},
    {"name": "Wrap", "calories": 230, "quantity": 0, "image": null},
    {"name": "Curry", "calories": 420, "quantity": 0, "image": null},
    {"name": "Dosa", "calories": 130, "quantity": 0, "image": null},
    {"name": "Paneer Tikka", "calories": 260, "quantity": 0, "image": null},
    {"name": "Biryani", "calories": 550, "quantity": 0, "image": null},
    {"name": "Pancakes", "calories": 210, "quantity": 0, "image": null},
    {"name": "Falooda", "calories": 350, "quantity": 0, "image": null},
  ];

  // Function to update quantity
  void updateQuantity(int index, int change) {
    setState(() {
      menuItems[index]["quantity"] =
          (menuItems[index]["quantity"] + change).clamp(0, 99);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark theme
      appBar: AppBar(
        title: const Text("Menu", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            var item = menuItems[index];

            return Card(
              color: Colors.grey[900], // Dark grey card background
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: item["image"] != null
                      ? Image.asset(item["image"], width: 50, height: 50, fit: BoxFit.cover)
                      : const Icon(Icons.fastfood, color: Colors.white, size: 40), // Default icon
                ),
                title: Text(
                  item["name"],
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  "${item["calories"]} kcal",
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle, color: Colors.redAccent, size: 26),
                      onPressed: () => updateQuantity(index, -1),
                    ),
                    Text(
                      "${item["quantity"]}",
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle, color: Colors.greenAccent, size: 26),
                      onPressed: () => updateQuantity(index, 1),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DescriptionScreen(foodItem: item),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

// Description screen for each food item
class DescriptionScreen extends StatelessWidget {
  final Map<String, dynamic> foodItem;
  const DescriptionScreen({Key? key, required this.foodItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(foodItem["name"], style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: foodItem["image"] != null
                  ? Image.asset(foodItem["image"], width: 120, height: 120, fit: BoxFit.cover)
                  : const Icon(Icons.fastfood, color: Colors.white, size: 100), // Default image
            ),
            const SizedBox(height: 20),
            Text(
              foodItem["name"],
              style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "${foodItem["calories"]} kcal",
              style: const TextStyle(color: Colors.grey, fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              "More details about this item will be added soon.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
