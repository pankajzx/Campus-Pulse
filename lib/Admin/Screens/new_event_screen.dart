import 'package:flutter/material.dart';

class NewEventScreen extends StatelessWidget {
  const NewEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E1328),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E1328),
        elevation: 0,
        leading: TextButton(
          onPressed: () {},
          child: const Text("Cancel", style: TextStyle(color: Colors.white70)),
        ),
        title: const Text("New Event"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text("Preview",
                style: TextStyle(color: Colors.blueAccent)),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// COVER IMAGE
            Container(
              height: 180,
              decoration: BoxDecoration(
                color: const Color(0xFF1A1F3C),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white24, style: BorderStyle.solid),
              ),
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: Icon(Icons.camera_alt, color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    Text("Add Cover Image",
                        style: TextStyle(color: Colors.white54)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            /// TITLE
            const Text("Event Title",
                style: TextStyle(color: Colors.white54)),
            const SizedBox(height: 8),
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: inputDecoration(""),
            ),

            const SizedBox(height: 16),

            /// DESCRIPTION
            TextField(
              maxLines: 3,
              style: const TextStyle(color: Colors.white),
              decoration: inputDecoration("Add a description..."),
            ),

            const SizedBox(height: 20),

            /// DATE TIME
            dateTile("Starts", "Nov 24, 2024", "7:00 PM"),
            const SizedBox(height: 10),
            dateTile("Ends", "Nov 24, 2024", "11:00 PM"),

            const SizedBox(height: 10),

            /// LOCATION
            listTile("Add Location", Icons.location_on),

            const SizedBox(height: 24),

            /// TICKET
            const Text("Ticket Types",
                style: TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(child: smallField("Ticket name")),
                const SizedBox(width: 10),
                Expanded(child: smallField("Price")),
              ],
            ),

            const SizedBox(height: 10),

            listTile("Quantity Limit", Icons.confirmation_number,
                trailing: const Text("Unlimited",
                    style: TextStyle(color: Colors.white54))),

            const SizedBox(height: 12),

            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text("Add Ticket Type",
                  style: TextStyle(color: Colors.white)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// SWITCHES
            switchTile("Public Event", "Visible to everyone on campus", true),
            switchTile("Waitlist", "Allow users to join waitlist", false),

            const SizedBox(height: 80),
          ],
        ),
      ),

      /// CREATE BUTTON
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          child: const Text("Create Event →",
              style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }

  // ---------- WIDGETS ----------

  static InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white38),
      filled: true,
      fillColor: const Color(0xFF1A1F3C),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }

  static Widget dateTile(String title, String date, String time) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1F3C),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.calendar_today, color: Colors.white54),
          const SizedBox(width: 10),
          Text(title, style: const TextStyle(color: Colors.white)),
          const Spacer(),
          chip(date),
          const SizedBox(width: 6),
          chip(time),
        ],
      ),
    );
  }

  static Widget chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }

  static Widget listTile(String text, IconData icon,
      {Widget? trailing}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1F3C),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white54),
          const SizedBox(width: 10),
          Text(text, style: const TextStyle(color: Colors.white)),
          const Spacer(),
          trailing ?? const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white54),
        ],
      ),
    );
  }

  static Widget smallField(String hint) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: inputDecoration(hint),
    );
  }

  static Widget switchTile(String title, String subtitle, bool value) {
    return SwitchListTile(
      value: value,
      onChanged: (_) {},
      activeColor: Colors.blueAccent,
      title: Text(title, style: const TextStyle(color: Colors.white)),
      subtitle:
      Text(subtitle, style: const TextStyle(color: Colors.white54)),
    );
  }
}
