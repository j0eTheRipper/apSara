import 'package:ap_sara/CGPACalculatorPage.dart';
import 'package:ap_sara/SaraChat.dart';

import 'package:ap_sara/animatedBackground.dart';
import 'package:ap_sara/campusNavigatorPage.dart';
import 'package:ap_sara/cgpaCalculator.dart';

import 'package:ap_sara/google_account_signin.dart';
import 'package:ap_sara/homePage.dart';
import 'package:ap_sara/studentInfo.dart';
import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ap_sara/CustomBottomNavBar.dart';
import 'package:particles_flutter/particles_flutter.dart';
import 'package:provider/provider.dart';

// The logic of the app once the user is logged in.
class LoggedInApp extends StatefulWidget {
  const LoggedInApp({super.key});

  @override
  State<LoggedInApp> createState() => _LoggedInAppState();
}

// Use an enum to avoid 'magic numbers'
// for page indexes
/*
enum SwitchingPageIndex {
  homePage(0),
  coursesCalendar(1),
  saraChat(2),
  campusNavigation(3),
  gpaCalculator(4);

  final int value;
  const SwitchingPageIndex(this.value);
}
*/

class _LoggedInAppState extends State<LoggedInApp> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(onNavigate: _onItemTapped),
      ChangeNotifierProvider(
        create: (context) => GoogleCalendarStuff(),
        child: const StudentInfo(),
      ),
      ChatScreen(),
      CampusNavigatorPage(
        assetPath:'${dotenv.env["REST_API"]}/asset/navigation_menu_page.html', 
        //'assets/campusNavigation/navigation_menu_page.html',
      ),
      CGPACalculatorPage(),
    ];

    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: pages),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
