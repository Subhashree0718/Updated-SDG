import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'dart:ui';
import 'BillScreen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<Map<String, dynamic>> menuItems = [
    {"name": "Pizza", "calories": 250, "quantity": 0, "image": null},
    {"name": "Pasta", "calories": 200, "quantity": 0, "image": null},
    {"name": "Burger", "calories": 300, "quantity": 0, "image": null},
    {"name": "Fries", "calories": 400, "quantity": 0, "image": null},
    {"name": "Salad", "calories": 120, "quantity": 0, "image": null},
    {"name": "Sushi", "calories": 220, "quantity": 0, "image": null},
    {"name": "Biryani", "calories": 550, "quantity": 0, "image": null},
    {"name": "Falooda", "calories": 350, "quantity": 0, "image": null},
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  /// Submits the selected menu items and navigates to the BillScreen
  void submitMenu() {
    List<Map<String, dynamic>> selectedItems =
        menuItems.where((item) => item['quantity'] > 0).toList();

    int totalCalories = selectedItems.fold<int>(
      0,
      (int sum, item) =>
          sum + (item['calories'] as int) * (item['quantity'] as int),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BillScreen(
          selectedItems: selectedItems,
          totalCalories: totalCalories,
        ),
      ),
    );
  }

  /// Updates the quantity of a menu item
  void updateQuantity(int index, int change) {
    setState(() {
      int newQuantity = menuItems[index]["quantity"] + change;
      if (newQuantity >= 0) {
        menuItems[index]["quantity"] = newQuantity;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background
      appBar: AppBar(
        title: const Text("Menu"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: ListView.builder(
          itemCount: menuItems.length,
          padding: const EdgeInsets.all(10),
          itemBuilder: (context, index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08), // Glassmorphism effect
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(15),
                leading: menuItems[index]["image"] != null
                    ? Image.asset(menuItems[index]["image"]!,
                        width: 50, height: 50, fit: BoxFit.cover)
                    : const Icon(Icons.fastfood, color: Colors.orangeAccent, size: 40),
                title: Text(
                  menuItems[index]["name"],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  "Calories: ${menuItems[index]["calories"]}",
                  style: TextStyle(color: Colors.grey[400], fontSize: 14),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () => updateQuantity(index, -1),
                      child: AnimatedScale(
                        scale: 1.1,
                        duration: const Duration(milliseconds: 300),
                        child: const Icon(Icons.remove_circle_outline,
                            color: Colors.redAccent, size: 30),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      menuItems[index]["quantity"].toString(),
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => updateQuantity(index, 1),
                      child: AnimatedScale(
                        scale: 1.1,
                        duration: const Duration(milliseconds: 300),
                        child: const Icon(Icons.add_circle_outline,
                            color: Colors.greenAccent, size: 30),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: TweenAnimationBuilder(
        tween: Tween<double>(begin: 1.0, end: 1.2),
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        builder: (context, scale, child) {
          return Transform.scale(
            scale: scale,
            child: FloatingActionButton.extended(
              onPressed: submitMenu,
              backgroundColor: Colors.blueAccent.withOpacity(0.8),
              label: const Text(
                "Submit Menu",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              icon: const Icon(Icons.check, size: 24),
            ),
          );
        },
      ),
    );
  }
}
