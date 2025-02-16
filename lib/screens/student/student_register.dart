import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'studentLogin.dart';

class StudentRegister extends StatefulWidget {
  const StudentRegister({Key? key}) : super(key: key);

  @override
  _StudentRegisterState createState() => _StudentRegisterState();
}

class _StudentRegisterState extends State<StudentRegister> with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  double _opacity = 0.0;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _opacity = 1.0;
      });
      _animationController.forward();
    });
  }

  Future<void> _register() async {
    setState(() => _isLoading = true);

    // Validate Input Fields
    if (_nameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty ||
        _confirmPasswordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required")),
      );
      setState(() => _isLoading = false);
      return;
    }

    if (_passwordController.text.trim() != _confirmPasswordController.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      setState(() => _isLoading = false);
      return;
    }

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      await _firestore.collection("students").doc(userCredential.user!.uid).set({
        "name": _nameController.text.trim(),
        "email": _emailController.text.trim(),
        "uid": userCredential.user!.uid,
      });

      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: const Text("Success"),
              content: const Text("User registered successfully!"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const StudentLogin()),
                    );
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      debugPrint("Firebase Auth Error: ${e.message}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration Failed: ${e.message}")),
      );
    } catch (e) {
      debugPrint("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $e")),
      );
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Student Registration"),
        backgroundColor: Colors.blueAccent,
      ),
      body: AnimatedOpacity(
        opacity: _opacity,
        duration: const Duration(seconds: 1),
        child: Center(
          child: ScaleTransition(
            scale: _animation,
            child: Card(
              elevation: 10,
              color: Colors.grey[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTextField("Full Name", Icons.person, _nameController),
                    const SizedBox(height: 15),
                    _buildTextField("Email", Icons.email, _emailController),
                    const SizedBox(height: 15),
                    _buildTextField("Password", Icons.lock, _passwordController, obscureText: _obscurePassword, toggleObscure: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    }),
                    const SizedBox(height: 15),
                    _buildTextField("Confirm Password", Icons.lock, _confirmPasswordController, obscureText: _obscureConfirmPassword, toggleObscure: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    }),
                    const SizedBox(height: 20),
                    _isLoading
                        ? const CircularProgressIndicator(color: Colors.blueAccent)
                        : InkWell(
                            onTap: _register,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blueAccent.withOpacity(0.5),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: const Text(
                                "Register",
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, IconData icon, TextEditingController controller, {bool obscureText = false, VoidCallback? toggleObscure}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[500]),
        suffixIcon: toggleObscure != null ? IconButton(icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility, color: Colors.blueAccent), onPressed: toggleObscure) : null,
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