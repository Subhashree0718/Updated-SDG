import 'package:flutter/material.dart';
import 'screens/student/student_dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Food App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const StudentDashboard(),
    );
  }
}
