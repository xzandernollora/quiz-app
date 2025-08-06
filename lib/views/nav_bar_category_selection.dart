import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/views/leaderboard.dart';
import 'package:flutter_quiz_app/views/profile_screen.dart';
import 'package:flutter_quiz_app/views/quiz_category.dart';

class NavBarCategorySelection extends StatefulWidget {
  final int initialIndex;
  const NavBarCategorySelection({super.key, required this.initialIndex});

  @override
  State<NavBarCategorySelection> createState() =>
      _NavBarCategorySelectionState();
}

class _NavBarCategorySelectionState extends State<NavBarCategorySelection> {
  final PageStorageBucket bucket = PageStorageBucket();

  final pages = [const QuizCategory(), Leaderboard(), ProfileScreen()];

  late int selectedIndex;
  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(bucket: bucket, child: pages[selectedIndex]),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.graphic_eq),
            label: "Leaderboard",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
