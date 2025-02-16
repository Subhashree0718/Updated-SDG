// import 'package:flutter/material.dart';
// import 'package:flutter/animation.dart';
// import 'dart:ui';
// import 'BillScreen.dart';

// class MenuScreen extends StatefulWidget {
//   const MenuScreen({Key? key}) : super(key: key);

//   @override
//   _MenuScreenState createState() => _MenuScreenState();
// }

// class _MenuScreenState extends State<MenuScreen> with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;

//   final List<Map<String, dynamic>> menuItems = [
//     {"name": "Idli", "calories": 150, "quantity": 0, "image": null},
// {"name": "Dosa", "calories": 200, "quantity": 0, "image": null},
// {"name": "Chapati", "calories": 180, "quantity": 0, "image": null},
// {"name": "Pongal", "calories": 300, "quantity": 0, "image": null},
// {"name": "Upma", "calories": 250, "quantity": 0, "image": null},
// {"name": "Parotta", "calories": 400, "quantity": 0, "image": null},
// {"name": "Vada", "calories": 350, "quantity": 0, "image": null},
// {"name": "Sambar", "calories": 120, "quantity": 0, "image": null},
// {"name": "Rasam", "calories": 100, "quantity": 0, "image": null},
// {"name": "Biryani", "calories": 550, "quantity": 0, "image": null}

//   ];

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1000),
//     )..forward();

//     _fadeAnimation = CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//     );
//   }

//   /// Submits the selected menu items and navigates to the BillScreen
//   void submitMenu() {
//     List<Map<String, dynamic>> selectedItems =
//         menuItems.where((item) => item['quantity'] > 0).toList();

//     int totalCalories = selectedItems.fold<int>(
//       0,
//       (int sum, item) =>
//           sum + (item['calories'] as int) * (item['quantity'] as int),
//     );

//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => BillScreen(
//           selectedItems: selectedItems,
//           totalCalories: totalCalories,
//         ),
//       ),
//     );
//   }

