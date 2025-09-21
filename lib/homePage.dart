import 'package:ap_sara/CustomElevatedButton.dart';
import 'package:ap_sara/LogoutElevatedButton.dart';
import 'package:ap_sara/animatedBackground.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final void Function(int) onNavigate;

  const HomePage({super.key, required this.onNavigate});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          AnimatedBackground(),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                // Title
                const Text(
                  "Welcome to APSara!",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),
                CustomElevatedButton(
                  onPressed: () => widget.onNavigate(1),
                  label: "Courses & Google Calendar",
                ),
                const SizedBox(height: 20),
                CustomElevatedButton(
                  onPressed: () => widget.onNavigate(2),
                  label: "Chat with Sara",
                ),
                const SizedBox(height: 20),
                CustomElevatedButton(
                  onPressed: () => widget.onNavigate(3),
                  label: "Campus navigation",
                ),
                const SizedBox(height: 20),
                CustomElevatedButton(
                  onPressed: () => widget.onNavigate(4),
                  label: "(C)GPA Calculator",
                ),
                const SizedBox(height: 20),
                LogoutElevatedButton(
                  onPressed: () {},
                  label: "Sign Out",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

