import 'package:campuspulse/screens/event_details/widgets/about_event_card.dart';
import 'package:campuspulse/screens/event_details/widgets/agenda_card.dart';
import 'package:campuspulse/screens/event_details/widgets/event_details_navigation.dart';
import 'package:campuspulse/screens/event_details/widgets/performers_card.dart';
import 'package:campuspulse/screens/home/widgets/loading_screen.dart';
import 'package:campuspulse/utils/constants/pulse_text.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../screens/event_details/widgets/event_details_card.dart';
import '../../../../utils/utils.dart';

class CurrentEventDetailsScreen extends StatefulWidget {
  final dynamic eventId;
  const CurrentEventDetailsScreen({super.key, required this.eventId});

  @override
  State<CurrentEventDetailsScreen> createState() =>
      _CurrentEventDetailsScreen();
}

class _CurrentEventDetailsScreen extends State<CurrentEventDetailsScreen> {
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
  }

  Future<Map<String, dynamic>?> fetchEventDetails() async {
    return await supabase
        .from('event_details')
        .select('*')
        .eq('id', widget.eventId)
        .maybeSingle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchEventDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingScreen();
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final event = snapshot.data;
          if (event == null) {
            return const Center(child: Text("Event not found"));
          }

          final performers = event['performers'] as List<dynamic>;
          final agenda = event['agenda'] as List<dynamic>;

          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 20,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(height: 640),

                          Image.network(
                            event['img_url'],
                            height: 300,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),

                          Container(
                            height: 300,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  const Color(0xFF020617).withAlpha(500),
                                  const Color(0xFF0B1020).withAlpha(300),
                                  const Color(0xFF0F172A).withAlpha(150),
                                ],
                              ),
                            ),
                          ),

                          Positioned(
                            left: 0,
                            right: 0,
                            top: 200,
                            child: EventDetailsCard(
                              eventName: event['name'],
                              location: event['location'],
                              category: event['category'],
                              fullLocation: event['full_location'],
                              tagline: event['tagline'],
                              time: Utils.formatTime(event['time']),
                              date: Utils.formatDate(event['date']),
                            ),
                          ),
                        ],
                      ),

                      Padding(
                        padding: Utils.screenPadding(vertical: 0),
                        child: Row(
                          children: [
                            Text('About Event', style: PulseText.label),
                          ],
                        ),
                      ),

                      AboutEventCard(about: event['about']),

                      Padding(
                        padding: Utils.screenPadding(vertical: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Performers', style: PulseText.label),
                            Text(
                              'Swipe right',
                              style: PulseText.bodyLight.copyWith(fontSize: 10),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 150,
                        child: Padding(
                          padding: Utils.screenPadding(),
                          child: ListView.separated(
                            itemCount: performers.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final p = performers[index];
                              return PerformersCard(
                                name: p['name'],
                                role: p['role'],
                              );
                            },
                            separatorBuilder: (_, __) =>
                                Utils.spacePulse(width: 15),
                          ),
                        ),
                      ),

                      Padding(
                        padding: Utils.screenPadding(vertical: 0),
                        child: Row(
                          children: [Text('Agenda', style: PulseText.label)],
                        ),
                      ),

                      AgendaCard(agenda: agenda),

                      Utils.spacePulse(height: 25),
                    ],
                  ),
                ),
              ),

              SafeArea(child: EventDetailsNavigation(hideFavorite:true)),
            ],
          );
        },
      ),
    );
  }
}