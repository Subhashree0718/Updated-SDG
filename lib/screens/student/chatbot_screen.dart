/*
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hostel Mess Chatbot',
      theme: ThemeData.light(),
      home: ChatBotScreen(),
    );
  }
}

class ChatBotScreen extends StatefulWidget {
  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, String>> _messages = [];
  final String apiKey = "AIzaSyCSSffiqGSSI-IHhd4MMHvzWtiYpOl8MV0"; // Replace with your actual API key

  final List<String> predefinedQuestions = [
    "What's today's breakfast menu?",
    "What's for lunch today?",
    "What are the dinner options?",
  ];

  Future<void> _sendMessage(String message) async {
    setState(() {
      _messages.add({"sender": "user", "text": message});
      _messageController.clear();
    });
    
    String botResponse = await _getBotResponse(message);
    
    setState(() {
      _messages.add({"sender": "bot", "text": botResponse});
    });
    
    _scrollToBottom();
  }

  Future<String> _getBotResponse(String message) async {
    try {
      final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
      final content = await model.generateContent([Content.text(message)]);

      return content.text ?? "I'm here to help with your mess food queries!";
    } catch (e) {
      return "Sorry, I couldn't fetch the information right now.";
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message["sender"] == "user";
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isUser ? [Colors.teal, Colors.cyan] : [Colors.white, Colors.purple.shade100],
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: isUser ? Radius.circular(15) : Radius.zero,
                        bottomRight: isUser ? Radius.zero : Radius.circular(15),
                      ),
                    ),
                    child: Text(
                      message["text"]!,
                      style: TextStyle(fontSize: 16, color: isUser ? Colors.white : Colors.black87),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                spacing: 10,
                children: predefinedQuestions.map((question) {
                return ElevatedButton(
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade200,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
                onPressed: () => _sendMessage(question),
                child: Text(
                question,
                style: TextStyle(color: Colors.black), // Change predefined question text color to black
            ),
          );
         }).toList(),
        ),
      ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.mic, color: Colors.teal),
                  onPressed: () {
                    _sendMessage("Voice input detected...");
                  },
                ),
                SizedBox(width: 5),
                Expanded(
                  child: TextField(
  controller: _messageController,
  style: TextStyle(color: Colors.black), // Ensure input text is black
  decoration: InputDecoration(
    hintText: "Ask about today's meals...",
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
    filled: true,
    fillColor: Colors.grey.shade200,
  ),
),
                ),
                SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    if (_messageController.text.trim().isNotEmpty) {
                      _sendMessage(_messageController.text.trim());
                    }
                  },
                  backgroundColor: Colors.teal,
                  child: Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hostel Mess Chatbot',
      theme: ThemeData.light(),
      home: ChatBotScreen(),
    );
  }
}

class ChatBotScreen extends StatefulWidget {
  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, String>> _messages = [];
  final String apiKey = "YOUR_GEMINI_API_KEY";
  
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = "";

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _initSpeech();
  }

  void _initSpeech() async {
    bool available = await _speech.initialize(
      onStatus: (status) => print("Speech Status: $status"),
      onError: (error) => print("Speech Error: $error"),
    );
    if (!available) {
      print("Speech recognition not available");
    }
  }

  Future<void> _sendMessage(String message) async {
    setState(() {
      _messages.add({"sender": "user", "text": message});
      _messageController.clear();
    });

    String botResponse = await _getBotResponse(message);

    setState(() {
      _messages.add({"sender": "bot", "text": botResponse});
    });

    _scrollToBottom();
  }

  Future<String> _getBotResponse(String message) async {
    try {
      final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
      final content = await model.generateContent([Content.text(message)]);
      return content.text ?? "I'm here to help with your mess food queries!";
    } catch (e) {
      return "Sorry, I couldn't fetch the information right now.";
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (result) {
            setState(() {
              _text = result.recognizedWords;
              _messageController.text = _text;
            });
          },
          listenFor: Duration(seconds: 5),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
      if (_text.isNotEmpty) {
        _sendMessage(_text);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hostel Mess Chatbot", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal.shade700, Colors.teal.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message["sender"] == "user";
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.teal.shade500 : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      message["text"]!,
                      style: TextStyle(
                        fontSize: 16,
                        color: isUser ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(_isListening ? Icons.mic : Icons.mic_none, color: Colors.teal),
                  onPressed: _listen,
                ),
                SizedBox(width: 5),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Ask about today's meals...",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    if (_messageController.text.trim().isNotEmpty) {
                      _sendMessage(_messageController.text.trim());
                    }
                  },
                  child: Icon(Icons.send, color: Colors.white),
                  backgroundColor: Colors.teal,
                  elevation: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
