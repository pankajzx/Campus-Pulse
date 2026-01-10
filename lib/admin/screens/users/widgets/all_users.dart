import 'package:campuspulse/common/widgets/circular_container.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../common/widgets/glass_card.dart';
import '../../../../utils/constants/pulse_colors.dart';
import '../../../../utils/constants/pulse_text.dart';

class AllUsers extends StatelessWidget {
  final int count;
  final String name;
  VoidCallback onDelete;

  AllUsers({
    super.key,
    required this.count,
    required this.name,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Row(
        spacing: 15,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: PulseColors.primary.withAlpha(10),
            child: Text('${count}', style: PulseText.label),
          ),

          Text(name, style: PulseText.label),

          Spacer(),

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