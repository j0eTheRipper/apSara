import 'package:ap_sara/SaraChat.dart';
import 'package:ap_sara/SaraStuff.dart';
import 'package:ap_sara/google_account_signin.dart';
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
      home: Login(),
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
              child: Text("Provide Info"),
            ),
            TextButton(
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
              child: Text("chat with bot as guest"),
            ),
          ],
        ),
      ),
    );
  }
}
