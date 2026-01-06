import 'package:campuspulse/common/widgets/glass_card.dart';
import 'package:campuspulse/common/widgets/top_navigation_bar.dart';
import 'package:campuspulse/utils/constants/pulse_text.dart';
import 'package:campuspulse/utils/utils.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavigationBar(title: 'Privacy Policy'),
      body: Padding(
        padding: Utils.screenPadding(),
        child: SingleChildScrollView(
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 14,
              children: [
                Text('About Policy', style: PulseText.label),
                GlassCard(
                  child: Text(
                    'Campus Pulse is a campus event management app that lets students browse events, register, and use digital tickets. This policy explains how we handle your information.',
                  ),
                ),
                Text('Information We Collect', style: PulseText.label),
                GlassCard(
                  child: RichText(
                    text: TextSpan(
                      text:
                          'We collect basic information needed to run the app, such as:\n',
                      style: PulseText.body,
                      children: [
                        TextSpan(
                          text: '  •   Name, email, and student details\n',
                        ),
                        TextSpan(
                          text: '  •   Events you join, save, or view\n',
                        ),
                        TextSpan(text: '  •   Ticket records\n'),
                        TextSpan(text: '  •   Basic device and crash data\n'),
                        TextSpan(
                          text:
                              'We do not collect financial, biometric, or unnecessary sensitive data.',
                          style: PulseText.title,
                        ),
                      ],
                    ),
                  ),
                ),
                Text('How We Use Your Information', style: PulseText.label),
                GlassCard(
                  child: Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'We use your data to:\n',
                          style: PulseText.body,
                          children: [
                            TextSpan(text: '  •   Create your accounts\n'),
                            TextSpan(
                              text:
                                  '  •   Manage event registrations and tickets\n',
                            ),
                            TextSpan(
                              text: '  •   Show your tickets in My Tickets\n',
                            ),
                            TextSpan(
                              text:
                                  '  •   Improve app performance and prevent misuse\n',
                            ),
                            TextSpan(
                              text: 'We do not sell or rent your data.',
                              style: PulseText.title,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Text('Security & Retention', style: PulseText.label),
                GlassCard(
                  child: Text(
                    'We protect your data with reasonable safeguards and keep it only as long as needed for event management.',
                  ),
                ),
                Text('Permissions', style: PulseText.label),
                GlassCard(
                  child: Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'The app may use:\n',
                          style: PulseText.body,
                          children: [
                            TextSpan(text: '  •   Internet\n'),
                            TextSpan(text: '  •   Notifications'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Text('Changes', style: PulseText.label),
                GlassCard(
                  child: Text(
                    'We may update this policy when features change. Updates will be shown in the app.',
                  ),
                ),
                Utils.spacePulse()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
