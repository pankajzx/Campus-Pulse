import 'package:campuspulse/common/widgets/glass_card.dart';
import 'package:campuspulse/common/widgets/pulse_button.dart';
import 'package:campuspulse/common/widgets/top_navigation_bar.dart';
import 'package:campuspulse/screens/auth/widget/textfield_pulse.dart';
import 'package:campuspulse/utils/constants/pulse_colors.dart';
import 'package:campuspulse/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddNewEventScreen extends StatelessWidget {
  AddNewEventScreen({super.key});

  addEvent() {

  }

  final supabase = Supabase.instance.client;

  TextEditingController imgUrlController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController taglineController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController fullLocationController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavigationBar(title: 'Add event'),
      body: Padding(
        padding: Utils.screenPadding(),
        child: ListView(
          children: [
            TextFieldPulse(
              hint: 'Enter image url',
              label: 'Event Image',
              controller: imgUrlController,
            ),

            Utils.spacePulse(),

            TextFieldPulse(
              hint: 'Enter event name',
              label: 'Event Name',
              controller: nameController,
            ),

            Utils.spacePulse(),

            TextFieldPulse(
              hint: 'Enter event category ',
              label: 'Event Category',
              controller: categoryController,
            ),

            Utils.spacePulse(),

            TextFieldPulse(
              hint: 'Enter tagline for event',
              label: 'Event Tagline',
              controller: taglineController,
            ),

            Utils.spacePulse(),

            TextFieldPulse(
              hint: 'Event date',
              label: 'Select event date',
              controller: dateController,
            ),

            Utils.spacePulse(),

            TextFieldPulse(
              hint: 'Event time',
              label: 'Select event time',
              controller: timeController,
            ),

            Utils.spacePulse(),

            TextFieldPulse(
              hint: 'Enter stage location',
              label: 'Event Location',
              controller: locationController,
            ),

            Utils.spacePulse(),

            TextFieldPulse(
              hint: 'Enter event full location',
              label: 'Event Full Location',
              controller: fullLocationController,
            ),

            Utils.spacePulse(),

            TextFieldPulse(
              hint: 'Enter description for event here... ',
              label: 'Event Description',
              maxline: 6,
              controller: aboutController,
            ),

            Utils.spacePulse(),

            Text('Event Performers'),

            Utils.spacePulse(),

            Row(
              spacing: 10,
              children: [
                Expanded(
                  child: GlassCard(
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.plus,
                        color: PulseColors.blue,
                        size: 17,
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: GlassCard(
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.plus,
                        color: PulseColors.blue,
                        size: 17,
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: GlassCard(
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.plus,
                        color: PulseColors.blue,
                        size: 17,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Utils.spacePulse(),

            Text('Event Agenda'),

            Utils.spacePulse(),

            Row(
              spacing: 10,
              children: [
                Expanded(
                  child: GlassCard(
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.plus,
                        color: PulseColors.blue,
                        size: 17,
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: GlassCard(
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.plus,
                        color: PulseColors.blue,
                        size: 17,
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: GlassCard(
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.plus,
                        color: PulseColors.blue,
                        size: 17,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Utils.spacePulse(),

            PulseButton(
              btnName: 'Add Event',
              onTap: addEvent,
              color: PulseColors.blue,
            ),

            Utils.spacePulse(),
          ],
        ),
      ),
    );
  }
}