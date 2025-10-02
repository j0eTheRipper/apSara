import 'package:ap_sara/LoggedInApp.dart';
import 'package:ap_sara/SaraChat.dart';
import 'package:ap_sara/SaraStuff.dart';
import 'package:ap_sara/google_account_signin.dart';
import 'package:ap_sara/campusNavigatorPage.dart';
import 'package:ap_sara/login_screen.dart';
import 'package:ap_sara/studentInfo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isLoggedIn = false;

Future main() async {
  await dotenv.load();
  final SharedPreferencesAsync prefs = SharedPreferencesAsync();
  isLoggedIn = await prefs.getString('apkey') != null;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'APSara',
      initialRoute: isLoggedIn ? '/login' : '/home',
      routes: {
        '/login': (context) => const Login(),
        '/home': (context) => const HomeScreen(),
      },
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
    return LoginScreen();
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
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
                          (context) => const CampusNavigatorPage(
                            assetPath:
                                'assets/campusNavigation/navigation_menu_page.html',
                          ),
                      /*
                          const HtmlViewerWeb(//HtmlViewerPage(
                            assetPath:
                                'assets/campusNavigation/navigation_menu_page.html',
                          ),
                          */
                    ),
                  );
                },
                child: Text("Navigate campus"),
              ),
              kReleaseMode == false
                  ? ElevatedButton(
                    onPressed: () async {
                      final prefs = SharedPreferencesAsync();
                      await prefs.clear();
                      if (context.mounted)
                        Navigator.popAndPushNamed(context, '/login');
                    },
                    child: Text("clear data"),
                  )
                  : Text(''),
            ],
          ),
        ),
      ),
    );
  }
}
