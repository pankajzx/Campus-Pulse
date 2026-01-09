import 'package:campuspulse/common/widgets/top_navigation_bar.dart';
import 'package:campuspulse/utils/constants/pulse_colors.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../common/widgets/glass_card.dart';
import '../../../utils/constants/pulse_text.dart';
import '../../../utils/utils.dart';
import '../widget/textfield_pulse.dart';

class ForgetPasswordScreen extends StatefulWidget {
  ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final forgetPasswordKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  bool loading = false;

  Future<void> sendPasswordReset(String email) async {
    setState(() {
      loading = true;
    });
    try {
      await Supabase.instance.client.auth.resetPasswordForEmail(
        email,
        redirectTo: 'io.supabase.campuspulse://reset-password',
      );
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavigationBar(title: 'Forget Password'),
      body: Padding(
        padding: Utils.screenPadding(vertical: 20),
        child: ListView(
          children: [
            Form(
              key: forgetPasswordKey,
              child: Column(
                children: [
                  TextFieldPulse(
                    label: 'Email',
                    hint: 'campusepulse@gmail.com',
                    controller: emailController,
                    prefixIcon: const Icon(Icons.email),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required.';
                      }
                      if (!value.contains('@gmail.com')) {
                        return 'Enter a valid email.';
                      }
                      return null;
                    },
                  ),

                  Utils.spacePulse(),

                  GestureDetector(
                    onTap: () {
                      if(forgetPasswordKey.currentState!.validate()){
                        sendPasswordReset(emailController.text.trim());
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.transparent,
                              duration: Duration(seconds: 2),
                              content: Text(
                                'Reset link sent successfully',
                                style: PulseText.label.copyWith(color: PulseColors.green),
                                textAlign: TextAlign.center,
                              ),
                            )
                        );
                      }
                    },
                    child: GlassCard(
                      child: Center(
                        child: Text(
                          loading ? 'Sending link...' : 'Send Reset link',
                          style: PulseText.btnTxt,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
