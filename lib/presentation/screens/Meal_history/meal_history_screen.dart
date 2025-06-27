import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:synceat/core/constants/color_constants.dart';

// Auth Service
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? get currentUser => _auth.currentUser;

  Future<void> signOut() async {
    try {
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }
      await _auth.signOut();
    } catch (e) {
      throw Exception('Error signing out: $e');
    }
  }
}

// Meal History Page
class MealHistoryPage extends StatefulWidget {
  const MealHistoryPage({super.key});

  @override
  State<MealHistoryPage> createState() => _MealHistoryPageState();
}

class _MealHistoryPageState extends State<MealHistoryPage> {
  bool isCalendarView = true;
  String selectedFilter = 'All';
  List<String> filterOptions = ['All', 'Breakfast', 'Lunch', 'Dinner'];

  // Sample meal data
  List<Map<String, dynamic>> meals = [
    {
      'name': 'Chicken Salad',
      'time': '12:00 PM',
      'image':
          'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
      'type': 'Lunch',
    },
    {
      'name': 'Oatmeal with Berries',
      'time': '8:00 AM',
      'image':
          'https://images.unsplash.com/photo-1571091718767-18b5b1457add?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
      'type': 'Breakfast',
    },
    {
      'name': 'Salmon with Asparagus',
      'time': '12:00 PM',
      'image':
          'https://images.unsplash.com/photo-1467003909585-2f8a72700288?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
      'type': 'Lunch',
    },
    {
      'name': 'Scrambled Eggs with Spinach',
      'time': '8:00 AM',
      'image':
          'https://images.unsplash.com/photo-1525351484163-7529414344d8?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
      'type': 'Breakfast',
    },
  ];

  List<Map<String, dynamic>> get filteredMeals {
    if (selectedFilter == 'All') return meals;
    return meals.where((meal) => meal['type'] == selectedFilter).toList();
  }

