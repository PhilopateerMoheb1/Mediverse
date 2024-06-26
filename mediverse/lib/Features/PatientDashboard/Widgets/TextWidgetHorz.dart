import 'package:flutter/material.dart';

import '../../../Constants/Themes.dart';

class TextWidgetHorz extends StatelessWidget {
  const TextWidgetHorz(
      {super.key, required this.leadingText, required this.secondryText});

  final String leadingText;
  final String secondryText;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          leadingText,
          style: Themes.labelMedium.copyWith(
            fontFamily: 'Readex Pro',
            fontWeight: FontWeight.normal,
          ),
        ),
        Text(
          secondryText,
          style: Themes.labelLarge18,
        ),
      ],
    );
  }
}
