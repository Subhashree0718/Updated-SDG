// import 'package:flutter/material.dart';

// class FeedbackChecker extends StatelessWidget {
//   const FeedbackChecker({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Feedback Checker")),
//       body: const Center(child: Text("Feedback Checker Page")),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class FeedbackChecker extends StatefulWidget {
//   const FeedbackChecker({Key? key}) : super(key: key);

//   @override
//   _FeedbackCheckerState createState() => _FeedbackCheckerState();
// }

// class _FeedbackCheckerState extends State<FeedbackChecker> {
//   List<Map<String, dynamic>> feedbackList = [
//     {"name": "John Doe", "feedback": "Great service!", "sentiment": "positive", "resolved": false, "date": "2025-02-12"},
//     {"name": "Alice Smith", "feedback": "Food quality needs improvement.", "sentiment": "negative", "resolved": false, "date": "2025-02-11"},
//     {"name": "Robert", "feedback": "Very fast response. Loved it!", "sentiment": "positive", "resolved": true, "date": "2025-02-10"},
//     {"name": "Sophia", "feedback": "The canteen is not clean.", "sentiment": "negative", "resolved": false, "date": "2025-02-09"},
//   ];

//   String selectedFilter = "All";
//   String searchQuery = "";

//   List<Map<String, dynamic>> getFilteredFeedback() {
//     return feedbackList.where((feedback) {
//       if (selectedFilter == "Unread" && feedback["resolved"] == true) return false;
//       if (selectedFilter == "Resolved" && feedback["resolved"] == false) return false;
//       return feedback["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
//           feedback["feedback"].toLowerCase().contains(searchQuery.toLowerCase());
//     }).toList();
//   }

//   void toggleResolved(int index) {
//     setState(() {
//       feedbackList[index]["resolved"] = !feedbackList[index]["resolved"];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<Map<String, dynamic>> displayedFeedback = getFilteredFeedback();

//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: Text("Feedback Checker",
//             style: GoogleFonts.poppins(
//               fontWeight: FontWeight.bold,
//               fontSize: 22,
//               color: Colors.white,
//             )),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             // Search Bar
//             TextField(
//               style: TextStyle(color: Colors.white),
//               decoration: InputDecoration(
//                 hintText: "Search feedback...",
//                 hintStyle: TextStyle(color: Colors.white54),
//                 prefixIcon: Icon(Icons.search, color: Colors.white54),
//                 filled: true,
//                 fillColor: Colors.grey[900],
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   searchQuery = value;
//                 });
//               },
//             ),
//             const SizedBox(height: 10),