  Future<void> _handleLogout() async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder:
            (context) => AlertDialog(
              content: Row(
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      ColorConstants.primaryColor,
                    ),
                  ),
                  SizedBox(width: 20),
                  Text("Signing out..."),
                ],
              ),
            ),
      );

      await AuthService().signOut();
      Navigator.of(context).pop();

      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Successfully signed out'),
          backgroundColor: ColorConstants.primaryColor,
        ),
      );
    } catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error signing out: ${e.toString()}'),
          backgroundColor: ColorConstants.redAccent,
        ),
      );
    }
  }

  Future<void> _showLogoutConfirmation() async {
    return showDialog<void>(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              'Confirm Logout',
              style: TextStyle(
                color: ColorConstants.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              'Are you sure you want to sign out?',
              style: TextStyle(color: ColorConstants.textSecondary),
            ),
            actions: [
              TextButton(
                child: Text(
                  'Cancel',
                  style: TextStyle(color: ColorConstants.textSecondary),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Logout',
                  style: TextStyle(color: ColorConstants.whiteColor),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  _handleLogout();
                },
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.backgroundColor,
        elevation: 0,
        title: Text(
          'Meal History',
          style: TextStyle(
            color: ColorConstants.textPrimary,
            fontSize: isTablet ? 22 : 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: ColorConstants.textPrimary,
              size: isTablet ? 28 : 24,
            ),
            onPressed: () {
              // Handle search
            },
          ),
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: ColorConstants.textPrimary,
              size: isTablet ? 28 : 24,
            ),
            onSelected: (value) {
              if (value == 'logout') {
                _showLogoutConfirmation();
              }
            },
            itemBuilder:
                (context) => [
                  PopupMenuItem(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: ColorConstants.redAccent),
                        SizedBox(width: 8),
                        Text(
                          'Logout',
                          style: TextStyle(color: ColorConstants.redAccent),
                        ),
                      ],
                    ),
                  ),
                ],
          ),
        ],
      ),
      body: Column(
        children: [
          // View Toggle Section
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 32 : 16,
              vertical: isTablet ? 20 : 16,
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => isCalendarView = true),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: isTablet ? 16 : 12,
                      ),
                      decoration: BoxDecoration(
                        color:
                            isCalendarView
                                ? ColorConstants.cardBackground
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            color:
                                isCalendarView
                                    ? ColorConstants.primaryColor
                                    : ColorConstants.textSecondary,
                            size: isTablet ? 28 : 24,
                          ),
                          SizedBox(height: isTablet ? 8 : 4),
                          Text(
                            'Calendar',
                            style: TextStyle(
                              color:
                                  isCalendarView
                                      ? ColorConstants.primaryColor
                                      : ColorConstants.textSecondary,
                              fontSize: isTablet ? 16 : 14,
                              fontWeight:
                                  isCalendarView
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: isTablet ? 24 : 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => isCalendarView = false),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: isTablet ? 16 : 12,
                      ),
                      decoration: BoxDecoration(
                        color:
                            !isCalendarView
                                ? ColorConstants.cardBackground
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.format_list_bulleted,
                            color:
                                !isCalendarView
                                    ? ColorConstants.primaryColor
                                    : ColorConstants.textSecondary,
                            size: isTablet ? 28 : 24,
                          ),
                          SizedBox(height: isTablet ? 8 : 4),
                          Text(
                            'List',
                            style: TextStyle(
                              color:
                                  !isCalendarView
                                      ? ColorConstants.primaryColor
                                      : ColorConstants.textSecondary,
                              fontSize: isTablet ? 16 : 14,
                              fontWeight:
                                  !isCalendarView
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Divider
          Container(
            height: 1,
            color: ColorConstants.cardBackground,
            margin: EdgeInsets.symmetric(horizontal: isTablet ? 32 : 16),
          ),

          // Filter Section
          Container(
            padding: EdgeInsets.all(isTablet ? 32 : 16),
            child: Row(
              children:
                  filterOptions.map((filter) {
                    final isSelected = selectedFilter == filter;
                    return SingleChildScrollView(
                      child: Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => selectedFilter = filter),
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: isTablet ? 8 : 4,
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: isTablet ? 14 : 10,
                              horizontal: isTablet ? 20 : 12,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isSelected
                                      ? ColorConstants.primaryColor.withOpacity(
                                        0.1,
                                      )
                                      : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color:
                                    isSelected
                                        ? ColorConstants.primaryColor
                                        : ColorConstants.cardBackground,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  filter,
                                  style: TextStyle(
                                    color:
                                        isSelected
                                            ? ColorConstants.primaryColor
                                            : ColorConstants.textSecondary,
                                    fontSize: isTablet ? 16 : 14,
                                    fontWeight:
                                        isSelected
                                            ? FontWeight.w600
                                            : FontWeight.w500,
                                  ),
                                ),
                                if (isSelected) ...[
                                  SizedBox(width: 4),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: ColorConstants.primaryColor,
                                    size: isTablet ? 20 : 16,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),

          // Meals List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: isTablet ? 32 : 16),
              itemCount: filteredMeals.length + 1,
              itemBuilder: (context, index) {
                if (index == filteredMeals.length) {
                  return Container(
                    margin: EdgeInsets.all(isTablet ? 32 : 20),
                    child: TextButton(
                      onPressed: () {
                        // Handle load more
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: isTablet ? 16 : 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Load More',
                        style: TextStyle(
                          color: ColorConstants.primaryColor,
                          fontSize: isTablet ? 18 : 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }

                final meal = filteredMeals[index];
                return Container(
                  margin: EdgeInsets.only(bottom: isTablet ? 20 : 16),
                  child: Row(
                    children: [
                      // Meal Image
                      Container(
                        width: isTablet ? 70 : 60,
                        height: isTablet ? 70 : 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: ColorConstants.shadowColor,
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            meal['image'],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: ColorConstants.cardBackground,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.restaurant,
                                  color: ColorConstants.textSecondary,
                                  size: isTablet ? 30 : 24,
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      SizedBox(width: isTablet ? 20 : 16),

                      // Meal Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              meal['name'],
                              style: TextStyle(
                                fontSize: isTablet ? 20 : 18,
                                fontWeight: FontWeight.w600,
                                color: ColorConstants.textPrimary,
                              ),
                            ),
                            SizedBox(height: isTablet ? 6 : 4),
                            Text(
                              meal['time'],
                              style: TextStyle(
                                fontSize: isTablet ? 16 : 14,
                                color: ColorConstants.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Action Button
                      IconButton(
                        onPressed: () {
                          // Handle meal action
                        },
                        icon: Icon(
                          Icons.more_vert,
                          color: ColorConstants.textSecondary,
                          size: isTablet ? 24 : 20,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
