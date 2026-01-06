import 'package:campuspulse/admin/screens/dashboard/screens/current_event_details_screen.dart';
import 'package:campuspulse/admin/screens/dashboard/widgets/admin_quick_action.dart';
import 'package:campuspulse/admin/screens/dashboard/widgets/current_events.dart';
import 'package:campuspulse/common/widgets/glass_card.dart';
import 'package:campuspulse/common/widgets/pulse_appbar.dart';
import 'package:campuspulse/common/widgets/shadow_container.dart';
import 'package:campuspulse/screens/home/widgets/loading_screen.dart';
import 'package:campuspulse/services/event_service.dart';
import 'package:campuspulse/utils/constants/pulse_colors.dart';
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
    return Scaffold(
      appBar: PulseAppBar(title: 'Dashboard'),
      body: FutureBuilder(
        future: EventService.instance.getEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingScreen();
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final events = snapshot.data ?? [];

          if (events.isEmpty) {
            return const Center(child: Text("No events yet"));
          }

          return ListView.separated(
            itemBuilder: (context, index) {
              final e = events[index];

              if (index == 0) {
                return Padding(
                  padding: Utils.screenPadding(),
                  child: AdminQuickAction(eventCount: events.length),
                );
              }

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CurrentEventDetailsScreen(eventId: e['id']),
                    ),
                  );
                },
                child: Padding(
                  padding: Utils.screenPadding(),
                  child: CurrentEvents(
                    title: e['name'],
                    location: e['location'],
                    color: PulseColors.blue,
                    date: DateTime.parse(e['date']),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Utils.spacePulse();
            },
            itemCount: events.length,
          );
        },
      ),
      floatingActionButton: GlassCard(
        child: ShadowContainer(
          color: PulseColors.green,
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: PulseColors.green.withAlpha(25),
            child: FaIcon(FontAwesomeIcons.plus, color: PulseColors.green),
          ),
        ),
      ),
    );
  }
}