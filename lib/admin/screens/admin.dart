import 'package:campuspulse/admin/screens/dashboard/admin_dashboard_screen.dart';
import 'package:campuspulse/admin/screens/scan_qr/scan_qr_screen.dart';
import 'package:campuspulse/admin/screens/users/users_screen.dart';
import 'package:flutter/material.dart';
import 'admin_bottom_navigation.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _Admin();
}

class _Admin extends State<Admin> {
  final PageController _controller = PageController(initialPage: 1);
  int currentIndex = 1;

  final pages = [
    ScanQrScreen(),
    AdminDashboardScreen(),
    UsersScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: pages,

        onPageChanged: (index) {
          setState(() => currentIndex = index);
        },
      ),

      bottomNavigationBar: AdminBottomNavigation(
        selectedIndex: currentIndex,

        onItemTap: (index) {
          setState(() => currentIndex = index);
          _controller.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }
}