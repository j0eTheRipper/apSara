import 'package:flutter/material.dart';

class ObscuredTextFieldSample extends StatelessWidget {
  final Function(String data) callback;
  final String placeholder;

  const ObscuredTextFieldSample({super.key, required this.callback, required this.placeholder});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: TextField(
        decoration: InputDecoration(labelText: placeholder),
        textInputAction: TextInputAction.next,
        onSubmitted: (value) => callback(value),
      ),
    );
  }
}
