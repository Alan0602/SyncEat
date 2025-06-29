import 'package:flutter/material.dart';
import 'package:synceat/core/constants/color_constants.dart';
import 'package:synceat/presentation/screens/profile/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final safeAreaTop = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            screenWidth * 0.05,
            safeAreaTop + 20,
            screenWidth * 0.05,
            100, // Bottom padding for navigation bar
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Row(
                children: [
                  GestureDetector(
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfilePage(),
                          ),
                        ),
                    child: Container(
                      width: screenWidth * 0.12,
                      height: screenWidth * 0.12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            ColorConstants.primaryColor,
                            ColorConstants.secondaryColor,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Icon(
                        Icons.person,
                        color: ColorConstants.whiteColor,
                        size: screenWidth * 0.06,
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi, Alex',
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.w600,
                          color: ColorConstants.textPrimary,
                        ),
                      ),
                      Text(
                        'Today, May 14',
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          color: ColorConstants.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.04),

              // Day Streak Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(screenWidth * 0.05),
                decoration: BoxDecoration(
                  color: ColorConstants.cardBackground,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '3',
                      style: TextStyle(
                        fontSize: screenWidth * 0.12,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.textPrimary,
                      ),
                    ),
                    Text(
                      'Day Streak',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        color: ColorConstants.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.03),

              // Calories Progress
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(screenWidth * 0.05),
                decoration: BoxDecoration(
                  color: ColorConstants.cardBackground,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Calories',
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            color: ColorConstants.textSecondary,
                          ),
                        ),
                        Text(
                          '1200/2000',
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w500,
                            color: ColorConstants.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenWidth * 0.03),
                    Container(
                      height: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.grey[300],
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: 0.6,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            gradient: LinearGradient(
                              colors: [
                                ColorConstants.primaryColor,
                                ColorConstants.secondaryColor,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.02),
                    Text(
                      '60%',
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        color: ColorConstants.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.03),

              // Next Meal Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(screenWidth * 0.05),
                decoration: BoxDecoration(
                  color: ColorConstants.cardBackground,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Next Meal',
                            style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              color: ColorConstants.textSecondary,
                            ),
                          ),
                          SizedBox(height: screenWidth * 0.01),
                          Text(
                            'Lunch',
                            style: TextStyle(
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.w600,
                              color: ColorConstants.textPrimary,
                            ),
                          ),
                          Text(
                            '12:00 PM',
                            style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              color: ColorConstants.textSecondary,
                            ),
                          ),
                          SizedBox(height: screenWidth * 0.03),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.04,
                              vertical: screenWidth * 0.02,
                            ),
                            decoration: BoxDecoration(
                              color: ColorConstants.primaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'View',
                              style: TextStyle(
                                fontSize: screenWidth * 0.035,
                                color: ColorConstants.whiteColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: screenWidth * 0.25,
                      height: screenWidth * 0.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.amber[100],
                      ),
                      child: Icon(
                        Icons.lunch_dining,
                        size: screenWidth * 0.1,
                        color: Colors.orange[700],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.04),

              // Quick Stats Title
              Text(
                'Quick Stats',
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.textPrimary,
                ),
              ),

              SizedBox(height: screenHeight * 0.02),

              // Stats Grid
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      decoration: BoxDecoration(
                        color: ColorConstants.cardBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Protein',
                            style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              color: ColorConstants.textSecondary,
                            ),
                          ),
                          SizedBox(height: screenWidth * 0.01),
                          Text(
                            '120g',
                            style: TextStyle(
                              fontSize: screenWidth * 0.06,
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      decoration: BoxDecoration(
                        color: ColorConstants.cardBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Carbs',
                            style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              color: ColorConstants.textSecondary,
                            ),
                          ),
                          SizedBox(height: screenWidth * 0.01),
                          Text(
                            '200g',
                            style: TextStyle(
                              fontSize: screenWidth * 0.06,
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenWidth * 0.03),

              Container(
                width: screenWidth * 0.45,
                padding: EdgeInsets.all(screenWidth * 0.04),
                decoration: BoxDecoration(
                  color: ColorConstants.cardBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fat',
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        color: ColorConstants.textSecondary,
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.01),
                    Text(
                      '50g',
                      style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.04),

              // Today's Plan Title
              Text(
                'Today\'s Plan',
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.textPrimary,
                ),
              ),

              SizedBox(height: screenHeight * 0.02),

              // Meal Plan List
              ...['Breakfast', 'Lunch', 'Dinner'].asMap().entries.map((entry) {
                int index = entry.key;
                String meal = entry.value;
                List<String> calories = ['300 cal', '400 cal', '500 cal'];
                List<IconData> icons = [
                  Icons.breakfast_dining,
                  Icons.lunch_dining,
                  Icons.dinner_dining,
                ];
                List<Color> iconColors = [
                  Colors.orange,
                  Colors.green,
                  Colors.purple,
                ];

                return Container(
                  margin: EdgeInsets.only(bottom: screenHeight * 0.015),
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  decoration: BoxDecoration(
                    color: ColorConstants.cardBackground,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: screenWidth * 0.12,
                        height: screenWidth * 0.12,
                        decoration: BoxDecoration(
                          color: iconColors[index].withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          icons[index],
                          color: iconColors[index],
                          size: screenWidth * 0.06,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.04),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            meal,
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.w500,
                              color: ColorConstants.textPrimary,
                            ),
                          ),
                          Text(
                            calories[index],
                            style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              color: ColorConstants.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
