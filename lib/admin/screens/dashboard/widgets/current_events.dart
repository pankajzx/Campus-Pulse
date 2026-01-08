import 'package:campuspulse/common/widgets/circular_container.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../common/widgets/glass_card.dart';
import '../../../../common/widgets/iocn_text.dart';
import '../../../../common/widgets/pulse_tag.dart';
import '../../../../utils/constants/pulse_colors.dart';
import '../../../../utils/constants/pulse_text.dart';

class CurrentEvents extends StatelessWidget {
  final DateTime date;
  final String title, location;
  final Color color;
  final String eventId;
  VoidCallback onEdit;
  VoidCallback onDelete;

  CurrentEvents({
    super.key,
    required this.title,
    required this.location,
    required this.color,
    required this.date,
    required this.eventId,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      // width: 500,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 15,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: PulseColors.primary.withAlpha(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  DateFormat('MMM').format(date).toUpperCase(),
                  style: PulseText.label.copyWith(fontSize: 10),
                ),

                Text(DateFormat('d').format(date), style: PulseText.label),
              ],
            ),
          ),

          Expanded(
            child: SizedBox(
              height: 40,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: PulseText.label),
                      IconText(
                        icon: FontAwesomeIcons.locationPin,
                        iconSize: 12,
                        iconColor: PulseColors.primaryLight,
                        text: location,
                        txtStyle: PulseText.bodyLight.copyWith(
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          GestureDetector(
            onTap: onEdit,
            child: CircularContainer(
              color: PulseColors.green,
              icon: FaIcon(FontAwesomeIcons.pencil),
            ),
          ),

          GestureDetector(
            onTap: onDelete,
            child: CircularContainer(
              color: PulseColors.red,
              icon: FaIcon(FontAwesomeIcons.trash),
            ),
          ),
        ],
      ),
    );
  }
}