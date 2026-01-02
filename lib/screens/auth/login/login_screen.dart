import 'package:campuspulse/common/widgets/glass_card.dart';
import 'package:campuspulse/providers/auth/pulse_auth_provider.dart';
import 'package:campuspulse/screens/auth/widget/textfield_pulse.dart';
import 'package:campuspulse/utils/constants/pulse_colors.dart';
import 'package:campuspulse/utils/constants/pulse_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/utils.dart';
import '../forget_password/forget_password_screen.dart';
import '../signup/signup_screen.dart';


class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: PulseColors.primary,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: Utils.screenPadding(vertical: 20),
        child: ListView(
          children: [
            Text('Login to \nCampus Pulse', style: PulseText.heading),
            Utils.spacePulse(),
            Text(
              'Welcome back. Please enter your details to access your account.',
              style: PulseText.body,
            ),
            Utils.spacePulse(),

            Form(
              key: loginFormKey,
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
                      if (!value.contains('@')) {
                        return 'Enter a valid email.';
                      }
                      return null;
                    },
                  ),
                  Utils.spacePulse(),
                  TextFieldPulse(
                    controller: passwordController,
                    label: 'Password',
                    hint: '********',
                    obscureText: true,
                    prefixIcon: const Icon(Icons.lock),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required.';
                      }
                      return null;
                    },
                  ),
                  Utils.spacePulse(),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ForgetPasswordScreen(),
                          ),
                        );
                      },
                      child: Text('Forget Password?', style: PulseText.body),
                    ),
                  ),

                  Utils.spacePulse(),

                  Consumer<PulseAuthProvider>(
                    builder: (context,provider,child) {
                      return GestureDetector(
                        onTap: () =>  provider.login(emailController.text.toLowerCase(),passwordController.text),
                        child: GlassCard(
                          child: Center(child: Text( provider.loading ? 'Verifying...' : 'Login',style: PulseText.btnTxt)),
                        ),
                      );
                    }
                  ),
                ],
              ),
            ),

            Utils.spacePulse(height: 24),

            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: PulseColors.primaryLight,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text('Or continue with', style: PulseText.body),
                ),
                Expanded(
                  child: Divider(
                    color: PulseColors.primaryLight,
                  ),
                ),
              ],
            ),

            Utils.spacePulse(height: 24),

            GlassCard(
              child: Center(child: Text('Google',style: PulseText.body.copyWith(fontSize: 18,fontWeight: FontWeight.w500))),
            ),

            Utils.spacePulse(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?", style: PulseText.body),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SignupScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Sign Up',
                    style: PulseText.title.copyWith(fontSize: 14),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
