import 'dart:convert';
import 'package:ap_sara/CustomElevatedButton.dart';
import 'package:ap_sara/Scheduler/ClassWidget.dart';
import 'package:ap_sara/animatedBackground.dart';
import 'package:ap_sara/google_account_signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'Scheduler/Timetable.dart';

class ApSchedule extends StatelessWidget {
  final String intakeCode;
  final String groupNumber;
  final GoogleCalendarStuff account;
  final VoidCallback onBack;

  const ApSchedule({
    super.key,
    required this.intakeCode,
    required this.groupNumber,
    required this.account,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    Future<Timetable> schedule = getTimetable();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          //AnimatedBackground(),
          Center(
            child: FutureBuilder<Timetable>(
              future: schedule,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (!snapshot.hasError) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.classes.isNotEmpty) {
                        //snapshot.hasData) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: CustomElevatedButton(
                                  onPressed: onBack,
                                  label: "Go back",
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: snapshot.data!.classes.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClassWidget(
                                      classData: snapshot.data!.classes[index],
                                      account: account,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      } else {
                        //if (!snapshot.hasData ||snapshot.data!.classes.isEmpty) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: CustomElevatedButton(
                                  onPressed: onBack,
                                  label: "Go back",
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  "No classes for this intake, for now...",
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    }
                  } else {
                    // Error occurred
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: CustomElevatedButton(
                              onPressed: onBack,
                              label: "Go back",
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              "Error: ${snapshot.error}",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }

                // Fallback case
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: CustomElevatedButton(
                          onPressed: onBack,
                          label: "Go back",
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "An unknown error ocurred...",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<Timetable> getTimetable() async {
    final String url =
        "${dotenv.env["CALENDAR_API"]!}/get_timetable/$intakeCode/$groupNumber";
    print(url);
    final response = await http.get(Uri.parse(url));
    List<dynamic> jsonResponse = jsonDecode(response.body);
    return Timetable.fromJson(jsonResponse);
  }
}
