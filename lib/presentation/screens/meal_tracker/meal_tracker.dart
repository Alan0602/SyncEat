import 'package:flutter/material.dart';
import 'package:synceat/core/constants/color_constants.dart';

class MealTracker extends StatefulWidget {
  const MealTracker({Key? key}) : super(key: key);

  @override
  State<MealTracker> createState() => _MealTrackerState();
}

class _MealTrackerState extends State<MealTracker> {
  bool _isOneWeekSelected = true;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final safeAreaTop = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with back button
            Container(
              padding: EdgeInsets.fromLTRB(
                screenWidth * 0.05,
                safeAreaTop + 10,
                screenWidth * 0.05,
                20,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: screenWidth * 0.05,
                        color: ColorConstants.textPrimary,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Progress',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.textPrimary,
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.08),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Weight Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Weight',
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          color: ColorConstants.textSecondary,
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isOneWeekSelected = true;
                              });
                            },
                            child: Text(
                              '1W',
                              style: TextStyle(
                                fontSize: screenWidth * 0.035,
                                color:
                                    _isOneWeekSelected
                                        ? ColorConstants.redAccent
                                        : ColorConstants.textSecondary,
                                fontWeight:
                                    _isOneWeekSelected
                                        ? FontWeight.w500
                                        : FontWeight.normal,
                              ),
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.04),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isOneWeekSelected = false;
                              });
                            },
                            child: Text(
                              '1M',
                              style: TextStyle(
                                fontSize: screenWidth * 0.035,
                                color:
                                    !_isOneWeekSelected
                                        ? ColorConstants.redAccent
                                        : ColorConstants.textSecondary,
                                fontWeight:
                                    !_isOneWeekSelected
                                        ? FontWeight.w500
                                        : FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  // Current Weight
                  Text(
                    '150 lbs',
                    style: TextStyle(
                      fontSize: screenWidth * 0.08,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.textPrimary,
                    ),
                  ),
                  Text(
                    '15.7 kg (1.2%)',
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: ColorConstants.textSecondary,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.03),

                  // Weight Chart
                  Container(
                    height: screenHeight * 0.25,
                    width: double.infinity,
                    child: CustomPaint(painter: WeightChartPainter()),
                  ),

                  // Days of week
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:
                        ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                            .map(
                              (day) => Text(
                                day,
                                style: TextStyle(
                                  fontSize: screenWidth * 0.03,
                                  color: ColorConstants.textSecondary,
                                ),
                              ),
                            )
                            .toList(),
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  // Weight Stats
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
                                'Starting Weight',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.035,
                                  color: ColorConstants.textSecondary,
                                ),
                              ),
                              SizedBox(height: screenWidth * 0.01),
                              Text(
                                '155 lbs',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.045,
                                  fontWeight: FontWeight.w600,
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
                                'Current Weight',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.035,
                                  color: ColorConstants.textSecondary,
                                ),
                              ),
                              SizedBox(height: screenWidth * 0.01),
                              Text(
                                '150 lbs',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.045,
                                  fontWeight: FontWeight.w600,
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
                          'Goal Weight',
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            color: ColorConstants.textSecondary,
                          ),
                        ),
                        SizedBox(height: screenWidth * 0.01),
                        Text(
                          '140 lbs',
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  // Achievements Section
                  Text(
                    'Achievements',
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.textPrimary,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  // Achievement Badges
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
                            children: [
                              Container(
                                width: screenWidth * 0.15,
                                height: screenWidth * 0.15,
                                decoration: BoxDecoration(
                                  color: Colors.amber[100],
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.local_fire_department,
                                  color: Colors.orange[700],
                                  size: screenWidth * 0.08,
                                ),
                              ),
                              SizedBox(height: screenWidth * 0.02),
                              Text(
                                '7-Day Streak',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: screenWidth * 0.03,
                                  fontWeight: FontWeight.w500,
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
                            children: [
                              Container(
                                width: screenWidth * 0.15,
                                height: screenWidth * 0.15,
                                decoration: BoxDecoration(
                                  color: Colors.blue[100],
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.emoji_events,
                                  color: Colors.blue[700],
                                  size: screenWidth * 0.08,
                                ),
                              ),
                              SizedBox(height: screenWidth * 0.02),
                              Text(
                                '14-Day Streak',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: screenWidth * 0.03,
                                  fontWeight: FontWeight.w500,
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
                      children: [
                        Container(
                          width: screenWidth * 0.15,
                          height: screenWidth * 0.15,
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.star,
                            color: Colors.green[700],
                            size: screenWidth * 0.08,
                          ),
                        ),
                        SizedBox(height: screenWidth * 0.02),
                        Text(
                          '21-Day Streak',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: screenWidth * 0.03,
                            fontWeight: FontWeight.w500,
                            color: ColorConstants.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  // Weekly Completion Rate
                  Text(
                    'Weekly Completion Rate',
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.textPrimary,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.02),

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
                          'Completion Rate',
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            color: ColorConstants.textSecondary,
                          ),
                        ),
                        SizedBox(height: screenWidth * 0.02),
                        Text(
                          '80%',
                          style: TextStyle(
                            fontSize: screenWidth * 0.08,
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.textPrimary,
                          ),
                        ),
                        Text(
                          'Last 7 weeks • 90%',
                          style: TextStyle(
                            fontSize: screenWidth * 0.03,
                            color: ColorConstants.textSecondary,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.03),

                        // Weekly bars
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            for (int i = 0; i < 7; i++)
                              Column(
                                children: [
                                  Container(
                                    width: screenWidth * 0.08,
                                    height:
                                        screenHeight *
                                        0.12 *
                                        [0.6, 0.8, 0.4, 0.9, 0.7, 0.5, 0.8][i],
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          ColorConstants.primaryColor,
                                          ColorConstants.secondaryColor,
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  SizedBox(height: screenWidth * 0.02),
                                  Text(
                                    'W${i + 1}',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.025,
                                      color: ColorConstants.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 100), // Bottom padding for navigation bar
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeightChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = ColorConstants.primaryColor
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;

    final path = Path();
    final points = [
      Offset(0, size.height * 0.7),
      Offset(size.width * 0.15, size.height * 0.6),
      Offset(size.width * 0.3, size.height * 0.8),
      Offset(size.width * 0.45, size.height * 0.4),
      Offset(size.width * 0.6, size.height * 0.5),
      Offset(size.width * 0.75, size.height * 0.3),
      Offset(size.width, size.height * 0.2),
    ];

    path.moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    canvas.drawPath(path, paint);

    // Draw points
    final pointPaint =
        Paint()
          ..color = ColorConstants.primaryColor
          ..style = PaintingStyle.fill;

    for (final point in points) {
      canvas.drawCircle(point, 4, pointPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
