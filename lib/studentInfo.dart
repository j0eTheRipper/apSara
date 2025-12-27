import 'package:ap_sara/StudentInfoForm.dart';
import 'package:ap_sara/animatedBackground.dart';
import 'package:ap_sara/ap_schedule.dart';
import 'package:ap_sara/google_account_signin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentInfo extends StatefulWidget {
  const StudentInfo({super.key});

  @override
  State<StudentInfo> createState() => _StudentInfoState();
}

class _StudentInfoState extends State<StudentInfo> {
  bool showSchedule = false;
  String intakeCode = "";
  String groupNumber = "";
  late GoogleCalendarStuff account;

  @override
  void initState() {
    super.initState();
    account = Provider.of<GoogleCalendarStuff>(context, listen: false);
    account.signInSilently();
  }

  void saveInfo(String intake, String group) {
    setState(() {
      intakeCode = intake;
      groupNumber = group;
      showSchedule = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    account.signInSilently();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          //AnimatedBackground(),
          Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child:
                  showSchedule
                      ? ApSchedule(
                        key: const ValueKey("ApSchedule"),
                        intakeCode: intakeCode,
                        groupNumber: groupNumber,
                        account: account,
                        onBack: () {
                          setState(() {
                            showSchedule = false;
                          });
                        },
                      )
                      : StudentInfoForm(
                        key: const ValueKey("StudentInfoForm"),
                        onSave: saveInfo,
                        account: account,
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
