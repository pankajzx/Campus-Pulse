import 'package:campuspulse/common/widgets/glass_card.dart';
import 'package:campuspulse/common/widgets/pulse_appbar.dart';
import 'package:campuspulse/common/widgets/shadow_container.dart';
import 'package:campuspulse/screens/home/widgets/upcoming_event_card.dart';
import 'package:campuspulse/utils/constants/pulse_colors.dart';
import 'package:campuspulse/utils/constants/pulse_text.dart';
import 'package:campuspulse/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Text('Admin Dashboard');
  }
}
