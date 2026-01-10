import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../common/widgets/glass_card.dart';
import '../../../../utils/constants/pulse_colors.dart';
import '../../../../utils/constants/pulse_text.dart';

class TotalUsers extends StatelessWidget {

  final int userCount;

  const TotalUsers({super.key,required this.userCount});

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      spacing: 15,
      children: [
        GlassCard(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                FaIcon(
                  FontAwesomeIcons.userGroup,
                  color: PulseColors.blue,
                  size: 15,
                ),
                Text(
                  'TOTAL USERS',
                  style: PulseText.label.copyWith(
                    color: PulseColors.primaryLight,
                  ),
                ),

                FaIcon(
                  FontAwesomeIcons.arrowTrendUp,
                  color: PulseColors.green,
                  size: 12,
                ),
                Text(
                  userCount.toString(),
                  style: PulseText.btnTxt.copyWith(color: PulseColors.green),
                ),
              ],
            ),
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text('All users', style: PulseText.label)],
        ),
      ],
    );
  }
}
