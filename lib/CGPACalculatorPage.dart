import 'package:ap_sara/animatedBackground.dart';
import 'package:flutter/material.dart';

class CGPACalculatorPage extends StatefulWidget {
  const CGPACalculatorPage({super.key});

  @override
  State<CGPACalculatorPage> createState() => _CGPACalculatorPageState();
}

class _CGPACalculatorPageState extends State<CGPACalculatorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          //AnimatedBackground(),
          Center(
            child: const Text(
              "(C)GPA Calculator coming soon...",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
