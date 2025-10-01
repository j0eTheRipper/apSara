import 'package:ap_sara/CustomElevatedButton.dart';
import 'package:ap_sara/CustomTextInput.dart';
import 'package:ap_sara/LogoutElevatedButton.dart';
import 'package:ap_sara/google_account_signin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentInfoForm extends StatelessWidget {
  final void Function(String intake, String group) onSave;
  final GoogleCalendarStuff account;

  const StudentInfoForm({
    super.key,
    required this.onSave,
    required this.account,
  });

  void onSaveInfo(
    TextEditingController intakeCtrl,
    TextEditingController groupCtrl,
    BuildContext context,
  ) {
    if (intakeCtrl.text.isEmpty || groupCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Fill in the fields first"),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      onSave(intakeCtrl.text.toUpperCase(), groupCtrl.text.toUpperCase());
    }
  }

  @override
  Widget build(BuildContext context) {
    final intakeCtrl = TextEditingController();
    final groupCtrl = TextEditingController();

    return SizedBox(
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(controller: intakeCtrl, label: "Intake Code"),
          const SizedBox(height: 8),
          CustomTextField(controller: groupCtrl, label: "Group"),
          const SizedBox(height: 8),
          CustomElevatedButton(
            onPressed: () => onSaveInfo(intakeCtrl, groupCtrl, context),
            label: "Save Info",
          ),
          Consumer<GoogleCalendarStuff>(
            builder: (context, calendar, child) {
              if (!calendar.isAuthorized) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomElevatedButton(
                    onPressed: account.signInHandler,
                    label: "Sign in with Google",
                  ),
                );
              } else {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Already logged in as : ${calendar.account}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LogoutElevatedButton(
                        onPressed: () async => await account.signOut(),
                        label: "Signout from Google",
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
