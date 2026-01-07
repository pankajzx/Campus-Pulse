import 'package:campuspulse/common/widgets/gradient_background.dart';
import 'package:campuspulse/common/widgets/shadow_container.dart';
import 'package:campuspulse/screens/event_details/widgets/about_event_card.dart';
import 'package:campuspulse/screens/event_details/widgets/agenda_card.dart';
import 'package:campuspulse/screens/event_details/widgets/event_button.dart';
import 'package:campuspulse/screens/event_details/widgets/event_details_navigation.dart';
import 'package:campuspulse/screens/event_details/widgets/performers_card.dart';
import 'package:campuspulse/screens/home/widgets/loading_screen.dart';
import 'package:campuspulse/utils/constants/pulse_colors.dart';
import 'package:campuspulse/utils/constants/pulse_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../common/widgets/pulse_tag.dart';
import '../../utils/utils.dart';
import '../my_ticket/widgets/tickets.dart';
import 'widgets/event_details_card.dart';

class EventDetailsScreen extends StatefulWidget {
  final dynamic eventId;
  const EventDetailsScreen({super.key, required this.eventId});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  final supabase = Supabase.instance.client;

  bool getTicket = false;
  String userName = '';

  @override
  void initState() {
    super.initState();
    checkTicketStatus();
  }

  Future<Map<String, dynamic>?> fetchEventDetails() async {
    return await supabase
        .from('event_details')
        .select('*')
        .eq('id', widget.eventId)
        .maybeSingle();
  }

  Future<void> checkTicketStatus() async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return;

    final data = await supabase
        .from('user_details')
        .select('confirmed_tickets,name')
        .eq('id', userId)
        .single();

    final tickets = data['confirmed_tickets'] ?? [];
    final name = data['name'];

    setState(() {
      getTicket = tickets.any((t) => t['event_id'] == widget.eventId);
      userName = name;
    });

  }

  Future<void> getMyTicket(String eventId, Map event) async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return;

    try {
      final userData = await supabase
          .from('user_details')
          .select('confirmed_tickets')
          .eq('id', userId)
          .single();

      List<dynamic> confirmed = userData['confirmed_tickets'] ?? [];

      final already =
      confirmed.any((ticket) => ticket['event_id'] == eventId);

      if (!already) {
        confirmed.add({
          'event_id': eventId,
          'timestamp': DateTime.now().toIso8601String(),
        });

        await supabase
            .from('user_details')
            .update({'confirmed_tickets': confirmed})
            .eq('id', userId);

        setState(() => getTicket = true);

        showTicketStatusModal(event);
      }
    } catch (e) {
      print('Error booking ticket: $e');
    }
  }

  Future<void> cancelMyTicket(String eventId, Map event) async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return;

    try {
      final userData = await supabase
          .from('user_details')
          .select('confirmed_tickets, cancelled_tickets')
          .eq('id', userId)
          .single();

      List<dynamic> confirmed = userData['confirmed_tickets'] ?? [];
      List<dynamic> cancelled = userData['cancelled_tickets'] ?? [];

      confirmed =
          confirmed.where((t) => t['event_id'] != eventId).toList();

      cancelled.add({
        'event_id': eventId,
        'timestamp': DateTime.now().toIso8601String(),
      });

      await supabase
          .from('user_details')
          .update({
        'confirmed_tickets': confirmed,
        'cancelled_tickets': cancelled,
      })
          .eq('id', userId);

      setState(() => getTicket = false);

      showTicketStatusModal(event);
    } catch (e) {
      print('Error canceling ticket: $e');
    }
  }

  void showTicketStatusModal(Map event) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      backgroundColor: Colors.white,
      builder: (_) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 2.3,
          child: GradientBackground(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 20,
              children: [
                Column(
                  spacing: 10,
                  children: [
                    Utils.spacePulse(height: 10),

                    Tickets(
                      eventName: event['name'],
                      date: Utils.formatDate(event['date']),
                      time: Utils.formatTime(event['time']),
                      location: event['location'],
                      confirm: getTicket,
                    ),

                    Row(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PulseTag(color: Colors.white, text:userName),
                      ],
                    ),
                  ],
                ),

                SizedBox(
                  width: 400,
                  child: ShadowContainer(
                    color: getTicket ? PulseColors.green : Colors.red,
                    child: EventButton(
                      text: getTicket ? 'Ticket Created' : 'Ticket Cancelled',
                      icon: getTicket
                          ? FontAwesomeIcons.circleCheck
                          : FontAwesomeIcons.xmark,
                      txtColor:
                      getTicket ? PulseColors.green : PulseColors.red,
                      iconColor:
                      getTicket ? PulseColors.green : PulseColors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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
                padding:
                EdgeInsets.only(top: MediaQuery.of(context).padding.top),
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
                              style: PulseText.bodyLight.copyWith(
                                fontSize: 10,
                              ),
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
                          children: [
                            Text('Agenda', style: PulseText.label),
                          ],
                        ),
                      ),

                      AgendaCard(agenda: agenda),

                      Utils.spacePulse(height: 75),
                    ],
                  ),
                ),
              ),

              SafeArea(child: EventDetailsNavigation()),

              Positioned(
                bottom: 30,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () async {
                    if (getTicket) {
                      await cancelMyTicket(widget.eventId, event);
                    } else {
                      await getMyTicket(widget.eventId, event);
                    }
                  },
                  child: EventButton(
                    text: getTicket ? 'Cancel Ticket' : 'Get My Ticket',
                    txtColor:
                    getTicket ? PulseColors.red : PulseColors.primary,
                    icon: getTicket
                        ? FontAwesomeIcons.xmark
                        : FontAwesomeIcons.ticketSimple,
                    iconColor:
                    getTicket ? PulseColors.red : PulseColors.orange,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
