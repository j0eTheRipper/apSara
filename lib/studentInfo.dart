import 'package:ap_sara/InputField.dart';
import 'package:flutter/material.dart';

class StudentInfo extends StatelessWidget {
  const StudentInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/sara.png"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 250,
                child: TextField(
                  decoration: InputDecoration(labelText: "Intake code"),
                  textInputAction: TextInputAction.next,
                  onSubmitted: (value) => print(value),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 250,
                child: TextField(
                  decoration: InputDecoration(labelText: "Group"),
                  textInputAction: TextInputAction.done,
                  onSubmitted: (value) => print(value),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
