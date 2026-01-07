import 'package:campuspulse/utils/constants/pulse_text.dart';
import 'package:flutter/material.dart';

class AddNewEventScreen extends StatelessWidget {
  const AddNewEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Add new event',style: PulseText.heading),
      ) ,
    );
  }
}
