import 'package:flutter/material.dart';
import 'package:synceat/core/constants/color_constants.dart';
import 'package:synceat/presentation/screens/home/home_screen.dart';
import 'package:synceat/presentation/screens/meal_tracker/meal_tracker.dart';
import 'package:synceat/presentation/screens/recipies/recipies.dart';
import 'package:synceat/presentation/screens/settings/settings.dart';
import 'package:synceat/presentation/widgets/bottombar/bottom_bar.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  final List<BottomNavItem> _navItems = [
    BottomNavItem(icon: Icons.home, 
    // label: 'Home'
    ),
    BottomNavItem(icon: Icons.restaurant_menu, 
    // label: 'Recipes'
    ),
    BottomNavItem(icon: Icons.trending_up,
    // label: 'Progress'
    ),
    BottomNavItem(icon: Icons.settings, 
    // label: 'Settings'
    ),
  ];

  final List<Widget> _pages = [
    const HomeScreen(),
    const RecipesPage(),
    const MealTracker(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: _pages[_currentIndex],
      bottomNavigationBar: AnimatedBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: _navItems,
      ),
    );
  }
}
