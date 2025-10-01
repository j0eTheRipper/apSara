import 'package:ap_sara/CGPACalculatorPage.dart';
import 'package:ap_sara/SaraChat.dart';
import 'package:ap_sara/animatedBackground.dart';
import 'package:ap_sara/campusNavigatorPage.dart';
import 'package:ap_sara/google_account_signin.dart';
import 'package:ap_sara/homePage.dart';
import 'package:ap_sara/studentInfo.dart';
import 'package:flutter/material.dart';

import 'package:ap_sara/CustomBottomNavBar.dart';
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
        assetPath: 'assets/campusNavigation/navigation_menu_page.html',
      ),
      CGPACalculatorPage(),
    ];
    
    return Stack(
      children: [
        // Do not render on the campus navigator
        // (Optimization)
        if(3!=_selectedIndex) const AnimatedBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: IndexedStack(index: _selectedIndex, children: pages),
          bottomNavigationBar: CustomBottomNavBar(
            selectedIndex: _selectedIndex,
            onTapped: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ],
    );
  }
}
