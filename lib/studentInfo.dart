import 'package:ap_sara/ApSchedule.dart';
import 'package:ap_sara/UserGoogleAccount.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentInfo extends StatelessWidget {
  const StudentInfo({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController intakeCtrl = TextEditingController();
    TextEditingController groupCtrl = TextEditingController();
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
                            return ApSchedule(intakeCode: intakeCtrl.text.toUpperCase(),
                            groupNumber: groupCtrl.text.toUpperCase(),
                            );
                          },
                        ),
                      );
                    },
                    child: Text("Save info"),
                  ),
                ),
                Consumer<UserGoogleAccount>(
                  builder: (context, account, child) {
                    return Padding(padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(onPressed: () {
                        if (!account.isAuthorized) {
                          account.signInHandler();
                        }
                      }, child: Text("connect your google account")),
                    );
                  },
                ),
                Text("Signed in as: ${Provider.of<UserGoogleAccount>(context, listen: true).account}")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
