import 'package:campuspulse/common/widgets/pulse_appbar.dart';
import 'package:campuspulse/screens/event_details/event_details_screen.dart';
import 'package:campuspulse/screens/home/widgets/featured_card.dart';
import 'package:campuspulse/screens/home/widgets/loading_screen.dart';
import 'package:campuspulse/screens/home/widgets/upcoming_event_card.dart';
import 'package:campuspulse/utils/constants/pulse_colors.dart';
import 'package:campuspulse/utils/utils.dart';
import 'package:flutter/material.dart';
import '../../services/event_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PulseAppBar(title: "Campus Events"),

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
            itemCount: events.length,
            separatorBuilder: (_, _) => Utils.spacePulse(),
            itemBuilder: (context, index) {
              final e = events[index];

              if (index == 0) {
                return Padding(
                  padding: Utils.screenPadding(),
                  child: FeaturedCard(
                    eventId : e['id'],
                    eventName: e['name'],
                    date: Utils.formatDate(e['date']),
                    location: e['location'],
                    imgUrl: e['img_url'],
                  ),
                );
              }

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EventDetailsScreen(
                         eventId: e['id']
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: Utils.screenPadding(),
                  child: UpcomingEventCard(
                    title: e['name'],
                    location: e['location'],
                    category: e['category'],
                    color: PulseColors.blue,
                    date: DateTime.parse(e['date']),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

}
