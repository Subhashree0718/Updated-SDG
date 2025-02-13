import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

import 'menu_screen.dart';
import 'calorie_tracker.dart';
import 'chatbot_screen.dart';
import 'feedback_screen.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({Key? key}) : super(key: key);

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
        title: Text("Student Dashboard",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.white,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(  // ✅ Centering the entire layout
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,  // ✅ Pushing content to the middle
                children: [
                  Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,  
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: 1,  // ✅ Bigger box size
                      ),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        final screens = [
                          {"title": "Menu", "icon": Icons.restaurant_menu, "color": [Colors.orange, Colors.redAccent], "screen": const MenuScreen()},
                          {"title": "Calorie Tracker", "icon": Icons.fitness_center, "color": [Colors.green, Colors.teal], "screen": const CalorieTracker()},
                          {"title": "Chatbot", "icon": Icons.chat_bubble, "color": [Colors.blue, Colors.lightBlueAccent], "screen": const ChatbotScreen()},
                          {"title": "Feedback", "icon": Icons.feedback, "color": [Colors.purple, Colors.deepPurpleAccent], "screen": const FeedbackScreen()},
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
                ],
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
        child: Stack(
          children: [
            const BlurEffect(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScaleTransitionEffect(child: Icon(icon, size: 60, color: Colors.white)),  // ✅ Increased icon size
                  const SizedBox(height: 18),
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20,  // ✅ Increased font size
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlurEffect extends StatelessWidget {
  const BlurEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
          ),
        ),
      ),
    );
  }
}

class ScaleTransitionEffect extends StatefulWidget {
  final Widget child;
  const ScaleTransitionEffect({Key? key, required this.child}) : super(key: key);

  @override
  _ScaleTransitionEffectState createState() => _ScaleTransitionEffectState();
}

class _ScaleTransitionEffectState extends State<ScaleTransitionEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 1.0, end: 1.1).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
