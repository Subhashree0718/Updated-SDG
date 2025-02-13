import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui';

import 'menu_screen.dart';
import 'calorie_tracker.dart';
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
      body: Column(
        children: [
          // Student image occupying the top 1/3 of the screen
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.33,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              child: Image.asset(
                'assets/Student.jpg', // Replace with the actual student image asset
                fit: BoxFit.cover,
              ),
            ),
          ),

          // The four boxes below the image
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final screens = [
                    {
                      "title": "Menu",
                      "icon": Icons.restaurant_menu,
                      "color": [Colors.orange, Colors.redAccent],
                      "screen": const MenuScreen(),
                    },
                    {
                      "title": "Calorie Tracker",
                      "icon": Icons.fitness_center,
                      "color": [Colors.green, Colors.teal],
                      "screen": const CalorieTracker(),
                    },
                    {
                      "title": "Chat With \n AI Expert",
                      "icon": Icons.chat_bubble,
                      "color": [Colors.blue, Colors.lightBlueAccent],
                      "url": "https://chatbotsih-o2fapdft42pn9qyp4txxqu.streamlit.app/",
                    },
                    {
                      "title": "Feedback",
                      "icon": Icons.feedback,
                      "color": [Colors.purple, Colors.deepPurpleAccent],
                      "screen": const FeedbackScreen(),
                    },
                  ];

                  return GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 1,
                    ),
                    itemCount: screens.length,
                    itemBuilder: (context, index) {
                      return _buildDashboardBox(
                        context,
                        screens[index]["title"] as String,
                        screens[index]["icon"] as IconData,
                        screens[index]["color"] as List<Color>,
                        screen: screens[index]["screen"] as Widget?,
                        url: screens[index]["url"] as String?,
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardBox(BuildContext context, String title, IconData icon, List<Color> gradientColors,
      {Widget? screen, String? url}) {
    return GestureDetector(
      onTap: () async {
        if (url != null) {
          final Uri uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Could not open link!"), backgroundColor: Colors.red),
            );
          }
        } else if (screen != null) {
          navigateToScreen(context, screen);
        }
      },
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
                  ScaleTransitionEffect(child: Icon(icon, size: 60, color: Colors.white)),
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
