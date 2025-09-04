import 'package:ap_sara/ap_schedule.dart';
import 'package:ap_sara/google_account_signin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentInfo extends StatelessWidget {
  const StudentInfo({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController intakeCtrl = TextEditingController();
    TextEditingController groupCtrl = TextEditingController();
    GoogleCalendarStuff account = Provider.of<GoogleCalendarStuff>(
      context,
      listen: false,
    );
    account.signInSilently();
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/sara.png"),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: intakeCtrl,
                    decoration: InputDecoration(labelText: "Intake code"),
                    textInputAction: TextInputAction.next,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: groupCtrl,
                    decoration: InputDecoration(labelText: "Group"),
                    textInputAction: TextInputAction.done,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return ApSchedule(
                              intakeCode: intakeCtrl.text.toUpperCase(),
                              groupNumber: groupCtrl.text.toUpperCase(),
                              account: account,
                            );
                          },
                        ),
                      );
                    },
                    child: Text("Save info"),
                  ),
                ),
                Consumer<GoogleCalendarStuff>(
                  builder: (context, calendar, child) {
                    if (!calendar.isAuthorized) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (!calendar.isAuthorized) {
                              account.signInHandler();
                            }
                          },
                          child: Text("sign in with google"),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "already logged in as : ${calendar.account}",
                        ),
                      );
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async => await account.signOut(),
                    child: Text("Signout"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
