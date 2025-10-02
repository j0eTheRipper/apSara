import 'package:ap_sara/LoggedInApp.dart';
import 'package:ap_sara/SaraChat.dart';
import 'package:ap_sara/SaraStuff.dart';
import 'package:ap_sara/google_account_signin.dart';
import 'package:ap_sara/campusNavigatorPage.dart';
import 'package:ap_sara/studentInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future main() async {
  await dotenv.load();
  print(dotenv.env);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'APSara',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: LoggedInApp(), //Login(),
    );
  }
}

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/sara.png"),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return ChangeNotifierProvider(
                        create: (context) => GoogleCalendarStuff(),
                        child: StudentInfo(),
                      );
                    },
                  ),
                );
              },
              child: Text("Provide calendar info"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return ChangeNotifierProvider(
                        create: (context) => SaraStuff(),
                        child: ChatScreen(),
                      );
                    },
                  ),
                );
              },
              child: Text("Chat with bot as guest"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder:
                        (context) => CampusNavigatorPage(
                          assetPath:
                              '${dotenv.env["REST_API"]}/asset/navigation_menu_page.html',
                        ),
                    /*
                        (context) => const CampusNavigatorPage(
                          assetPath: 'assets/campusNavigation/navigation_menu_page.html'  
                        ),
                        */
                  ),
                );
              },
              child: Text("Navigate campus"),
            ),
          ],
        ),
      ),
    );
  }
}
