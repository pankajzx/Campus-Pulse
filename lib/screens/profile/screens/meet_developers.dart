import 'package:campuspulse/common/widgets/glass_card.dart';
import 'package:campuspulse/common/widgets/gradient_background.dart';
import 'package:campuspulse/common/widgets/shadow_container.dart';
import 'package:campuspulse/utils/constants/pulse_text.dart';
import 'package:campuspulse/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../common/widgets/top_navigation_bar.dart';
import '../../../utils/constants/pulse_colors.dart';

class MeetDevelopers extends StatefulWidget {
  const MeetDevelopers({super.key});

  @override
  State<MeetDevelopers> createState() => _MeetDevelopersState();
}

class _MeetDevelopersState extends State<MeetDevelopers> {
  final githubLink = Uri.parse('https://github.com/pankajzx');

  void visitAccounts() async {
    if (!await launchUrl(githubLink)) {
      throw Exception('Could not launch $githubLink');
    }
  }

  double top1 = 150;
  double left1 = 70;

  double top2 = 350;
  double left2 = 200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavigationBar(title: 'Contact Developers'),
      body: Stack(
        children: [
          Positioned(
            bottom: 50,
            left: MediaQuery.of(context).size.width / 2.5 - 10,
            child: Text(
              'HOLD AND DRAG',
              textAlign: TextAlign.center,
              style: PulseText.body.copyWith(color: PulseColors.red),
            ),
          ),
          Positioned(
            top: top1,
            left: left1,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  left1 += details.delta.dx;
                  top1 += details.delta.dy;
                });
              },

              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (_) {
                    return FractionallySizedBox(
                      heightFactor: 0.4,
                      child: GradientBackground(
                        child: Column(
                          spacing: 20,
                          children: [
                            Utils.spacePulse(),
                            GestureDetector(
                              onTap: () async {
                                final appUrl = Uri.parse(
                                  "instagram://user?username=pankuub",
                                );
                                final webUrl = Uri.parse(
                                  "https://instagram.com/pankuub",
                                );
                                if (await canLaunchUrl(appUrl)) {
                                  await launchUrl(
                                    appUrl,
                                    mode: LaunchMode.externalApplication,
                                  );
                                } else {
                                  await launchUrl(
                                    webUrl,
                                    mode: LaunchMode.externalApplication,
                                  );
                                }
                              },
                              child: GlassCard(
                                child: ListTile(
                                  leading: FaIcon(FontAwesomeIcons.instagram),
                                  title: Text('https://instagram.com/pankuub'),
                                  trailing: FaIcon(
                                    FontAwesomeIcons.link,
                                    size: 17,
                                  ),
                                ),
                              ),
                            ),

                            GestureDetector(
                              onTap: () async {
                                final webUrl = Uri.parse(
                                  "https://github.com/pankajzx",
                                );

                                await launchUrl(
                                  webUrl,
                                  mode: LaunchMode.externalApplication,
                                );
                              },
                              child: GlassCard(
                                child: ListTile(
                                  leading: FaIcon(FontAwesomeIcons.github),
                                  title: Text('https://github.com/pankajzx'),
                                  trailing: FaIcon(
                                    FontAwesomeIcons.link,
                                    size: 17,
                                  ),
                                ),
                              ),
                            ),

                            GlassCard(
                              child: ListTile(
                                leading: FaIcon(FontAwesomeIcons.linkedin),
                                title: Text('www.linkedin.com/in/pankajzx'),
                                trailing: FaIcon(
                                  FontAwesomeIcons.link,
                                  size: 17,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },

              child: Column(
                spacing: 5,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ShadowContainer(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            "https://cdn.pixabay.com/photo/2020/01/07/23/01/sketch-4748895_1280.jpg",
                          ),
                          fit: BoxFit.cover,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),

                  Row(
                    spacing: 5,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.instagram,
                        size: 17,
                        color: Colors.pink,
                      ),
                      Text('pankuub', style: PulseText.bodyLight),
                    ],
                  ),

                  Row(
                    spacing: 7,
                    children: [
                      FaIcon(FontAwesomeIcons.github, size: 17),
                      Text('pankajzx', style: PulseText.bodyLight),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: top2,
            left: left2,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  left2 += details.delta.dx;
                  top2 += details.delta.dy;
                });
              },

              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (_) {
                    return FractionallySizedBox(
                      heightFactor: 0.4,
                      child: GradientBackground(
                        child: Column(
                          spacing: 20,
                          children: [
                            Utils.spacePulse(),
                            GestureDetector(
                              onTap: () async {
                                final appUrl = Uri.parse(
                                  "instagram://user?username=_yourvignes",
                                );
                                final webUrl = Uri.parse(
                                  "https://instagram.com/_yourvignes",
                                );
                                if (await canLaunchUrl(appUrl)) {
                                  await launchUrl(
                                    appUrl,
                                    mode: LaunchMode.externalApplication,
                                  );
                                } else {
                                  await launchUrl(
                                    webUrl,
                                    mode: LaunchMode.externalApplication,
                                  );
                                }
                              },
                              child: GlassCard(
                                child: ListTile(
                                  leading: FaIcon(FontAwesomeIcons.instagram),
                                  title: Text(
                                    'https://instagram.com/_yourvignes',
                                  ),
                                  trailing: FaIcon(
                                    FontAwesomeIcons.link,
                                    size: 17,
                                  ),
                                ),
                              ),
                            ),

                            GestureDetector(
                              onTap: () async {
                                final webUrl = Uri.parse(
                                  "https://github.com/vignesh562",
                                );

                                await launchUrl(
                                  webUrl,
                                  mode: LaunchMode.externalApplication,
                                );
                              },
                              child: GlassCard(
                                child: ListTile(
                                  leading: FaIcon(FontAwesomeIcons.github),
                                  title: Text('https://github.com/vignesh562'),
                                  trailing: FaIcon(
                                    FontAwesomeIcons.link,
                                    size: 17,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },

              child: Column(
                spacing: 5,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ShadowContainer(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            "https://cdn.pixabay.com/photo/2020/01/07/23/01/sketch-4748895_1280.jpg",
                          ),
                          fit: BoxFit.cover,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),

                  Row(
                    spacing: 5,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.instagram,
                        size: 17,
                        color: Colors.pink,
                      ),
                      Text('_yourvignes', style: PulseText.bodyLight),
                    ],
                  ),

                  Row(
                    spacing: 7,
                    children: [
                      FaIcon(FontAwesomeIcons.github, size: 17),
                      Text('vignesh562', style: PulseText.bodyLight),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
