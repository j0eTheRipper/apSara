import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const CustomTextField({super.key, required this.controller, required this.label});
  
  @override
  Widget build(Object context) {
    return TextField(
      controller: controller,
      style: TextStyle(
        color: Colors.white, // strong white for actual text
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[900], // dark gray background
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.lightBlueAccent, // light blue caption
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2),
        ),
      ),
      textInputAction: TextInputAction.next,
    );
  }
}
