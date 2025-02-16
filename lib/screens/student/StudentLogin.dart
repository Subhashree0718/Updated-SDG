import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'student_dashboard.dart';
import 'student_register.dart';

class StudentLogin extends StatefulWidget {
  const StudentLogin({Key? key}) : super(key: key);

  @override
  _StudentLoginState createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  double _formOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _formOpacity = 1.0;
      });
    });
  }

  Future<void> _login() async {
    setState(() { _isLoading = true; });
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      DocumentSnapshot userDoc = await _firestore
          .collection("students")
          .doc(userCredential.user!.uid)
          .get();

      if (userDoc.exists) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const StudentDashboard()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("You are new here! Please register first.")),
        );
        _auth.signOut();
      }
    } on FirebaseAuthException catch (e) {
      String message = "Login Failed: ${e.message}";
      if (e.code == 'user-not-found' || e.code == 'invalid-credential') {
        message = "You are new here! Please register first.";
      } else if (e.code == 'wrong-password') {
        message = "Incorrect password. Please try again.";
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }
    setState(() { _isLoading = false; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Student Login"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(seconds: 1),
          opacity: _formOpacity,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _animatedBox(),
                const SizedBox(height: 20),
                _buildTextField("Email", Icons.email, _emailController),
                const SizedBox(height: 15),
                _buildPasswordField(),
                const SizedBox(height: 20),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.blueAccent)
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          ),
                          onPressed: _login,
                          child: const Text("Login", style: TextStyle(fontSize: 18, color: Colors.white)),
                        ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const StudentRegister()),
                    );
                  },
                  child: const Text(
                    "New user? Register Now",
                    style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _animatedBox() {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(seconds: 1),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person, size: 40, color: Colors.white),
          ),
        );
      },
    );
  }

  Widget _buildTextField(String hint, IconData icon, TextEditingController controller, {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.blueAccent),
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

  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      obscureText: !_isPasswordVisible,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock, color: Colors.blueAccent),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.blueAccent,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
        hintText: "Password",
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