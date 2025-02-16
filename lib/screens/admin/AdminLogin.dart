import 'package:flutter/material.dart';
import 'admin_dashboard.dart';
class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _isVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Admin Login"),
        backgroundColor: Colors.purpleAccent,
        elevation: 0,
      ),
      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(seconds: 1),
          opacity: _isVisible ? 1 : 0,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Hero(
                  tag: "Admin",
                  child: Icon(Icons.admin_panel_settings, size: 80, color: Colors.purpleAccent),
                ),
                const SizedBox(height: 20),
                _buildTextField("Admin Username", Icons.person),
                const SizedBox(height: 15),
                _buildTextField("Password", Icons.lock, obscureText: true),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purpleAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                   onPressed: () {
                    // Navigate to Student Dashboard
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const AdminDashboard()),
                    );
                  },
                  child: const Text("Login", style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, IconData icon, {bool obscureText = false}) {
    return TextField(
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.purpleAccent),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[500]),
        filled: true,
        fillColor: Colors.grey[850],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
