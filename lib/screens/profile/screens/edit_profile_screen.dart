import 'package:campuspulse/common/widgets/top_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../common/widgets/glass_card.dart';
import '../../../common/widgets/pulse_button.dart';
import '../../../utils/constants/pulse_colors.dart';
import '../../../utils/constants/pulse_text.dart';
import '../../../utils/utils.dart';
import '../../auth/widget/textfield_pulse.dart';

class EditProfileScreen extends StatefulWidget {
  String name;
  String universityName;
  String phone;
  String emailId;

  EditProfileScreen({
    super.key,
    required this.name,
    required this.universityName,
    required this.phone,
    required this.emailId,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  final nameController = TextEditingController();
  final uniController = TextEditingController();
  final phoneController = TextEditingController();

  String btnText = "Confirm Changes";
  Color btnColor = PulseColors.primary;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    uniController.text = widget.universityName;
    phoneController.text = widget.phone;
  }

  Future<void> updateProfile() async {
    final supabase = Supabase.instance.client;

    try {
      setState(() => loading = true);


      final userId = supabase.auth.currentUser!.id;

      final response = await supabase
          .from('user_details')
          .update({
        'name': nameController.text.trim(),
        'university': uniController.text.trim(),
        'phone_number': phoneController.text.trim(),
      })
          .eq('id', userId);

      print("Update response: $response");

      setState(() {
        btnText = 'Changes Saved';
        btnColor = PulseColors.green;
      });

      Navigator.pop(context);

    } catch (e) {
      print('Profile update error: $e');
    } finally {
      setState(() => loading = false);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavigationBar(title: 'Edit Profile'),
      body: Padding(
        padding: Utils.screenPadding(),
        child: ListView(
          children: [
            GlassCard(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  spacing: 15,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Stack(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: NetworkImage(
                                  "https://cdn.pixabay.com/photo/2020/01/07/23/01/sketch-4748895_1280.jpg",
                                ),
                                fit: BoxFit.cover,
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: PulseColors.blue,
                                  blurRadius: 100,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: PulseColors.primary,
                                border: BoxBorder.all(color: PulseColors.blue),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: FaIcon(
                                  FontAwesomeIcons.pencil,
                                  size: 12,
                                  color: PulseColors.blue,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Text(
                      'Edit profile',
                      style: PulseText.body.copyWith(color: PulseColors.blue),
                    ),


                    TextFieldPulse(
                      controller: nameController,
                      label: 'Full name',
                      prefixIcon: const Icon(Icons.person),
                      hint: 'Enter your name',
                    ),


                    TextFieldPulse(
                      controller: uniController,
                      label: 'University name',
                      prefixIcon: const Icon(Icons.warehouse_outlined),
                      hint: 'Enter university name',
                    ),


                    TextFieldPulse(
                      controller: phoneController,
                      label: 'Phone number',
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 10, right: 6, top: 10),
                        child: Text(
                          '+91',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: PulseColors.primaryLight,
                          ),
                        ),
                      ),
                      hint: '',
                    ),


                    TextFieldPulse(
                      label: 'Email address',
                      hint: widget.emailId,
                      readOnly: true,
                      prefixIcon: const Icon(Icons.email),
                    ),
                  ],
                ),
              ),
            ),

            Utils.spacePulse(),
            Utils.spacePulse(),

            PulseButton(
              icon: FontAwesomeIcons.circleCheck,
              onTap: (){
                updateProfile();
              },
              color: btnColor,
              btnName: loading ? "Saving..." : btnText,
            ),

            Utils.spacePulse(),
          ],
        ),
      ),
    );
  }
}
