import 'package:flutter/material.dart';
import 'glass.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fade = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(_fade);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E1328),

      /// FAB (smooth scale)
      floatingActionButton: ScaleTransition(
        scale: _fade,
        child: FloatingActionButton(
          backgroundColor: Colors.blueAccent.withOpacity(0.9),
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),

      /// iOS Glass Bottom Bar
      bottomNavigationBar: glass(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(26),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.white60,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.confirmation_number), label: "Tickets"),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Stats"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),

      body: SafeArea(
        child: FadeTransition(
          opacity: _fade,
          child: SlideTransition(
            position: _slide,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// HEADER
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 22,
                        backgroundImage:
                        NetworkImage("https://i.pravatar.cc/150?img=3"),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Welcome back",
                              style: TextStyle(color: Colors.white60)),
                          Text("Sarah J.",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const Spacer(),
                      glass(
                        shape: BoxShape.circle,
                        child: const Icon(Icons.notifications,
                            color: Colors.white),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  /// STATS
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.2,
                    children: const [
                      StatCard("Revenue", "\$1,240", "+12%"),
                      StatCard("Tickets", "342", "+5%"),
                      StatCard("Events", "3", "Active"),
                      StatCard("Views", "12k", "+22%"),
                    ],
                  ),

                  const SizedBox(height: 24),

                  /// UPCOMING EVENTS
                  const Text(
                    "Upcoming Events",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 12),

                  eventCard(
                    title: "Campus Jazz Night",
                    location: "Student Union Hall",
                    progress: 0.85,
                    sold: "215/250",
                  ),
                  eventCard(
                    title: "Tech Hackathon 2024",
                    location: "Engineering Block B",
                    progress: 0.12,
                    sold: "36/300",
                  ),
                  eventCard(
                    title: "Art & Wine Workshop",
                    location: "Draft",
                    progress: 0,
                    sold: "Setup Required",
                    isDraft: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// EVENT CARD
Widget eventCard({
  required String title,
  required String location,
  required double progress,
  required String sold,
  bool isDraft = false,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: glass(
      borderRadius: BorderRadius.circular(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(location,
              style: const TextStyle(color: Colors.white60)),
          const SizedBox(height: 10),
          if (!isDraft)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6,
                backgroundColor: Colors.white12,
                color: Colors.blueAccent,
              ),
            ),
          const SizedBox(height: 8),
          Text(sold,
              style: const TextStyle(color: Colors.white60)),
        ],
      ),
    ),
  );
}

/// STAT CARD
class StatCard extends StatelessWidget {
  final String title, value, percent;
  const StatCard(this.title, this.value, this.percent, {super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.9, end: 1.0),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      builder: (_, scale, child) =>
          Transform.scale(scale: scale, child: child),
      child: glass(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.white60)),
            const Spacer(),
            Text(value,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(percent,
                style: const TextStyle(color: Colors.greenAccent)),
          ],
        ),
      ),
    );
  }
}
