import 'package:campuspulse/common/widgets/shadow_container.dart';
import 'package:campuspulse/screens/auth/login/login_screen.dart';
import 'package:campuspulse/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../utils/constants/pulse_text.dart';
import 'onboarding/onboarding1screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final supabase = Supabase.instance.client;

  Future<void> nextScreen()async{
    if(supabase.auth.currentUser != null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>MainScreen()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Onboarding1Screen()));
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      nextScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: ShadowContainer(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Campus',
                style: PulseText.heading,
              ),
              Text(
                'Pulse',
                style: PulseText.heading.copyWith(fontSize: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
