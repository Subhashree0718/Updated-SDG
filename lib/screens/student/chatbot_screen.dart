import 'package:flutter/material.dart';
import 'dart:async'; // For typing delay

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({Key? key}) : super(key: key);

  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isTyping = false; // Typing indicator

  void _sendMessage() {
    String message = _messageController.text.trim();
    if (message.isNotEmpty) {
      setState(() {
        _messages.add({"sender": "user", "text": message});
        _isTyping = true;
      });

      _messageController.clear();

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _messages.add({"sender": "bot", "text": _generateBotReply(message)});
          _isTyping = false;
        });
      });
    }
  }

  String _generateBotReply(String userMessage) {
    userMessage = userMessage.toLowerCase();

    if (userMessage.contains("menu")) {
      return "Here’s our menu: 🍕 Pizza, 🍔 Burger, 🍟 Fries, 🍝 Pasta, 🥗 Salad, 🍩 Desserts!";
    } else if (userMessage.contains("order")) {
      return "You can place an order by selecting items from the menu! 😊 Need help?";
    } else if (userMessage.contains("offer") || userMessage.contains("discount")) {
      return "🎉 We have an exclusive offer today! Buy 1 Get 1 Free on all Burgers! 🍔🔥";
    } else if (userMessage.contains("support") || userMessage.contains("help")) {
      return "For any assistance, please contact our support team at 📞 1800-FOOD-HELP!";
    } else if (userMessage.contains("status")) {
      return "📦 Your order is being prepared and will be delivered soon! 🍕🚀";
    } else if (userMessage.contains("thank") || userMessage.contains("thanks")) {
      return "You're welcome! 😊 Enjoy your meal! 🍽️";
    } else {
      return "I'm here to assist you! Ask me anything about our food. 🍽️";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark theme
      appBar: AppBar(
        title: const Text("Chatbot", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (_isTyping && index == _messages.length) {
                  return _typingIndicator();
                }

                final message = _messages[index];
                bool isUser = message["sender"] == "user";
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: isUser
                          ? const LinearGradient(
                              colors: [Colors.greenAccent, Colors.teal],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            )
                          : const LinearGradient(
                              colors: [Colors.grey, Colors.black54],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      message["text"]!,
                      style: TextStyle(
                        color: isUser ? Colors.black : Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Chat Input Box
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey[900],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  backgroundColor: Colors.greenAccent,
                  onPressed: _sendMessage,
                  child: const Icon(Icons.send, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _typingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Bot is typing",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            const SizedBox(width: 5),
            const SizedBox(
              width: 10,
              height: 10,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
