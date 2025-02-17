// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'dart:ui';

// import 'feedback_checker.dart';
// import 'food_waste_tracker.dart';
// import 'release_menu.dart';
// import 'stock_management.dart';

// class AdminDashboard extends StatelessWidget {
//   const AdminDashboard({Key? key}) : super(key: key);

//   void navigateToScreen(BuildContext context, Widget screen) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => screen),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: Text("Admin Dashboard",
//             style: GoogleFonts.poppins(
//               fontWeight: FontWeight.bold,
//               fontSize: 22,
//               color: Colors.white,
//             )),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
//           child: LayoutBuilder(
//             builder: (context, constraints) {
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: GridView.builder(
//                       shrinkWrap: true,
//                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 20,
//                         mainAxisSpacing: 20,
//                         childAspectRatio: 1,
//                       ),
//                       itemCount: 4,
//                       itemBuilder: (context, index) {
//                         final screens = [
//                           {"title": "Feedback Checker", "icon": Icons.check_circle, "color": [Colors.orange, Colors.redAccent], "screen": const FeedbackChecker()},
//                           {"title": "Food Waste Tracker", "icon": Icons.food_bank, "color": [Colors.green, Colors.teal], "screen": const FoodWasteTracker()},
//                           {"title": "Release Menu", "icon": Icons.menu_book, "color": [Colors.blue, Colors.lightBlueAccent], "screen": const ReleaseMenu()},
//                           {"title": "Stock Management", "icon": Icons.inventory, "color": [Colors.purple, Colors.deepPurpleAccent], "screen": const StockManagement()},
//                         ];

//                         return _buildDashboardBox(
//                           context,
//                           screens[index]["title"] as String,
//                           screens[index]["icon"] as IconData,
//                           screens[index]["color"] as List<Color>,
//                           screens[index]["screen"] as Widget,
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDashboardBox(BuildContext context, String title, IconData icon, List<Color> gradientColors, Widget screen) {
//     return GestureDetector(
//       onTap: () => navigateToScreen(context, screen),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 500),
//         curve: Curves.easeInOut,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: gradientColors,
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: gradientColors.last.withOpacity(0.5),
//               blurRadius: 10,
//               spreadRadius: 3,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Stack(
//           children: [
//             const BlurEffect(),
//             Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ScaleTransitionEffect(child: Icon(icon, size: 60, color: Colors.white)),
//                   const SizedBox(height: 18),
//                   Text(
//                     title,
//                     style: GoogleFonts.poppins(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class BlurEffect extends StatelessWidget {
//   const BlurEffect({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(20),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.05),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ScaleTransitionEffect extends StatefulWidget {
//   final Widget child;
//   const ScaleTransitionEffect({Key? key, required this.child}) : super(key: key);

//   @override
//   _ScaleTransitionEffectState createState() => _ScaleTransitionEffectState();
// }

// class _ScaleTransitionEffectState extends State<ScaleTransitionEffect>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 1),
//     )..repeat(reverse: true);
//     _animation = Tween<double>(begin: 1.0, end: 1.1).animate(_controller);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScaleTransition(
//       scale: _animation,
//       child: widget.child,
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }import 'package:flutter/material.dart';*/

/*import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart'; 
import 'feedback_checker.dart';
import 'food_waste_tracker.dart';
import 'release_menu.dart';
import 'stock_management.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Admin Dashboard",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.white,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              final screens = [
                {"title": "Feedback Checker", "icon": Icons.check, "color": [Colors.orange, Colors.redAccent], "screen": const FeedbackChecker()},
                {"title": "Food Waste Tracker", "icon": Icons.fastfood, "color": [Colors.green, Colors.teal], "screen": const FoodWasteTracker()},
                {"title": "Release Menu", "icon": Icons.restaurant_menu, "color": [Colors.blue, Colors.lightBlueAccent], "screen": const ReleaseMenu()},
                {"title": "Stock Management", "icon": Icons.inventory, "color": [Colors.purple, Colors.deepPurpleAccent], "screen": const StockManagement()},
              ];

              return _buildDashboardBox(
                context,
                screens[index]["title"] as String,
                screens[index]["icon"] as IconData,
                screens[index]["color"] as List<Color>,
                screens[index]["screen"] as Widget,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardBox(BuildContext context, String title, IconData icon, List<Color> gradientColors, Widget screen) {
    return GestureDetector(
      onTap: () => navigateToScreen(context, screen),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: gradientColors.last.withOpacity(0.5),
              blurRadius: 10,
              spreadRadius: 3,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 60, color: Colors.white),
              const SizedBox(height: 18),
              Text(
                title,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
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
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'package:url_launcher/url_launcher.dart'; // Add this to launch the URL

import 'feedback_checker.dart';
import 'food_waste_tracker.dart';
import 'release_menu.dart';
import 'stock_management.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<Offset>> _animations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _animations = List.generate(4, (index) {
      return Tween<Offset>(begin: Offset(index.isEven ? -1.5 : 1.5, 0), end: Offset.zero)
          .animate(CurvedAnimation(parent: _controller, curve: Curves.bounceOut));
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Admin Dashboard",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.white,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.33,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              child: Image.asset(
                'assets/Student.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return SlideTransition(
                    position: _animations[index],
                    child: _buildDashboardBox(
                      context,
                      ["Feedback Checker", "Food \n Waste Tracker", "Release Menu", "Stock \n Management"][index],
                      [Icons.check, Icons.fastfood, Icons.restaurant_menu, Icons.inventory][index],
                      [
                        [Colors.orange, Colors.redAccent],
                        [Colors.green, Colors.teal],
                        [Colors.blue, Colors.lightBlueAccent],
                        [Colors.purple, Colors.deepPurpleAccent]
                      ][index],
                      screen: [
                        const FeedbackChecker(),
                        const FoodWasteTracker(),
                        const ReleaseMenu(),
                        const StockManagement()
                      ][index],
                    ),
                  );
                },
              ),
            ),
          ),
          // Horizontal box below the 4 boxes
          GestureDetector(
            onTap: () async {
              // Open the URL in the browser
              final Uri url = Uri.parse('https://foodprediction-gyayqbglbcgwagfmqntutc.streamlit.app/');
              if (await canLaunch(url.toString())) {
                await launch(url.toString());
              } else {
                throw 'Could not launch $url';
              }
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              padding: const EdgeInsets.symmetric(vertical: 25),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.5),
                    blurRadius: 8,
                    spreadRadius: 3,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Prediction Model',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardBox(BuildContext context, String title, IconData icon, List<Color> gradientColors,
      {required Widget screen}) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screen),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: gradientColors.last.withOpacity(0.5),
              blurRadius: 10,
              spreadRadius: 3,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 60, color: Colors.white),
              const SizedBox(height: 18),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
