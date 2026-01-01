import 'package:flutter/material.dart';

class MyEventsScreen extends StatelessWidget {
  const MyEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E1328),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        title: const Text("My Events"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle, color: Colors.blueAccent, size: 28),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// SEARCH
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: Colors.white54),
                  hintText: "Search events...",
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// FILTERS
            Row(
              children: [
                filterChip("All", true),
                filterChip("Published 2", false),
                filterChip("Drafts 1", false),
              ],
            ),

            const SizedBox(height: 16),

            /// LIS
            Expanded(
              child: ListView(
                children: const [
                  EventCard(
                    title: "Campus Tech Hackathon",
                    time: "10:00 AM - 6:00 PM",
                    location: "Innovation Hub",
                    status: "Published",
                    date: "OCT\n24",
                    registered: "124 Registered",
                  ),
                  EventCard(
                    title: "Freshman Mixer Night",
                    subtitle: "Complete details to publish",
                    status: "Draft",
                    date: "DATE\nTBD",
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  static Widget filterChip(String text, bool selected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? Colors.blueAccent : Colors.white10,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

/// EVENT CARD
class EventCard extends StatelessWidget {
  final String title;
  final String date;
  final String status;
  final String? time;
  final String? location;
  final String? registered;
  final String? subtitle;

  const EventCard({
    super.key,
    required this.title,
    required this.date,
    required this.status,
    this.time,
    this.location,
    this.registered,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1F3C),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// IMAGE PLACEHOLDER
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  date,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                if (subtitle != null)
                  Text(subtitle!, style: const TextStyle(color: Colors.white54)),
                if (time != null)
                  Text("🕒 $time", style: const TextStyle(color: Colors.white54)),
                if (location != null)
                  Text("📍 $location", style: const TextStyle(color: Colors.white54)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    if (registered != null)
                      Text(registered!, style: const TextStyle(color: Colors.white54)),
                    const Spacer(),
                    actionIcon(Icons.remove_red_eye),
                    actionIcon(Icons.edit),
                    actionIcon(Icons.delete, color: Colors.red),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  static Widget actionIcon(IconData icon, {Color color = Colors.white}) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white10,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 18, color: color),
    );
  }
}
