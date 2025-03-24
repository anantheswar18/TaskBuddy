import 'package:flutter/material.dart';
import 'package:think_todo_list/home/home_page.dart';
import 'package:think_todo_list/officeHome/office_home_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [HomePage(), OfficeHomePage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavBarColor = _selectedIndex == 0 ? Colors.white : Colors.black;
    final selectedItemColor = _selectedIndex == 0 ? Colors.blue : Colors.blue;
    final unselectedItemColor =
        _selectedIndex == 0 ? Colors.grey : Colors.blue.withOpacity(0.5);

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person_3_outlined),
            label: 'Personal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.badge_outlined),
            label: 'Office',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: selectedItemColor,
        unselectedItemColor: unselectedItemColor,
        backgroundColor: bottomNavBarColor,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}