//   /// Updates the quantity of a menu item
//   void updateQuantity(int index, int change) {
//     setState(() {
//       int newQuantity = menuItems[index]["quantity"] + change;
//       if (newQuantity >= 0) {
//         menuItems[index]["quantity"] = newQuantity;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black, // Dark background
//       appBar: AppBar(
//         title: const Text("Menu"),
//         backgroundColor: Colors.black,
//         foregroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: FadeTransition(
//         opacity: _fadeAnimation,
//         child: ListView.builder(
//           itemCount: menuItems.length,
//           padding: const EdgeInsets.all(10),
//           itemBuilder: (context, index) {
//             return AnimatedContainer(
//               duration: const Duration(milliseconds: 500),
//               curve: Curves.easeInOut,
//               margin: const EdgeInsets.symmetric(vertical: 10),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.08), // Glassmorphism effect
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(color: Colors.white.withOpacity(0.1)),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.2),
//                     blurRadius: 10,
//                     spreadRadius: 2,
//                     offset: const Offset(2, 2),
//                   ),
//                 ],
//               ),
//               child: ListTile(
//                 contentPadding: const EdgeInsets.all(15),
//                 leading: menuItems[index]["image"] != null
//                     ? Image.asset(menuItems[index]["image"]!,
//                         width: 50, height: 50, fit: BoxFit.cover)
//                     : const Icon(Icons.fastfood, color: Colors.orangeAccent, size: 40),
//                 title: Text(
//                   menuItems[index]["name"],
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 subtitle: Text(
//                   "Calories: ${menuItems[index]["calories"]}",
//                   style: TextStyle(color: Colors.grey[400], fontSize: 14),
//                 ),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     GestureDetector(
//                       onTap: () => updateQuantity(index, -1),
//                       child: AnimatedScale(
//                         scale: 1.1,
//                         duration: const Duration(milliseconds: 300),
//                         child: const Icon(Icons.remove_circle_outline,
//                             color: Colors.redAccent, size: 30),
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Text(
//                       menuItems[index]["quantity"].toString(),
//                       style: const TextStyle(fontSize: 18, color: Colors.white),
//                     ),
//                     const SizedBox(width: 8),
//                     GestureDetector(
//                       onTap: () => updateQuantity(index, 1),
//                       child: AnimatedScale(
//                         scale: 1.1,
//                         duration: const Duration(milliseconds: 300),
//                         child: const Icon(Icons.add_circle_outline,
//                             color: Colors.greenAccent, size: 30),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//       floatingActionButton: TweenAnimationBuilder(
//         tween: Tween<double>(begin: 1.0, end: 1.2),
//         duration: const Duration(milliseconds: 800),
//         curve: Curves.easeInOut,
//         builder: (context, scale, child) {
//           return Transform.scale(
//             scale: scale,
//             child: FloatingActionButton.extended(
//               onPressed: submitMenu,
//               backgroundColor: Colors.blueAccent.withOpacity(0.8),
//               label: const Text(
//                 "Submit Menu",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               icon: const Icon(Icons.check, size: 24),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
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
    {"name": "Idli", "calories": 150, "quantity": 0, "icon": "https://cdn-icons-png.flaticon.com/128/3430/3430455.png"},
    {"name": "Dosa", "calories": 200, "quantity": 0, "icon": "https://cdn-icons-png.freepik.com/256/9667/9667414.png?ga=GA1.1.1661353638.1725608911&semt=ais_hybrid"},
    {"name": "Chapati", "calories": 180, "quantity": 0, "icon": "https://cdn-icons-png.flaticon.com/128/4727/4727322.png"},
    {"name": "Chicken Rice", "calories": 300, "quantity": 0, "icon": "https://cdn-icons-png.flaticon.com/128/4780/4780045.png"},
    {"name": "Upma", "calories": 250, "quantity": 0, "icon": "https://cdn-icons-png.flaticon.com/128/11361/11361470.png"},
    {"name": "Parotta", "calories": 400, "quantity": 0, "icon": "https://cdn-icons-png.flaticon.com/128/7843/7843273.png"},
    {"name": "Vada", "calories": 350, "quantity": 0, "icon": "https://cdn-icons-png.flaticon.com/128/9487/9487222.png"},
    {"name": "Sambar", "calories": 120, "quantity": 0, "icon": "https://cdn-icons-png.flaticon.com/128/4286/4286924.png"},
    {"name": "Rasam", "calories": 100, "quantity": 0, "icon": "https://cdn-icons-png.flaticon.com/128/12900/12900367.png"},
    {"name": "Biryani", "calories": 550, "quantity": 0, "icon": "https://cdn-icons-png.flaticon.com/128/4681/4681934.png"},
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

  void submitMenu() {
    List<Map<String, dynamic>> selectedItems =
        menuItems.where((item) => item['quantity'] > 0).toList();

    int totalCalories = selectedItems.fold<int>(
      0,
      (int sum, item) => sum + (item['calories'] as int) * (item['quantity'] as int),
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
      backgroundColor: Colors.black,
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
            return Card(
              color: Colors.grey[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              child: ListTile(
                contentPadding: const EdgeInsets.all(15),
                leading: Image.network(
                  menuItems[index]["icon"],
                  width: 40,
                  height: 40,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.fastfood, color: Colors.white),
                ),
                title: Text(
                  menuItems[index]["name"],
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                ),
                subtitle: Text("Calories: ${menuItems[index]["calories"]}",
                    style: TextStyle(color: Colors.grey[400], fontSize: 14)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline, color: Colors.redAccent),
                      onPressed: () => updateQuantity(index, -1),
                    ),
                    Text(
                      menuItems[index]["quantity"].toString(),
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline, color: Colors.greenAccent),
                      onPressed: () => updateQuantity(index, 1),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: submitMenu,
        backgroundColor: Colors.blueAccent.withOpacity(0.8),
        label: const Text("Submit Menu", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        icon: const Icon(Icons.check, size: 24),
      ),
    );
  }
}
