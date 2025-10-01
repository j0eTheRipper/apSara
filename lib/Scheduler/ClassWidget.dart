import 'package:ap_sara/google_account_signin.dart';
import 'package:flutter/material.dart';
import 'package:ap_sara/Scheduler/Class.dart';
import 'package:ap_sara/Scheduler/icon_text.dart';

//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:material_symbols_icons/symbols_map.dart';
//import 'package:material_symbols_icons/material_symbols_icons.dart';

class ClassWidget extends StatelessWidget {
  final Class classData;
  final GoogleCalendarStuff account;

  const ClassWidget({
    super.key,
    required this.classData,
    required this.account,
  });

  @override
  Widget build(BuildContext context) {
    account.signInSilently();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(
          255,
          57,
          26,
          140,
        ), //Colors.deepPurpleAccent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            classData.moduleID,
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            classData.moduleTitle,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 8),
          IconText(
            icon: const Icon(Icons.access_time, color: Colors.grey, size: 16),
            text: "${classData.startTime}-> ${classData.endTime}",
          ),
          const SizedBox(height: 8),
          IconText(
            icon: const Icon(
              Icons.calendar_month_outlined,
              color: Colors.grey,
              size: 16,
            ),
            text: "${classData.day}, ${classData.date}",
          ),
          const SizedBox(height: 8),
          IconText(
            icon: const Icon(Icons.location_on, color: Colors.blue, size: 16),
            text: classData.location,
          ),
          const SizedBox(height: 4),
          IconText(
            icon: const Icon(Icons.person, color: Colors.blue, size: 16),
            text: classData.tutor,
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () async {
                if (account.isAuthorized) {
                  //final classEvent = 
                  await account.addToCalendar(classData);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Added to Google Calendar!"),
                      backgroundColor: Colors.green,
                    ),
                  );
                  /*
                  if (null != classEvent) {
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Added to Google Calendar!"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                  */
                } else {
                  // Display error message
                  // 'Not signed in with google!'
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Not signed in with Google!"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.add, color: Colors.white),
                  const Text(
                    "Add To Google Calendar",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
