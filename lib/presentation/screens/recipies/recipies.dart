import 'package:flutter/material.dart';
import 'dart:async';

import 'package:synceat/core/constants/color_constants.dart';

class MealPlanPage extends StatefulWidget {
  const MealPlanPage({Key? key}) : super(key: key);

  @override
  State<MealPlanPage> createState() => _MealPlanPageState();
}

class _MealPlanPageState extends State<MealPlanPage> {
  Timer? _timer;
  int _hours = 3;
  int _minutes = 30;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else if (_minutes > 0) {
          _minutes--;
          _seconds = 59;
        } else if (_hours > 0) {
          _hours--;
          _minutes = 59;
          _seconds = 59;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: ColorConstants.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Meal Plan',
          style: TextStyle(
            color: ColorConstants.textPrimary,
            fontSize: isTablet ? 24 : 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breakfast Header
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Breakfast',
                      style: TextStyle(
                        fontSize: isTablet ? 28 : 24,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '8:00 AM',
                      style: TextStyle(
                        fontSize: isTablet ? 16 : 14,
                        color: ColorConstants.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              // Main Meal Image
              Container(
                width: double.infinity,
                height: screenHeight * 0.3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=800',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Meal Details
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AI-Powered Oatmeal Delight',
                      style: TextStyle(
                        fontSize: isTablet ? 26 : 22,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.textPrimary,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '350 kcal',
                      style: TextStyle(
                        fontSize: isTablet ? 18 : 16,
                        color: ColorConstants.textSecondary,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),

                    // Nutrition Info
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Protein',
                          style: TextStyle(
                            color: ColorConstants.textSecondary,
                            fontSize: isTablet ? 16 : 14,
                          ),
                        ),
                        Text(
                          '15g',
                          style: TextStyle(
                            color: ColorConstants.textPrimary,
                            fontSize: isTablet ? 16 : 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Carbs',
                          style: TextStyle(
                            color: ColorConstants.textSecondary,
                            fontSize: isTablet ? 16 : 14,
                          ),
                        ),
                        Text(
                          '40g',
                          style: TextStyle(
                            color: ColorConstants.textPrimary,
                            fontSize: isTablet ? 16 : 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Fat',
                          style: TextStyle(
                            color: ColorConstants.textSecondary,
                            fontSize: isTablet ? 16 : 14,
                          ),
                        ),
                        Text(
                          '10g',
                          style: TextStyle(
                            color: ColorConstants.textPrimary,
                            fontSize: isTablet ? 16 : 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: screenHeight * 0.04),

                    // Ingredients
                    Text(
                      'Ingredients',
                      style: TextStyle(
                        fontSize: isTablet ? 20 : 18,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.textPrimary,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      '1/2 cup rolled oats, 1 cup almond milk, 1 scoop protein powder, 1/4 cup berries, 1 tbsp chia seeds',
                      style: TextStyle(
                        fontSize: isTablet ? 16 : 14,
                        color: ColorConstants.textSecondary,
                        height: 1.5,
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.03),

                    // Instructions
                    Text(
                      'Instructions',
                      style: TextStyle(
                        fontSize: isTablet ? 20 : 18,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.textPrimary,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Combine oats and almond milk in a pot. Cook over medium heat for 5 minutes, stirring occasionally. Stir in protein powder and top with berries and chia seeds.',
                      style: TextStyle(
                        fontSize: isTablet ? 16 : 14,
                        color: ColorConstants.textSecondary,
                        height: 1.5,
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.04),

                    // Alternatives
                    Text(
                      'Alternatives',
                      style: TextStyle(
                        fontSize: isTablet ? 20 : 18,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.textPrimary,
                      ),
                    ),
                    SizedBox(height: 16),

                    // Horizontal Scroll for Alternatives
                    SizedBox(
                      height: isTablet ? 200 : 160,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            width: isTablet ? 180 : 150,
                            margin: EdgeInsets.only(right: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: isTablet ? 140 : 110,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=400',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Protein Pancakes',
                                  style: TextStyle(
                                    fontSize: isTablet ? 16 : 14,
                                    fontWeight: FontWeight.w600,
                                    color: ColorConstants.textPrimary,
                                  ),
                                ),
                                Text(
                                  '400 kcal',
                                  style: TextStyle(
                                    fontSize: isTablet ? 14 : 12,
                                    color: ColorConstants.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: isTablet ? 180 : 150,
                            margin: EdgeInsets.only(right: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: isTablet ? 140 : 110,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=400',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Greek Yogurt Bowl',
                                  style: TextStyle(
                                    fontSize: isTablet ? 16 : 14,
                                    fontWeight: FontWeight.w600,
                                    color: ColorConstants.textPrimary,
                                  ),
                                ),
                                Text(
                                  '300 kcal',
                                  style: TextStyle(
                                    fontSize: isTablet ? 14 : 12,
                                    color: ColorConstants.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: isTablet ? 180 : 150,
                            margin: EdgeInsets.only(right: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: isTablet ? 140 : 110,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        'https://images.unsplash.com/photo-1482049016688-2d3e1b311543?w=400',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Egg Toast',
                                  style: TextStyle(
                                    fontSize: isTablet ? 16 : 14,
                                    fontWeight: FontWeight.w600,
                                    color: ColorConstants.textPrimary,
                                  ),
                                ),
                                Text(
                                  '320 kcal',
                                  style: TextStyle(
                                    fontSize: isTablet ? 14 : 12,
                                    color: ColorConstants.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.03),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Swap meal logic
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Meal swapped successfully'),
                                  backgroundColor: ColorConstants.primaryColor,
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstants.navBackground,
                              foregroundColor: ColorConstants.textPrimary,
                              padding: EdgeInsets.symmetric(
                                vertical: isTablet ? 18 : 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'Swap',
                              style: TextStyle(
                                fontSize: isTablet ? 18 : 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Mark as eaten logic
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Marked as eaten'),
                                  backgroundColor: ColorConstants.primaryColor,
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstants.primaryColor,
                              foregroundColor: ColorConstants.whiteColor,
                              padding: EdgeInsets.symmetric(
                                vertical: isTablet ? 18 : 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                            child: Text(
                              'Mark as Eaten',
                              style: TextStyle(
                                fontSize: isTablet ? 18 : 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: screenHeight * 0.04),

                    // Timer
                    Container(
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: ColorConstants.cardBackground,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                _hours.toString().padLeft(2, '0'),
                                style: TextStyle(
                                  fontSize: isTablet ? 36 : 32,
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstants.primaryColor,
                                ),
                              ),
                              Text(
                                'Hours',
                                style: TextStyle(
                                  fontSize: isTablet ? 14 : 12,
                                  color: ColorConstants.textSecondary,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                _minutes.toString().padLeft(2, '0'),
                                style: TextStyle(
                                  fontSize: isTablet ? 36 : 32,
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstants.primaryColor,
                                ),
                              ),
                              Text(
                                'Minutes',
                                style: TextStyle(
                                  fontSize: isTablet ? 14 : 12,
                                  color: ColorConstants.textSecondary,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                _seconds.toString().padLeft(2, '0'),
                                style: TextStyle(
                                  fontSize: isTablet ? 36 : 32,
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstants.primaryColor,
                                ),
                              ),
                              Text(
                                'Seconds',
                                style: TextStyle(
                                  fontSize: isTablet ? 14 : 12,
                                  color: ColorConstants.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.02),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
