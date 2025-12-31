import 'package:campuspulse/Admin/Screens/admin_dashboard.dart';
import 'package:campuspulse/common/widgets/circular_container.dart';
import 'package:campuspulse/common/widgets/glass_card.dart';
import 'package:campuspulse/common/widgets/pulse_button.dart';
import 'package:campuspulse/common/widgets/top_navigation_bar.dart';
import 'package:campuspulse/providers/auth/pulse_auth_provider.dart';
import 'package:campuspulse/screens/auth/login/login_screen.dart';
import 'package:campuspulse/screens/my_ticket/my_ticket_screen.dart';
import 'package:campuspulse/screens/profile/screens/change_password_screen.dart';
import 'package:campuspulse/screens/profile/screens/edit_profile_screen.dart';
import 'package:campuspulse/screens/profile/screens/meet_developers.dart';
import 'package:campuspulse/screens/profile/widgets/profile_card.dart';
import 'package:campuspulse/screens/profile/widgets/settings_tile.dart';
import 'package:campuspulse/utils/constants/pulse_colors.dart';
import 'package:campuspulse/utils/constants/pulse_text.dart';
import 'package:campuspulse/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final supabase = Supabase.instance.client;
  bool loading = false;
  String name = '' ;
  String university = '';
  String phone = '';
  String email = '' ;

  @override
  void initState() {
    fetchUserDetails();
    super.initState();
  }

  Future<void> fetchUserDetails() async {
    try {
      setState(() => loading = true);

      final currentUser = supabase.auth.currentUser;
      if (currentUser == null) return;

      final emailId = currentUser.email ?? '';
      final uid = currentUser.id;

      final response = await supabase
          .from('user_details')
          .select('name, phone_number, university, profile_image')
          .eq('id', uid)
          .single();

      setState(() {
        // <-- IMPORTANT
        name = response['name'] ?? '';
        university = response['university'] ?? '';
        phone = response['phone_number'] ?? '';
        email = emailId;
      });

    } catch (e) {
      print('Profile fetch error: $e');
    } finally {
      setState(() => loading = false);
    }
  }



  Future<void> logOut() async {
    setState(() {
      loading = true;
    });

    try {
      await supabase.auth.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
        (route) => false,
      );
    } catch (e) {
      print(e);
    } finally {
      loading = false;
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: TopNavigationBar(title: 'User Profile'),

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 24),
        child: ListView(
          children: [
            ProfileCard(
              name:name,
              universityName: university,
              imagePath:
                  "https://cdn.pixabay.com/photo/2020/01/07/23/01/sketch-4748895_1280.jpg",
            ),

            Utils.spacePulse(height: 25),

            GlassCard(
              child: Column(
                spacing: 25,
                children: [
                  SettingsTile(
                    color: PulseColors.blue,
                    icon: FaIcon(FontAwesomeIcons.pencil),
                    name: 'Edit Profile',
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditProfileScreen(
                            name: name,
                            universityName: university,
                            phone: phone,
                            emailId: email,
                          ),
                        ),
                      );
                      fetchUserDetails();
                    },
                  ),

                  SettingsTile(
                    color: PulseColors.purple,
                    icon: FaIcon(FontAwesomeIcons.bell),
                    name: 'Notification',
                    onTap: () {},
                  ),

                  SettingsTile(
                    color: PulseColors.green,
                    icon: FaIcon(FontAwesomeIcons.lock),
                    name: 'Change Password',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChangePasswordScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            Utils.spacePulse(height: 25),

            GlassCard(
              child: Column(
                spacing: 25,
                children: [
                  SettingsTile(
                    color: PulseColors.red,
                    icon: FaIcon(FontAwesomeIcons.lock),
                    name: 'Privacy Policy',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => AdminDashboard()),
                      );
                    },
                  ),

                  SettingsTile(
                    color: PulseColors.orange,
                    icon: FaIcon(FontAwesomeIcons.info),
                    name: 'Help and Support',
                    onTap: () {},
                  ),

                  SettingsTile(
                    color: PulseColors.primary,
                    icon: FaIcon(FontAwesomeIcons.code),
                    name: 'Contact Developers',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => MeetDevelopers()),
                      );
                    },
                  ),
                ],
              ),
            ),

            Utils.spacePulse(height: 25),

            Consumer<PulseAuthProvider>(
              builder: (context,provider,child) {
                return PulseButton(
                  btnName: provider.loading ? 'Logging Out...' : 'Log Out',
                  icon: FontAwesomeIcons.arrowRightFromBracket,
                  onTap: ()=>provider.logOut(),
                  color: PulseColors.red,
                );
              }
            ),

            Utils.spacePulse(height: 25),

            // ),
          ],
        ),
      ),
    );
  }
}
