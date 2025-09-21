import 'package:flutter/material.dart';

class LogoutElevatedButton extends StatelessWidget {
  final Function()? onPressed;
  final String label;

  const LogoutElevatedButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(Object context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 188, 41, 12),
        foregroundColor: Colors.white,
        shadowColor: Colors.black54,
        elevation: 4,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ).copyWith(
        overlayColor: WidgetStateProperty.all(
          const Color.fromARGB(255, 218, 102, 73).withOpacity(0.2),
        ),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