//             // Filter Buttons (All, Unread, Resolved)
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: ["All", "Unread", "Resolved"].map((filter) {
//                 return ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: selectedFilter == filter ? Colors.blue : Colors.grey[800],
//                     foregroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       selectedFilter = filter;
//                     });
//                   },
//                   child: Text(filter, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
//                 );
//               }).toList(),
//             ),
//             const SizedBox(height: 10),

//             // Feedback List
//             Expanded(
//               child: displayedFeedback.isEmpty
//                   ? Center(child: Text("No feedback available", style: TextStyle(color: Colors.white54)))
//                   : ListView.builder(
//                       itemCount: displayedFeedback.length,
//                       itemBuilder: (context, index) {
//                         var feedback = displayedFeedback[index];
//                         return FeedbackCard(
//                           name: feedback["name"],
//                           feedback: feedback["feedback"],
//                           sentiment: feedback["sentiment"],
//                           resolved: feedback["resolved"],
//                           date: feedback["date"],
//                           onToggleResolved: () => toggleResolved(index),
//                         );
//                       },
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Feedback Card Widget
// class FeedbackCard extends StatelessWidget {
//   final String name, feedback, sentiment, date;
//   final bool resolved;
//   final VoidCallback onToggleResolved;

//   const FeedbackCard({
//     Key? key,
//     required this.name,
//     required this.feedback,
//     required this.sentiment,
//     required this.resolved,
//     required this.date,
//     required this.onToggleResolved,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     IconData sentimentIcon = sentiment == "positive" ? Icons.emoji_emotions : Icons.sentiment_dissatisfied;
//     Color sentimentColor = sentiment == "positive" ? Colors.green : Colors.red;

//     return Card(
//       color: Colors.grey[900],
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       elevation: 4,
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       child: ListTile(
//         leading: Icon(sentimentIcon, color: sentimentColor, size: 32),
//         title: Text(name, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(feedback, style: GoogleFonts.poppins(fontSize: 14, color: Colors.white70)),
//             Text("Date: $date", style: TextStyle(fontSize: 12, color: Colors.white54)),
//           ],
//         ),
//         trailing: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Switch(
//               value: resolved,
//               onChanged: (value) => onToggleResolved(),
//               activeColor: Colors.green,
//               inactiveThumbColor: Colors.red,
//             ),
//             Text(resolved ? "Resolved" : "Unread", style: TextStyle(color: resolved ? Colors.green : Colors.red)),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedbackChecker extends StatefulWidget {
  const FeedbackChecker({Key? key}) : super(key: key);

  @override
  _FeedbackCheckerState createState() => _FeedbackCheckerState();
}

class _FeedbackCheckerState extends State<FeedbackChecker> {
  List<Map<String, dynamic>> feedbackList = [
    {"name": "Akilesh", "feedback": " Eventhough I am a North Indian, The Food Here Give the Homely Feel", "sentiment": "positive", "resolved": false, "date": "2025-02-12"},
    {"name": "Vishnu", "feedback": "Food quality needs improvement.", "sentiment": "negative", "resolved": false, "date": "2025-02-11"},
    {"name": "Deepak", "feedback": "Loved The Taste", "sentiment": "positive", "resolved": false, "date": "2025-02-11"},
   
    {"name": "Priyanka", "feedback": "Very fast response. Loved it!", "sentiment": "positive", "resolved": true, "date": "2025-02-10"},
     {"name": "Subhashree", "feedback": "Great service!", "sentiment": "positive", "resolved": false, "date": "2025-02-11"},
    {"name": "Amirtha", "feedback": "The canteen is clean and Hygiene.", "sentiment": "positive", "resolved": false, "date": "2025-02-09"},
     {"name": "Shruthi", "feedback": "Better", "sentiment": "positive", "resolved": false, "date": "2025-02-09"},
  ];

  String selectedFilter = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> getFilteredFeedback() {
    return feedbackList.where((feedback) {
      if (selectedFilter == "Unread" && feedback["resolved"] == true) return false;
      if (selectedFilter == "Resolved" && feedback["resolved"] == false) return false;
      return feedback["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          feedback["feedback"].toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  void toggleResolved(int index) {
    setState(() {
      feedbackList[index]["resolved"] = !feedbackList[index]["resolved"];
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> displayedFeedback = getFilteredFeedback();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Feedback Checker",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Search Bar
            TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search feedback...",
                hintStyle: TextStyle(color: Colors.white54),
                prefixIcon: Icon(Icons.search, color: Colors.white54),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
            const SizedBox(height: 12),

            // Filter Buttons
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: ["All", "Unread", "Resolved"].map((filter) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedFilter == filter ? Colors.blue : Colors.grey[800],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        setState(() {
                          selectedFilter = filter;
                        });
                      },
                      child: Text(filter, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 12),

            // Feedback List
            Expanded(
              child: displayedFeedback.isEmpty
                  ? Center(child: Text("No feedback available", style: TextStyle(color: Colors.white54, fontSize: 16)))
                  : ListView.builder(
                      itemCount: displayedFeedback.length,
                      itemBuilder: (context, index) {
                        var feedback = displayedFeedback[index];
                        return FeedbackCard(
                          name: feedback["name"],
                          feedback: feedback["feedback"],
                          sentiment: feedback["sentiment"],
                          resolved: feedback["resolved"],
                          date: feedback["date"],
                          onToggleResolved: () => toggleResolved(index),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// Feedback Card Widget
class FeedbackCard extends StatelessWidget {
  final String name, feedback, sentiment, date;
  final bool resolved;
  final VoidCallback onToggleResolved;

  const FeedbackCard({
    Key? key,
    required this.name,
    required this.feedback,
    required this.sentiment,
    required this.resolved,
    required this.date,
    required this.onToggleResolved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData sentimentIcon = sentiment == "positive" ? Icons.emoji_emotions : Icons.sentiment_dissatisfied;
    Color sentimentColor = sentiment == "positive" ? Colors.green : Colors.red;

    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Sentiment Icon
            Icon(sentimentIcon, color: sentimentColor, size: 36),
            const SizedBox(width: 12),

            // Feedback Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 4),
                  Text(feedback, style: GoogleFonts.poppins(fontSize: 14, color: Colors.white70), maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Text("Date: $date", style: TextStyle(fontSize: 12, color: Colors.white54)),
                ],
              ),
            ),

            // Toggle Switch
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Switch(
                  value: resolved,
                  onChanged: (value) => onToggleResolved(),
                  activeColor: Colors.green,
                  inactiveThumbColor: Colors.red,
                ),
                Text(resolved ? "Resolved" : "Unread", style: TextStyle(color: Colors.white, fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
