import 'package:flutter/material.dart';

class AdminEvents extends StatelessWidget {
  const AdminEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Manage Events")),
      body: const Center(child: Text("Admin Events")),
    );
  }
}
