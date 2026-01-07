import 'package:campuspulse/utils/constants/pulse_colors.dart';
import 'package:campuspulse/utils/constants/pulse_text.dart';
import 'package:flutter/material.dart';
import '../../../utils/utils.dart';

class TextFieldPulse extends StatelessWidget {

  final String? label,hint;
  final Widget? prefixIcon,suffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool? obscureText,readOnly;
  final int? maxline;

  const TextFieldPulse({
    super.key,
    required this.hint,
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.obscureText,
    this.readOnly,
    this.maxline = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label!, style: PulseText.title),
        Utils.spacePulse(height:6),
        TextFormField(
          controller: controller,
          validator: validator,
          readOnly: readOnly ?? false,
          obscureText: obscureText ?? false,
          maxLines: maxline,
          decoration: InputDecoration(
            visualDensity:VisualDensity.compact,
            hintText: hint,
            hintStyle: PulseText.body.copyWith(color: PulseColors.primaryLight),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            prefixIconColor: PulseColors.primaryLight,
            suffixIconColor: PulseColors.primaryLight,
            filled: true,
            fillColor: PulseColors.primaryLight.withAlpha(25),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
