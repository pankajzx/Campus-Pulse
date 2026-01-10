import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../common/widgets/glass_card.dart';
import '../../../../utils/constants/pulse_colors.dart';
import '../../../../utils/constants/pulse_text.dart';

class TotalUsers extends StatelessWidget {
  final int userCount;

  const TotalUsers({super.key, required this.userCount});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GlassCard(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const FaIcon(
                  FontAwesomeIcons.userGroup,
                  color: PulseColors.blue,
                  size: 15,
                ),
                const SizedBox(width: 8),
                Text(
                  'TOTAL USERS',
                  style: PulseText.label.copyWith(color: PulseColors.primaryLight),
                ),
                const SizedBox(width: 8),
                const FaIcon(
                  FontAwesomeIcons.arrowTrendUp,
                  color: PulseColors.green,
                  size: 12,
                ),
                const SizedBox(width: 4),
                Text(
                  userCount.toString(),
                  style: PulseText.btnTxt.copyWith(color: PulseColors.green),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 15),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'All users',
            style: PulseText.label,
          ),
        ),
      ],
    );
  }
}
