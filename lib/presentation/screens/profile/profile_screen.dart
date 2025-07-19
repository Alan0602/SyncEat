import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:synceat/core/constants/color_constants.dart';
import 'package:synceat/presentation/controller/login_screen_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;
    final controller = Provider.of<LoginScreenController>(
      context,
      listen: false,
    );

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
          'Profile',
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
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            children: [
              // Profile Image
              Container(
                width: isTablet ? 150 : 120,
                height: isTablet ? 150 : 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConstants.navBackground,
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://randomuser.me/api/portraits/women/44.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              // Name
              Text(
                'Sophia Carter',
                style: TextStyle(
                  fontSize: isTablet ? 28 : 24,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.textPrimary,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),

              // Member Since
              Text(
                'Member since Jan 2023',
                style: TextStyle(
                  fontSize: isTablet ? 16 : 14,
                  color: ColorConstants.textSecondary,
                ),
              ),
              SizedBox(height: screenHeight * 0.04),

              // Stats Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.02,
                      ),
                      padding: EdgeInsets.all(isTablet ? 20 : 16),
                      decoration: BoxDecoration(
                        color: ColorConstants.cardBackground,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: ColorConstants.shadowColor,
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            '150',
                            style: TextStyle(
                              fontSize: isTablet ? 28 : 24,
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.textPrimary,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Weight\n(lbs)',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: isTablet ? 14 : 12,
                              color: ColorConstants.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.02,
                      ),
                      padding: EdgeInsets.all(isTablet ? 20 : 16),
                      decoration: BoxDecoration(
                        color: ColorConstants.cardBackground,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: ColorConstants.shadowColor,
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            '25',
                            style: TextStyle(
                              fontSize: isTablet ? 28 : 24,
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.textPrimary,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Worko\nuts',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: isTablet ? 14 : 12,
                              color: ColorConstants.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.02,
                      ),
                      padding: EdgeInsets.all(isTablet ? 20 : 16),
                      decoration: BoxDecoration(
                        color: ColorConstants.cardBackground,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: ColorConstants.shadowColor,
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            '10',
                            style: TextStyle(
                              fontSize: isTablet ? 28 : 24,
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.textPrimary,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Goal\ns',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: isTablet ? 14 : 12,
                              color: ColorConstants.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.05),

              // Settings Section
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: isTablet ? 22 : 18,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.textPrimary,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              // Settings Items
              ListTile(
                leading: Icon(
                  Icons.notifications_outlined,
                  color: ColorConstants.textPrimary,
                  size: isTablet ? 28 : 24,
                ),
                title: Text(
                  'Notifications',
                  style: TextStyle(
                    fontSize: isTablet ? 18 : 16,
                    color: ColorConstants.textPrimary,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: ColorConstants.textSecondary,
                  size: isTablet ? 20 : 16,
                ),
                onTap: () {
                  // Navigate to notifications settings
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.shield_outlined,
                  color: ColorConstants.textPrimary,
                  size: isTablet ? 28 : 24,
                ),
                title: Text(
                  'Privacy',
                  style: TextStyle(
                    fontSize: isTablet ? 18 : 16,
                    color: ColorConstants.textPrimary,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: ColorConstants.textSecondary,
                  size: isTablet ? 20 : 16,
                ),
                onTap: () {
                  // Navigate to privacy settings
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.help_outline,
                  color: ColorConstants.textPrimary,
                  size: isTablet ? 28 : 24,
                ),
                title: Text(
                  'Help',
                  style: TextStyle(
                    fontSize: isTablet ? 18 : 16,
                    color: ColorConstants.textPrimary,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: ColorConstants.textSecondary,
                  size: isTablet ? 20 : 16,
                ),
                onTap: () {
                  // Navigate to help
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.info_outline,
                  color: ColorConstants.textPrimary,
                  size: isTablet ? 28 : 24,
                ),
                title: Text(
                  'About',
                  style: TextStyle(
                    fontSize: isTablet ? 18 : 16,
                    color: ColorConstants.textPrimary,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: ColorConstants.textSecondary,
                  size: isTablet ? 20 : 16,
                ),
                onTap: () {
                  // Navigate to about
                },
              ),
              SizedBox(height: screenHeight * 0.04),

              // Logout Button
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: ElevatedButton(
                  onPressed: () {
                    // Logout logic
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'Logout',
                            style: TextStyle(color: ColorConstants.textPrimary),
                          ),
                          content: Text(
                            'Are you sure you want to logout?',
                            style: TextStyle(
                              color: ColorConstants.textSecondary,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: ColorConstants.textSecondary,
                                ),
                              ),
                            ),
                            TextButton(
                              // Clear any stored user data/tokens here
                              // SharedPreferences prefs = await SharedPreferences.getInstance();
                              // await prefs.clear();

                              // Navigator.of(context).pushNamedAndRemoveUntil(
                              //   '/login', // Replace with your login route
                              //   (Route<dynamic> route) => false,
                              // );
                              onPressed: () async {
                                Navigator.pop(context); // close dialog
                                await controller.signOut(context);
                              },

                              child: Text(
                                'Logout',
                                style: TextStyle(
                                  color: ColorConstants.redAccent,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.navBackground,
                    foregroundColor: ColorConstants.textPrimary,
                    padding: EdgeInsets.symmetric(vertical: isTablet ? 18 : 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: isTablet ? 18 : 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
