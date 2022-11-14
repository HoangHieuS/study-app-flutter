import 'package:flutter/material.dart';

class CustomIconText extends StatelessWidget {
  final Icon icon;
  final Widget text;

  const CustomIconText({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        const SizedBox(width: 4),
        text,
      ],
    );
  }
}
