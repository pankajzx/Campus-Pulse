import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../common/widgets/glass_card.dart';
import '../../utils/constants/pulse_colors.dart';
import '../../utils/constants/pulse_text.dart';

class AdminBottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTap;

  const AdminBottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = [

      {
        "icon": FontAwesomeIcons.qrcode,
        "label": "Scan QR",
        "color": Colors.orange,
        "bg": Colors.orange.withOpacity(.15),
      },
      {
        "icon": FontAwesomeIcons.house,
        "label": "Home",
        "color": PulseColors.blue,
        "bg": PulseColors.blue.withOpacity(.15),
      },
      {
        "icon": FontAwesomeIcons.userGroup,
        "label": "All Users",
        "color": PulseColors.purple,
        "bg": PulseColors.purple.withOpacity(.15),
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: GlassCard(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(items.length, (index) {
            final isSelected = index == selectedIndex;
            final item = items[index];

            return GestureDetector(
              onTap: () => onItemTap(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: isSelected
                      ? item["bg"] as Color
                      : Colors.white.withOpacity(.12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      item["icon"] as IconData,
                      size: 20,
                      color: isSelected
                          ? item["color"] as Color
                          : PulseColors.primaryLight,
                    ),
                    if (isSelected) ...[
                      const SizedBox(width: 8),
                      Text(
                        item["label"] as String,
                        style: PulseText.label.copyWith(
                          color: item["color"] as Color,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}