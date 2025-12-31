import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E1328),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Admin Dashboard"),
      ),
      body: const Center(
        child: Text(
          "user Dashboard Screen",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
