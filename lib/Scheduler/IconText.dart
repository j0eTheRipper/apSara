import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final Icon icon;
  final String text;
  const IconText({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          icon,
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      );
  }
}
