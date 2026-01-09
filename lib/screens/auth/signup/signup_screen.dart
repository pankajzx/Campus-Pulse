import 'package:campuspulse/utils/constants/pulse_colors.dart';
import 'package:campuspulse/utils/constants/pulse_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../common/widgets/glass_card.dart';
import '../../../utils/utils.dart';
import '../../auth/widget/textfield_pulse.dart';

class SignupScreen extends StatefulWidget {

  const SignupScreen({super.key});


  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool loading = false;
  bool isUser = true;

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  final supabase = Supabase.instance.client;

  Future<void> signUp() async {
    if (!signupFormKey.currentState!.validate()) return;

    setState(() => loading = true);

    try {
      final response = await supabase.auth.signUp(
        email: emailController.text.trim().toLowerCase(),
        password: passwordController.text.trim(),
      );

      final user = response.user;

      if (user != null && response.session != null) {
        await supabase.from('user_details').insert({
          'id': user.id,
          'name': fullNameController.text.trim(),
          'phone_number': null,
          'university': null,
          'profile_image': null,
          'qr_code': null,
          'confirmed_tickets': [],
          'cancelled_tickets': [],
          'favorites': [],
          'role_user': isUser,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.transparent,
            duration: const Duration(seconds: 2),
            content: Text(
              ' Registered Successfully ',
              style: PulseText.title.copyWith(color: PulseColors.green),
              textAlign: TextAlign.center,
            ),
          ),
        );

        Navigator.pop(context);
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: PulseColors.primary,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: Utils.screenPadding(vertical: 20),
        child: Form(
          key: signupFormKey,
          child: ListView(
            children: [
              Text('Sign Up', style: PulseText.heading),
              Utils.spacePulse(),
              Text(
                'Create your account and start exploring everything CampusPulse has to offer.',
                style: PulseText.body,
              ),
              Utils.spacePulse(height: 16),

              TextFieldPulse(
                controller: fullNameController,
                label: 'Full Name',
                hint: 'Campus Pulse',
                prefixIcon: const Icon(Icons.person),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Please enter your name.' : null,
              ),

              Utils.spacePulse(),

              TextFieldPulse(
                controller: emailController,
                label: 'Email Address',
                hint: 'campuspulse@gmail.com',
                prefixIcon: const Icon(Icons.email),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Please enter your email.';
                  if (!v.contains('@gmail.com')) {
                    return 'Enter a valid email.';
                  }
                  return null;
                },
              ),

              Utils.spacePulse(),

              TextFieldPulse(
                controller: passwordController,
                label: 'Password',
                hint: 'Create Password',
                obscureText: !_passwordVisible,
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                  child: Icon(
                    _passwordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Password is required.';
                  if (v.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  return null;
                },
              ),

              Utils.spacePulse(),

              TextFieldPulse(
                controller: confirmPasswordController,
                label: 'Confirm Password',
                hint: 'Repeat your password',
                obscureText: !_confirmPasswordVisible,
                prefixIcon: const Icon(Icons.lock_reset),

                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _confirmPasswordVisible = !_confirmPasswordVisible;
                    });
                  },
                  child: Icon(
                    _confirmPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),

                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Confirm Password is required.';
                  }
                  if (v != passwordController.text) {
                    return 'Password does not match.';
                  }
                  return null;
                },
              ),


              Utils.spacePulse(height: 6),

              Text('Role', style: PulseText.label),

              Utils.spacePulse(height: 6),

              GlassCard(
                child: Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isUser = true),
                        child: GlassCard(
                          child: Row(
                            spacing: 10,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.circleCheck,
                                size: 15,
                                color: isUser
                                    ? PulseColors.green
                                    : PulseColors.primaryLight,
                              ),
                              Text(
                                'User',
                                style: isUser
                                    ? PulseText.body
                                    : PulseText.body.copyWith(
                                        color: PulseColors.primaryLight,
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: GestureDetector(
                        // onTap: () => setState(() => isUser = false),
                        child: GlassCard(
                          child: Row(
                            spacing: 10,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.circleCheck,
                                size: 15,
                                color: !isUser
                                    ? PulseColors.green
                                    : PulseColors.primaryLight,
                              ),
                              Text(
                                'Organizer',
                                style: !isUser
                                    ? PulseText.body
                                    : PulseText.body.copyWith(
                                        color: PulseColors.primaryLight,
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Utils.spacePulse(height: 30),

              GestureDetector(
                onTap: signUp,
                child: GlassCard(
                  child: Center(
                    child: Text(
                      loading ? 'Registering...' : 'Register',
                      style: PulseText.btnTxt,
                    ),
                  ),
                ),
              ),

              Utils.spacePulse(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?", style: PulseText.body),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Log In',
                      style: PulseText.title.copyWith(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
