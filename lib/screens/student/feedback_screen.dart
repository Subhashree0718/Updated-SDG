import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController feedbackController = TextEditingController();
  int rating = 0; // Rating from 1 to 5

  void submitFeedback() {
    if (nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        feedbackController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Feedback Submitted! Thank you ❤️"),
          backgroundColor: Colors.green,
        ),
      );
      // Reset fields after submission
      nameController.clear();
      emailController.clear();
      feedbackController.clear();
      setState(() {
        rating = 0;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all fields!"),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark theme
      appBar: AppBar(
        title: const Text("Feedback", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "We value your feedback! 😊",
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Name Input
            TextField(
              controller: nameController,
              style: const TextStyle(color: Colors.white),
              decoration: _buildInputDecoration("Your Name"),
            ),
            const SizedBox(height: 10),

            // Email Input
            TextField(
              controller: emailController,
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.emailAddress,
              decoration: _buildInputDecoration("Your Email"),
            ),
            const SizedBox(height: 10),

            // Feedback Input
            TextField(
              controller: feedbackController,
              maxLines: 4,
              style: const TextStyle(color: Colors.white),
              decoration: _buildInputDecoration("Write your feedback..."),
            ),
            const SizedBox(height: 15),

            // Star Rating System
            const Text("Rate your experience:", style: TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(height: 5),
            Row(
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    Icons.star,
                    size: 30,
                    color: index < rating ? Colors.amber : Colors.grey[700],
                  ),
                  onPressed: () {
                    setState(() {
                      rating = index + 1;
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 20),

            // Submit Button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: submitFeedback,
                child: const Text(
                  "Submit Feedback",
                  style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Input Field Styling
  InputDecoration _buildInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      filled: true,
      fillColor: Colors.grey[900],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
