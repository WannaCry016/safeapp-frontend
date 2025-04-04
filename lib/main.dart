import 'package:flutter/material.dart';
import 'package:frontend/pages/dashboard_admin.dart';
import 'package:frontend/pages/dashboard_user.dart';
import 'package:frontend/pages/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(), // Dark mode theme
      home: const AdminDashboard(),
    );
  }
}
