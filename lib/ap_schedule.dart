import 'dart:convert';
import 'package:ap_sara/Scheduler/ClassWidget.dart';
import 'package:ap_sara/google_account_signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'Scheduler/Timetable.dart';

class ApSchedule extends StatelessWidget {
  final String intakeCode;
  final String groupNumber;
  final GoogleCalendarStuff account;

  const ApSchedule({
    super.key,
    required this.intakeCode,
    required this.groupNumber,
    required this.account,
  });

  @override
  Widget build(BuildContext context) {
    Future<Timetable> schedule = getTimetable();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<Timetable>(
              future: schedule,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
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
                  );
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
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
