import 'package:ap_sara/UserGoogleAccount.dart';
import 'package:flutter/material.dart';
import 'package:ap_sara/Scheduler/Class.dart';
import 'package:ap_sara/Scheduler/IconText.dart';

class ClassWidget extends StatelessWidget {
  final Class classData;
  final GoogleCalendarStuff account;

  const ClassWidget({
    super.key,
    required this.classData, required this.account,
  });

  @override
  Widget build(BuildContext context) {
    account.signInSilently();
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent,
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
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          IconText(
              icon: const Icon(Icons.access_time, color: Colors.grey, size: 16),
              text: "${classData.startTime}-> ${classData.endTime}"),
          const SizedBox(height: 8),
          IconText(
              icon: const Icon(Icons.calendar_month_outlined,
                  color: Colors.grey, size: 16),
              text: "${classData.day}, ${classData.date}"),
          const SizedBox(height: 8),
          IconText(
              icon: const Icon(Icons.location_on, color: Colors.blue, size: 16),
              text: classData.location),
          const SizedBox(height: 4),
          IconText(
              icon: const Icon(Icons.person, color: Colors.blue, size: 16),
              text: classData.tutor),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () async {
                print(await account.isOccupied(classData.start, classData.end));
                await account.addToCalendar(classData);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              child: const Text(
                "Add To calendar",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
