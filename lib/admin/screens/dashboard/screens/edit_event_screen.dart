import 'package:flutter/material.dart';
import 'package:campuspulse/common/widgets/glass_card.dart';
import 'package:campuspulse/common/widgets/pulse_button.dart';
import 'package:campuspulse/common/widgets/top_navigation_bar.dart';
import 'package:campuspulse/screens/auth/widget/textfield_pulse.dart';
import 'package:campuspulse/utils/constants/pulse_colors.dart';
import 'package:campuspulse/utils/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../screens/home/widgets/loading_screen.dart';

class EditEventScreen extends StatefulWidget {
  final dynamic eventId;
  String imgUrl = '';
  String name = '';
  String tagline = '';
  String date = '';
  String time = '';
  String location = '';
  String fullLocation = '';
  String about = '';
  String category = '';

  EditEventScreen({super.key, this.eventId});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
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

  Future<Map<String, dynamic>?> fetchEventDetails() async {
    return await supabase
        .from('event_details')
        .select('*')
        .eq('id', widget.eventId)
        .maybeSingle();
  }

  @override
  void initState() {
    imgUrlController.text = widget.imgUrl;
    nameController.text = widget.name;
    categoryController.text = widget.category;
    taglineController.text = widget.tagline;
    dateController.text = widget.date;
    timeController.text = widget.time;
    locationController.text = widget.location;
    fullLocationController.text = widget.fullLocation;
    aboutController.text = widget.about;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavigationBar(title: 'Update event'),
      body: FutureBuilder(
        future: fetchEventDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingScreen();
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final event = snapshot.data;
          if (event == null) {
            return const Center(child: Text("Event not found"));
          }

          final performers = event['performers'] as List<dynamic>;
          final agenda = event['agenda'] as List<dynamic>;


          imgUrlController.text = imgUrlController.text.isEmpty ? event['img_url'] ?? '' : imgUrlController.text;
          nameController.text = nameController.text.isEmpty ? event['name'] ?? '' : nameController.text;
          categoryController.text = categoryController.text.isEmpty ? event['category'] ?? '' : categoryController.text;
          taglineController.text = taglineController.text.isEmpty ? event['tagline'] ?? '' : taglineController.text;
          dateController.text = dateController.text.isEmpty ? event['date'] ?? '' : dateController.text;
          timeController.text = timeController.text.isEmpty ? event['time'] ?? '' : timeController.text;
          locationController.text = locationController.text.isEmpty ? event['location'] ?? '' : locationController.text;
          fullLocationController.text = fullLocationController.text.isEmpty ? event['full_location'] ?? '' : fullLocationController.text;
          aboutController.text = aboutController.text.isEmpty ? event['about'] ?? '' : aboutController.text;

          return Padding(
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
                  btnName: 'Update Event',
                  onTap: () {},
                  color: PulseColors.blue,
                ),

                Utils.spacePulse(),
              ],
            ),
          );
        },
      ),
    );
  }
}