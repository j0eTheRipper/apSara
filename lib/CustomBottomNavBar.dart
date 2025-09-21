import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTapped;
  
  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12,
      ),
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xFF0D1B2A), // dark blue background
      selectedItemColor: const Color(0xFF1E90FF), // lighter blue when selected
      unselectedItemColor: Colors.white, // white when not selected
      showUnselectedLabels: true,
      currentIndex: selectedIndex, // parent passes this in
      onTap: onTapped, // parent updates the index
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          activeIcon: Icon(Icons.home_filled),
          label: "Home Page",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today_outlined),
          activeIcon: Icon(Icons.calendar_today),
          label: "Calendar",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.forum_outlined),
          activeIcon: Icon(Icons.forum),
          label: "Chat with Sara",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map_outlined),
          activeIcon: Icon(Icons.map),
          label: "Campus Nav",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calculate_outlined),
          activeIcon: Icon(Icons.calculate_rounded),
          label: "GPA Calculator",
        ),
      ],
    );
  }
}
